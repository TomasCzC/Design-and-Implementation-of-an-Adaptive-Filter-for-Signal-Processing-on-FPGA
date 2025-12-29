import os
import io
import numpy as np
import pyqtgraph as pg
from pyqtgraph.exporters import ImageExporter

from PyQt5 import uic
from PyQt5.QtWidgets import (
    QDialog, QMessageBox, QTableWidgetItem,
    QVBoxLayout, QFileDialog
)
from PyQt5.QtCore import Qt

from src.gui.preview_window import PreviewWindow
from src.gui.load_signal_dialog import LoadSignalDialog
from src.gui.param_tuner import ParamTuner
from src.gui.dataset_controller import DatasetController, DatasetConfig

from src.filters.signal_generation import make_signals, hist_input
from src.filters.filter_runner import run_padasip_filter, enforce_runtime_stability
from src.filters.metrics import compute_metrics
from src.filters.fft_utils import fft_mag
from src.filters.safety import clamp_array

from src.signals.ecg_loader import load_ecg
from src.signals.csv_loader import load_csv_signal
from src.signals.radio_loader import load_radio_hdf5
from src.signals.signal_meta import SignalMeta, ecg_meta

from src.config import PARAMS, LIMITS, PRESETS

FREQ_UNITS = {
    "Hz": 1.0,
    "kHz": 1e3,
    "MHz": 1e6,
}

TIME_UNITS = {
    "s": 1.0,
    "ms": 1e-3,
    "us": 1e-6,
}

FREQ_SLIDER_RANGES = {
    "Hz":  (1, 1000),
    "kHz": (1, 1000),
    "MHz": (1, 100),
}

TIME_SLIDER_RANGES = {
    "s":  (1, 10),
    "ms": (1, 1000),
    "us": (1, 1000),
}

PARAM_UI = {
    "fs": {
        "line": "lineEdit_fs",
        "slider": "slider_fs",
        "units": FREQ_UNITS,
        "ranges": FREQ_SLIDER_RANGES,
    },
    "f0": {
        "line": "lineEdit_f0",
        "slider": "slider_f0",
        "units": FREQ_UNITS,
        "ranges": FREQ_SLIDER_RANGES,
    },
    "T": {
        "line": "lineEdit_T",
        "slider": "slider_T",
        "units": TIME_UNITS,
        "ranges": TIME_SLIDER_RANGES,
    },
    "nt": {
        "line": "lineEdit_nt",
        "slider": "slider_nt",
    },
    "noise_mean": {
        "line": "lineEdit_Noise_mean",
        "slider": "slider_noise_mean",
        "scale": 100.0,
    },
    "noise_std": {
        "line": "lineEdit_Noise_std",
        "slider": "slider_noise_std",
        "scale": 100.0,
    },
    "seed": {
        "line": "lineEdit_seed",
        "slider": "slider_seed",
    },
}

def load_ui_compat(path, baseinstance):
    with open(path, "r", encoding="utf-8") as f:
        ui_text = f.read()

    ui_text = ui_text.replace("Qt::Orientation::Horizontal", "Qt::Horizontal")
    ui_text = ui_text.replace("Qt::Orientation::Vertical", "Qt::Vertical")

    uic.loadUi(io.StringIO(ui_text), baseinstance)

class MainWin(QDialog):
    def __init__(self):
        super().__init__()

        self._x = None
        self._d = None
        self._y = None
        self._fs = None
        self.dataset_controller = None
        self._signal_meta = None
        ui_path = os.path.join(os.path.dirname(__file__), "main_window.ui")
        load_ui_compat(ui_path, self)

        self.radioButton_SysID.setChecked(True)
        self.comboReferenceSignal.setCurrentIndex(0)
        self.radioButton_EntireData.setChecked(True)

        self._read_dataset_config()

        pg.setConfigOptions(antialias=True, background="w", foreground="k")
        self._signal_source = None
        self.current_algorithm = None
        self.algorithm_buttons = {
            "LMS": self.pushButton_LMS,
            "NLMS": self.pushButton_NLMS,
            "RLS": self.pushButton_RLS,
            "AP": self.pushButton_AP,
            "SSLMS": self.pushButton_SSLMS,
            "Llncosh": self.pushButton_Llncosh,
            "GMCC": self.pushButton_GMCC,
            "GNGD": self.pushButton_GNGD,
        }

        self.dataset_mode = "System ID"
        self._last_valid_dataset_mode = "System ID"
        self.dataset_ref_mode = "None"
        self.dataset_ref_freq = 50.0
        self.dataset_delay = 1
        self.dataset_scope = "entire"
        self._segment_start = 0.0
        self._segment_duration = 0.0

        self.pushButton_Alg_on_data.clicked.connect(self.run_filter_on_data)

        self.radioButton_ANC.toggled.connect(self._on_dataset_mode_changed)
        self.radioButton_SysID.toggled.connect(self._on_dataset_mode_changed)
        self.radioButton_RCSE.toggled.connect(self._on_dataset_mode_changed)

        self.radioButton_EntireData.toggled.connect(self._on_scope_changed)
        self.radioButton_SelectedSeg.clicked.connect(self.open_segment_dialog)
        self.radioButton_SelectedSeg.toggled.connect(self._on_scope_changed)

        for alg, btn in self.algorithm_buttons.items():
            btn.clicked.connect(lambda _, a=alg: self.select_algorithm(a))

        self._alg_button_style_default = (
            "QPushButton { background-color: none; font-weight: normal; }"
        )

        self._alg_button_style_active = (
            "QPushButton { background-color: #0078d7; color: white; font-weight: bold; }"
        )

        self.anc_enabled = False
        self.fft_db = False
        self._fft_cache = None

        self.gen_params = {
            "fs": 2000.0,
            "f0": 100.0,
            "T": 1.0,
            "nt": 32,
            "noise_mean": 0.0,
            "noise_std": 0.1,
            "seed": 0,
        }
        self._param_tab_index = self.tabWidget.indexOf(self.tab_4)

        self.radio_X = None
        self.radio_Y = None
        self.radio_classes = {}
        self.radio_class_ids = []
        self.selected_radio_class = None

        self.fs_unit = "kHz"
        self.f0_unit = "Hz"
        self.T_unit = "s"

        self.comboBox_fs_unit.setCurrentText(self.fs_unit)
        self.comboBox_f0_unit.setCurrentText(self.f0_unit)
        self.comboBox_T_unit.setCurrentText(self.T_unit)

        self.checkBox_FFT.toggled.connect(self.on_fft_db_toggled)

        for param in PARAM_UI:
            cfg = PARAM_UI[param]
            slider = getattr(self, cfg["slider"])
            line = getattr(self, cfg["line"])

            slider.valueChanged.connect(
                lambda _, p=param: self._slider_to_lineedit(p)
            )
            line.editingFinished.connect(
                lambda p=param: self._lineedit_to_slider(p)
            )

        self.comboBox_fs_unit.currentTextChanged.connect(
            lambda u: self._on_unit_reset("fs", u)
        )
        self.comboBox_f0_unit.currentTextChanged.connect(
            lambda u: self._on_unit_reset("f0", u)
        )
        self.comboBox_T_unit.currentTextChanged.connect(
            lambda u: self._on_unit_reset("T", u)
        )

        self.pushButton_Reset.clicked.connect(self.reset_signal)
        self.pushButton_SaveInput.clicked.connect(
            lambda: self.save_plot(self.plot_input, "input")
        )
        self.pushButton_SaveOutput.clicked.connect(
            lambda: self.save_plot(self.plot_output, "output")
        )
        self.pushButton_SaveError.clicked.connect(
            lambda: self.save_plot(self.plot_error, "error")
        )
        self.pushButton_SaveMSE.clicked.connect(
            lambda: self.save_plot(self.plot_mse, "mse")
        )
        self.pushButton_SaveFFT.clicked.connect(
            lambda: self.save_plot(self.plot_fft, "fft")
        )
        self.pushButton_SaveAll.clicked.connect(self.save_all)

        self.pushButton_Tune_parameters.clicked.connect(self.open_tuner)

        self.pushButton_Load.clicked.connect(self.open_load_signal_dialog)

        self.pushButton_Run.clicked.connect(self.on_run_clicked)

        self._init_plots()
        self._update_param_edits()
        self.slider_nt.setMinimum(1)
        self.slider_nt.setMaximum(512)
        self.slider_nt.setValue(self.gen_params["nt"])

        self._synthetic_dirty = False

        self._x = None
        self._y = None
        self._fs = None
        self._signal_meta = None
        self.current_algorithm = None
        self._update_algorithm_buttons()

        self._clear_plots()
        self._reset_sliders_and_edits()

        self._signal_source = None

        self.tabWidget.setTabEnabled(
            self.tabWidget.indexOf(self.tab_5),
            False
        )

    def _on_scope_changed(self):
        self._read_dataset_config()

    def open_segment_dialog(self):
        if self._x is None or self._fs is None:
            QMessageBox.warning(
                self,
                "No dataset",
                "Load dataset before selecting a segment."
            )
            return

        t_max = len(self._x) / self._fs

        dlg = SegmentSelectDialog(self, self._x, self._fs, t_max)
        if dlg.exec_() != dlg.Accepted:
            return

        self._segment_start, self._segment_duration = dlg.get_segment()
        self._read_dataset_config()

        self.update_plots(self._x, self._y, np.zeros_like(self._y) if self._y is not None else np.zeros(1))

    def _build_dataset_reference(self, x, fs):
        mode = self.comboBox_reference.currentText()

        if mode.startswith("None"):
            return None

        t = np.arange(len(x)) / fs

        if mode == "Sinusoidal (single tone)":
            f0 = 50.0
            return np.sin(2 * np.pi * f0 * t)

        if mode == "Multi-tone":
            ref = np.zeros_like(x)
            for k in (1, 2, 3):
                ref += np.sin(2 * np.pi * 50.0 * k * t)
            return ref / np.max(np.abs(ref))

        if mode == "Delayed input":
            delay = min(10, len(x) // 10)
            ref = np.zeros_like(x)
            ref[delay:] = x[:-delay]
            return ref

        return None

    def run_filter_on_data(self):
        if self._x is None or self._fs is None:
            QMessageBox.warning(self, "No dataset", "Load dataset first.")
            return

        if self.current_algorithm is None:
            QMessageBox.warning(self, "No algorithm", "Select algorithm first.")
            return

        if self.dataset_controller is None:
            QMessageBox.critical(self, "Internal error", "DatasetController not initialized.")
            return

        if self.radioButton_ANC.isChecked():
            if not self._validate_anc_reference_or_rollback():
                return

        try:
            self._read_dataset_config()
        except Exception as exc:
            QMessageBox.critical(self, "Configuration error", str(exc))
            return

        try:
            x_raw = self._x.astype(float)
            x_proc, d_ref, anc_flag = self.dataset_controller.prepare(x_raw)
        except Exception as exc:
            QMessageBox.critical(self, "Dataset error", str(exc))
            return

        L = min(len(x_proc), len(d_ref))
        x_proc = x_proc[:L]
        d_ref = d_ref[:L]

        try:
            y, e = self._run_adaptive_core(
                x_raw=x_proc.astype(float),
                d_raw=d_ref.astype(float),
                fs=self._fs
            )
        except Exception as exc:
            QMessageBox.critical(self, "Filtering error", str(exc))
            return

        self._y = y

        self.update_plots(
            x=self._x,
            y=y,
            e=e
        )
        self.update_fft(self._x, y)

        self.update_metrics(
            x=x_proc,
            d=d_ref,
            y=y,
            e=e,
            nt=int(self.gen_params["nt"]),
            s_ref=d_ref if anc_flag else None
        )

    def _update_algorithm_buttons(self):
        for alg, btn in self.algorithm_buttons.items():
            if alg == self.current_algorithm:
                btn.setStyleSheet(self._alg_button_style_active)
            else:
                btn.setStyleSheet(self._alg_button_style_default)

    def _clear_plots(self):
        for plot in (
            self.plot_input,
            self.plot_output,
            self.plot_error,
            self.plot_mse,
            self.plot_fft,
        ):
            plot.clear()
            plot.setTitle("")

    def _reset_sliders_and_edits(self):
        for param, cfg in PARAM_UI.items():

            if param == "nt":
                continue

            slider = getattr(self, cfg["slider"])
            line = getattr(self, cfg["line"])

            if "ranges" in cfg:
                unit = getattr(self, f"{param}_unit")
                lo, _ = cfg["ranges"][unit]

                slider.blockSignals(True)
                lo, hi = cfg["ranges"][unit]

                slider.blockSignals(True)
                slider.setMinimum(lo)
                slider.setMaximum(hi)
                slider.setValue(int(round(self.gen_params[param] / cfg["units"][unit])))
                slider.blockSignals(False)

                line.setText(f"{self.gen_params[param] / cfg['units'][unit]:g}")

            elif "scale" in cfg:
                slider.setValue(0)
                line.setText("0")

            else:
                slider.setValue(1)
                line.setText("1")

    def _init_plots(self):
        self.plot_input = pg.PlotWidget()
        self.plot_output = pg.PlotWidget()
        self.plot_error = pg.PlotWidget()
        self.plot_mse = pg.PlotWidget()
        self.plot_fft = pg.PlotWidget()

        plots = [
            (self.plot_input, self.widget_input, "Input signal"),
            (self.plot_output, self.widget_output, "Output signal"),
            (self.plot_error, self.widget_error, "Error signal"),
            (self.plot_mse, self.widget_MSE, "Mean square error"),
            (self.plot_fft, self.widget_fft, "FFT magnitude"),
        ]

        for plot, container, title in plots:
            plot.setTitle(title)
            plot.showGrid(x=True, y=True)
            plot.getPlotItem().getViewBox().setMouseEnabled(False, False)

            layout = container.layout()
            if layout is None:
                layout = QVBoxLayout(container)
                layout.setContentsMargins(0, 0, 0, 0)

            layout.addWidget(plot)

        self.fft_legend = pg.PlotWidget()
        self.fft_legend.setMouseEnabled(False, False)
        self.fft_legend.setMenuEnabled(False)

        self.fft_legend.hideAxis("bottom")
        self.fft_legend.hideAxis("left")
        self.fft_legend.showGrid(False, False)

        self.fft_legend.setBackground("w")

        self.fft_legend.setFixedWidth(120)
        self.fft_legend.setFixedHeight(181)

        vb = self.fft_legend.getPlotItem().getViewBox()
        vb.setMouseEnabled(False, False)
        vb.setMenuEnabled(False)
        vb.setLimits(xMin=0, xMax=10, yMin=0, yMax=10)
        vb.disableAutoRange()

        legend_layout = self.widget_legend.layout()
        if legend_layout is None:
            legend_layout = QVBoxLayout(self.widget_legend)
            legend_layout.setContentsMargins(4, 4, 4, 4)

        legend_layout.addWidget(self.fft_legend)

    def _update_fft_legend(self):
        self.fft_legend.clear()

        vb = self.fft_legend.getPlotItem().getViewBox()
        vb.setRange(xRange=(0, 10), yRange=(0, 10), padding=0)

        self.fft_legend.plot(
            [1, 9], [7.5, 7.5],
            pen=pg.mkPen(color=(0, 120, 215), width=2)
        )

        txt_in = pg.TextItem(
            "Input spectrum",
            color=(0, 0, 0),
            anchor=(0.5, 0)
        )
        txt_in.setPos(5, 6.6)
        self.fft_legend.addItem(txt_in)

        self.fft_legend.plot(
            [1, 9], [3.5, 3.5],
            pen=pg.mkPen(color=(220, 0, 0), width=2)
        )

        txt_out = pg.TextItem(
            "Output spectrum",
            color=(0, 0, 0),
            anchor=(0.5, 0)
        )
        txt_out.setPos(5, 2.6)
        self.fft_legend.addItem(txt_out)

    def _slider_to_lineedit(self, param):
        cfg = PARAM_UI[param]
        slider = getattr(self, cfg["slider"])
        line = getattr(self, cfg["line"])

        value = slider.value()

        if "scale" in cfg:
            value_disp = value / cfg["scale"]
            value_si = value_disp
        elif param in ("fs", "f0", "T"):
            unit = getattr(self, f"{param}_unit")
            value_disp = value
            value_si = value * cfg["units"][unit]
        elif param == "nt":
            value_disp = int(value)
            value_si = int(value)
        else:
            value_disp = value
            value_si = value

        line.setText(f"{value_disp:g}")
        self.gen_params[param] = value_si

        if param in ("fs", "f0", "T", "noise_mean", "noise_std", "seed"):
            if self._signal_source == "synthetic":
                self._synthetic_dirty = True

    def _lineedit_to_slider(self, param):
        cfg = PARAM_UI[param]
        slider = getattr(self, cfg["slider"])
        line = getattr(self, cfg["line"])

        try:
            value = float(line.text())
        except ValueError:
            return

        if "scale" in cfg:
            slider_value = value * cfg["scale"]
            value_si = value
        elif param in ("fs", "f0", "T"):
            unit = getattr(self, f"{param}_unit")
            slider_value = value
            value_si = value * cfg["units"][unit]
        elif param == "nt":
            slider_value = int(value)
            value_si = int(value)
        else:
            slider_value = value
            value_si = value

        slider.blockSignals(True)
        slider.setValue(int(round(slider_value)))
        slider.blockSignals(False)

        self.gen_params[param] = value_si
        if param in ("fs", "f0", "T", "noise_mean", "noise_std", "seed"):
            if self._signal_source == "synthetic":
                self._synthetic_dirty = True

    def on_run_clicked(self):
        if self.current_algorithm is None:
            QMessageBox.warning(
                self,
                "No algorithm selected",
                "Select an adaptive algorithm before running."
            )
            return

        if self._signal_source in (None, "synthetic"):
            self.generate_synthetic()
            self._synthetic_dirty = False
            return


        if self._signal_source == "dataset":
            self.run_filter_on_data()
            return

        QMessageBox.information(
            self,
            "No signal",
            "Generate or load a signal first."
        )

    def on_anc_toggled(self, state):
        self.anc_enabled = state

    def _on_lineedit_changed(self, param, lineedit, slider, unit_table, slider_ranges):
        try:
            value_unit = float(lineedit.text())
        except ValueError:
            return

        unit = getattr(self, f"{param}_unit")
        lo, hi = slider_ranges[unit]

        value_unit = max(lo, min(hi, value_unit))

        value_si = value_unit * unit_table[unit]
        self.gen_params[param] = value_si

        slider.blockSignals(True)
        slider.setValue(int(round(value_unit)))
        slider.blockSignals(False)

        self._sanitize_gen_params()
        self._update_param_edits()

    def generate_synthetic(self):
        self._signal_source = "synthetic"
        self.tabWidget.setTabEnabled(
            self.tabWidget.indexOf(self.tab_5),
            False
        )
        if self.gen_params["fs"] <= 0 or self.gen_params["T"] <= 0:
            QMessageBox.warning(self, "Invalid parameters", "Invalid fs or T.")
            return

        p = self.gen_params

        x, d = make_signals(
            fs=p["fs"],
            f0=p["f0"],
            T=p["T"],
            noise_mean=p["noise_mean"],
            noise_std=p["noise_std"],
            seed=p["seed"],
        )

        self._x = x
        self._d = d
        self._fs = p["fs"]
        N = len(x)
        self._t = np.linspace(0, p["T"], N, endpoint=False)

        self._signal_meta = SignalMeta(
            signal_type="synthetic",
            fs=p["fs"],
            time_unit="s",
            amplitude_unit="a.u.",
            is_complex=False,
        )

        self.run_filter()

    def on_fft_db_toggled(self, state):
        self.fft_db = state

        if self._x is None:
            return

        if self._y is None:
            self.update_fft(self._x, self._x)
            return

        self._redraw_fft()

    def _change_unit(self, param, old_unit, new_unit, table):
        value_si = self.gen_params[param]
        value_new = value_si / table[new_unit]

        self._update_param_edits()

    def _time_axis(self, t_sec: np.ndarray):
        if len(t_sec) == 0:
            return t_sec, "Time [s]"

        T = t_sec[-1]

        if self.T_unit == "s":
            return t_sec, "Time [s]"
        elif self.T_unit == "ms":
            return t_sec * 1e3, "Time [ms]"
        else:
            return t_sec * 1e6, "Time [µs]"

    def _freq_axis(self, f):
        f_max = f[-1]

        if f_max >= 1e6:
            return f / 1e6, "Frequency [MHz]"
        elif f_max >= 1e3:
            return f / 1e3, "Frequency [kHz]"
        else:
            return f, "Frequency [Hz]"

    def select_algorithm(self, alg):
        self.current_algorithm = alg

        for name, btn in self.algorithm_buttons.items():
            if name == alg:
                btn.setStyleSheet(self._alg_button_style_active)
            else:
                btn.setStyleSheet(self._alg_button_style_default)

    def _sanitize_gen_params(self):
        p = self.gen_params

        p["fs"] = max(1.0, p["fs"])
        p["T"] = max(1e-6, p["T"])
        p["nt"] = max(1, int(p["nt"]))
        p["f0"] = max(0.0, p["f0"])
        p["noise_std"] = max(0.0, p["noise_std"])
        p["seed"] = int(p["seed"])

        nyq = 0.49 * p["fs"]
        if p["f0"] > nyq:
            p["f0"] = nyq

    def _update_time_axis_only(self):
        if self._x is None or self._fs is None:
            return

        T = self.gen_params["T"]
        t = np.linspace(0, T, len(self._x), endpoint=False)
        t_disp, xlabel = self._time_axis(t)

        for plot in (
            self.plot_input,
            self.plot_output,
            self.plot_error,
            self.plot_mse,
        ):
            plot.setLabel("bottom", xlabel)

    def _on_unit_reset(self, param, unit):
        setattr(self, f"{param}_unit", unit)

        cfg = PARAM_UI[param]
        slider = getattr(self, cfg["slider"])
        line = getattr(self, cfg["line"])

        if param == "T":
            value_disp = 1.0
            value_si = cfg["units"][unit] * value_disp
        else:
            value_si = self.gen_params[param]
            value_disp = value_si / cfg["units"][unit]

        lo, hi = cfg["ranges"][unit]
        value_disp = max(lo, min(hi, value_disp))

        slider.blockSignals(True)
        slider.setMinimum(lo)
        slider.setMaximum(hi)
        slider.setValue(int(round(value_disp)))
        slider.blockSignals(False)

        line.setText(f"{value_disp:g}")
        self.gen_params[param] = value_si

    def _update_param_edits(self):
        p = self.gen_params

        self.lineEdit_nt.setText(str(p["nt"]))

        self.lineEdit_fs.setText(
            f"{p['fs'] / FREQ_UNITS[self.fs_unit]:.6g}"
        )
        self.lineEdit_f0.setText(
            f"{p['f0'] / FREQ_UNITS[self.f0_unit]:.6g}"
        )
        self.lineEdit_T.setText(
            f"{p['T'] / TIME_UNITS[self.T_unit]:.6g}"
        )

        self.lineEdit_Noise_mean.setText(f"{p['noise_mean']:.6g}")
        self.lineEdit_Noise_std.setText(f"{p['noise_std']:.6g}")
        self.lineEdit_seed.setText(str(p["seed"]))

    def _auto_unit(self, value_si, table):
        for unit, factor in reversed(list(table.items())):
            if value_si >= factor:
                return unit
        return list(table.keys())[0]

    def _regenerate_synthetic_if_active(self):
        if self._signal_source == "synthetic":
            self.generate_synthetic()

    def open_tuner(self):
        if self.current_algorithm is None:
            QMessageBox.warning(
                self,
                "No algorithm selected",
                "Select an adaptive algorithm before tuning parameters."
            )
            return

        ParamTuner(
            self,
            self.current_algorithm,
            PARAMS,
            LIMITS,
            PRESETS
        ).exec_()

        if self._signal_source == "synthetic":
            if hasattr(self, "_d") and self._d is not None:
                self.run_filter()

        elif self._signal_source == "dataset":
            if self._x is not None:
                self.run_filter_on_data()

    def _ensure_signal_loaded(self):
        if self._x is None:
            QMessageBox.warning(self, "No signal", "No signal loaded.")
            return False
        return True

    def _run_adaptive_core(self, x_raw, d_raw, fs):
        nt = int(self.gen_params["nt"])

        if nt >= len(x_raw):
            raise ValueError(
                f"Taps ({nt}) must be smaller than signal length ({len(x_raw)})."
            )

        if self._signal_source == "synthetic":
            x = x_raw.astype(float)
            d = d_raw.astype(float)
            scale = 1.0
        else:
            scale = np.std(x_raw) + 1e-12
            x = x_raw / scale
            d = d_raw / scale

        X = hist_input(x, nt)
        d_eff = d[nt - 1:]

        params = enforce_runtime_stability(
            self.current_algorithm,
            PARAMS[self.current_algorithm],
            LIMITS,
        )

        y_norm, e_norm, _ = run_padasip_filter(
            self.current_algorithm,
            d_eff,
            X,
            params
        )

        y = y_norm * scale
        e = e_norm * scale

        return y, e

    def run_filter(self):
        if not hasattr(self, "_d") or self._d is None:
            QMessageBox.warning(
                self,
                "No reference signal",
                "Synthetic reference signal is not available."
            )
            return

        if self._x is None:
            QMessageBox.warning(
                self,
                "No signal",
                "Synthetic signal is not available."
            )
            return

        try:
            y, e = self._run_adaptive_core(
                x_raw=self._x.astype(float),
                d_raw=self._d.astype(float),
                fs=self._fs
            )
        except Exception as exc:
            QMessageBox.critical(self, "Filtering error", str(exc))
            return

        self._y = y

        x_display = self._d if self._signal_source == "synthetic" else self._x

        self.update_plots(
            x=x_display,
            y=y,
            e=e
        )
        self.update_fft(x_display, y)

        self.update_metrics(
            x=self._x,
            d=self._d,
            y=y,
            e=e,
            nt=int(self.gen_params["nt"]),
            s_ref=self._d
        )

    def update_plots(self, x, y, e):
        import numpy as np
        import pyqtgraph as pg
        from src.filters.safety import clamp_array, safe_square

        if x is None or y is None or e is None:
            return

        fs = self._fs

        x = clamp_array(x)
        y = clamp_array(y)
        e = clamp_array(e)

        x_plot = x.real if np.iscomplexobj(x) else x
        y_plot = y.real if np.iscomplexobj(y) else y
        e_plot = e.real if np.iscomplexobj(e) else e

        mse = safe_square(e_plot)

        t_input = np.arange(len(x_plot)) / fs
        t_out = np.arange(len(y_plot)) / fs

        self.plot_input.clear()
        self.plot_input.setTitle("Input signal x[n]")
        self.plot_input.plot(
            t_input,
            x_plot,
            pen=pg.mkPen("b", width=1)
        )
        self.plot_input.setLabel("bottom", "Time [s]")
        self.plot_input.setLabel("left", "Amplitude [a.u.]")
        self.plot_input.autoRange()

        if (
            self._signal_source == "dataset"
            and self.radioButton_SelectedSeg.isChecked()
            and self.dataset_controller is not None
        ):
            cfg = self.dataset_controller.config
            if cfg.segment_duration and cfg.segment_duration > 0:
                t_start = cfg.segment_start
                t_end = cfg.segment_start + cfg.segment_duration
                pen = pg.mkPen(color="k", style=pg.QtCore.Qt.DashLine, width=2)
                self.plot_input.addLine(x=t_start, pen=pen)
                self.plot_input.addLine(x=t_end, pen=pen)

        self.plot_output.clear()
        self.plot_output.setTitle("Filter output y[n]")
        self.plot_output.plot(
            t_out,
            y_plot,
            pen=pg.mkPen("b", width=1)
        )
        self.plot_output.setLabel("bottom", "Time [s]")
        self.plot_output.setLabel("left", "Amplitude [a.u.]")
        self.plot_output.autoRange()

        self.plot_error.clear()
        self.plot_error.setTitle("Error signal e[n] = d[n] − y[n]")
        self.plot_error.plot(
            t_out,
            e_plot,
            pen=pg.mkPen("r", width=1)
        )
        self.plot_error.setLabel("bottom", "Time [s]")
        self.plot_error.setLabel("left", "Error [a.u.]")
        self.plot_error.autoRange()

        self.plot_mse.clear()
        self.plot_mse.setTitle("Mean squared error e²[n]")
        self.plot_mse.plot(
            t_out,
            mse,
            pen=pg.mkPen("k", width=1)
        )
        self.plot_mse.setLabel("bottom", "Time [s]")
        self.plot_mse.setLabel("left", "MSE [a.u.^2]")
        self.plot_mse.setLogMode(y=True)
        self.plot_mse.autoRange()

    def update_fft(self, x, y):
        x = clamp_array(x)
        y = clamp_array(y)

        fs = self._fs
        N = min(len(x), len(y))

        f, X = fft_mag(x[:N], fs)
        _, Y = fft_mag(y[:N], fs)

        self._fft_cache = (f, X, Y)

        self._redraw_fft()

    def _redraw_fft(self):
        if self._fft_cache is None:
            return

        f, X, Y = self._fft_cache

        if self.fft_db:
            Xp = 20 * np.log10(np.maximum(X, 1e-12))
            Yp = 20 * np.log10(np.maximum(Y, 1e-12))
            y_label = "Magnitude [dB]"
        else:
            Xp = X
            Yp = Y
            y_label = "Magnitude"

        if f[-1] >= 1e3:
            f_disp = f / 1e3
            xlabel = "Frequency [kHz]"
        else:
            f_disp = f
            xlabel = "Frequency [Hz]"

        self.plot_fft.clear()
        self.plot_fft.plot(
            f_disp, Xp,
            pen=pg.mkPen("b", width=1),
            name="Input spectrum |X(f)|"
        )
        self.plot_fft.plot(
            f_disp, Yp,
            pen=pg.mkPen("r", width=1),
            name="Output spectrum |Y(f)|"
        )
        self.plot_fft.setTitle("Magnitude spectrum (FFT)")
        self.plot_fft.setLabel("bottom", xlabel)
        self.plot_fft.setLabel("left", y_label)
        self.plot_fft.autoRange()
        self._update_fft_legend()

    def update_metrics(self, *, x, d, y, e, nt, s_ref=None):
        x = clamp_array(x)
        d = clamp_array(d)
        y = clamp_array(y)
        e = clamp_array(e)
        if s_ref is not None:
            s_ref = clamp_array(s_ref)

        m = compute_metrics(
            x=x,
            d=d,
            y=y,
            e=e,
            nt=nt,
            s_ref=s_ref
        )

        values = [
            m["mse"],
            m["emse"],
            m["jmin"],
            m["misadj"],
            m["snr_in"],
            m["snr_out"],
            m["dsnr"],
            m["n90"],
        ]

        for col, val in enumerate(values):
            item = QTableWidgetItem(f"{val:.4g}")
            item.setTextAlignment(Qt.AlignCenter)
            self.tableWidget.setItem(0, col, item)

    def save_plot(self, plot_widget, name):
        from pyqtgraph.exporters import ImageExporter
        from PyQt5.QtWidgets import QFileDialog
        import numpy as np
        import os

        path, filt = QFileDialog.getSaveFileName(
            self,
            "Save plot",
            f"{name}.png",
            "PNG image (*.png);;CSV data (*.csv)"
        )

        if not path:
            return

        if path.lower().endswith(".csv"):
            items = plot_widget.getPlotItem().listDataItems()
            if not items:
                QMessageBox.warning(self, "Export error", "No data to export.")
                return

            xdata, ydata = items[0].getData()

            if xdata is None or ydata is None:
                QMessageBox.warning(self, "Export error", "Invalid plot data.")
                return

            data = np.column_stack([xdata, ydata])
            np.savetxt(
                path,
                data,
                delimiter=",",
                header="x,y",
                comments=""
            )
            return

        if not path.lower().endswith(".png"):
            path += ".png"

        exporter = ImageExporter(plot_widget.plotItem)
        exporter.export(path)

    def save_all(self):
        directory = QFileDialog.getExistingDirectory(
            self, "Select directory to save all plots"
        )
        if not directory:
            return

        plots = {
            "input": self.plot_input,
            "output": self.plot_output,
            "error": self.plot_error,
            "mse": self.plot_mse,
            "fft": self.plot_fft,
        }

        for name, plot in plots.items():
            png_path = os.path.join(directory, f"{name}.png")
            exporter = ImageExporter(plot.plotItem)
            exporter.export(png_path)

            items = plot.getPlotItem().listDataItems()
            if not items:
                continue

            xdata, ydata = items[0].getData()
            if xdata is None or ydata is None:
                continue

            csv_path = os.path.join(directory, f"{name}.csv")
            data = np.column_stack([xdata, ydata])
            np.savetxt(
                csv_path,
                data,
                delimiter=",",
                header="x,y",
                comments=""
            )

    def preview_signal(self, info):
        try:
            if info["signal_type"] == "ECG":
                if info["format"].startswith("WFDB"):
                    x, fs = load_ecg(info["files"][0])
                    meta = ecg_meta(fs)
                else:
                    x, fs = load_csv_signal(info["files"][0])
                    meta = SignalMeta("ecg_csv", fs, "s", "a.u.", False)

            elif info["signal_type"] == "Radio":
                class_index = info.get("class_index")

                if class_index is None or class_index < 0:
                    raise ValueError("No radio class selected")

                x, fs = load_radio_hdf5(
                    path=info["files"][0],
                    class_id=class_index,
                    index=0
                )

                meta = SignalMeta(
                    signal_type="ecg",
                    fs=fs,
                    time_unit="s",
                    amplitude_unit="a.u.",
                    is_complex=False,
                    dataset="CSV"
                )

        except Exception as e:
            QMessageBox.critical(self, "Preview error", str(e))
            return

        PreviewWindow(x, meta, self).exec_()

    def open_load_signal_dialog(self):
        self._signal_source = "dataset"

        self.tabWidget.setTabEnabled(
            self.tabWidget.indexOf(self.tab_5),
            True
        )

        dlg = LoadSignalDialog(self)
        dlg.preview_callback = self.preview_signal

        if dlg.exec_() != dlg.Accepted:
            return

        info = dlg.result

        try:
            if info["signal_type"] == "ECG":

                if info["format"].startswith("WFDB"):
                    x, fs = load_ecg(info["files"][0])
                    meta = ecg_meta(fs)

                elif info["format"] == "CSV":
                    x, fs = load_csv_signal(info["files"][0])
                    meta = SignalMeta("ecg_csv", fs, "s", "a.u.", False)

                else:
                    raise ValueError("Unknown ECG format")

            elif info["signal_type"] == "Radio":
                radio = info.get("radio")

                if radio is None or radio.get("class_id") is None:
                    raise ValueError("No radio class selected")

                class_id = radio["class_id"]

                x, fs = load_radio_hdf5(
                    path=info["files"][0],
                    class_id=class_id
                )

                meta = SignalMeta(
                    signal_type="radio",
                    fs=fs,
                    time_unit="s",
                    amplitude_unit="a.u.",
                    is_complex=True,
                )

            else:
                raise ValueError("Unknown signal type")

        except Exception as e:
            QMessageBox.critical(self, "Load error", str(e))
            return

        self._x = x
        self._fs = fs
        self._signal_meta = meta
        self.dataset_controller = DatasetController(fs=self._fs)
        self._read_dataset_config()

        self._clear_plots()

        t = np.linspace(0, len(self._x) / self._fs, len(self._x), endpoint=False)
        t_disp, xlabel = self._time_axis(t)

        x_plot = self._x.real if np.iscomplexobj(self._x) else self._x

        self.plot_input.plot(t_disp, x_plot, pen=pg.mkPen("b", width=1))
        self.plot_input.setLabel("bottom", xlabel)
        self.plot_input.setLabel("left", f"Amplitude [{meta.amplitude_unit}]")
        self.plot_input.autoRange()

        self.update_fft(self._x, self._x)
        self._signal_source = "dataset"
        self.tabWidget.setTabEnabled(self._param_tab_index, False)

    def _read_dataset_config(self):
        if self.radioButton_ANC.isChecked():
            mode = "ANC"
        elif self.radioButton_SysID.isChecked():
            mode = "System ID"
        else:
            mode = "Relative"

        ref_text = self.comboReferenceSignal.currentText()
        if ref_text.startswith("None"):
            reference_type = "None"
        elif ref_text.startswith("Sinus"):
            reference_type = "Sinusoidal"
        elif ref_text.startswith("Multi"):
            reference_type = "Multi"
        elif ref_text.startswith("Delayed"):
            reference_type = "Delayed"
        else:
            reference_type = "None"

        if self.radioButton_SelectedSeg.isChecked():
            segment_start = getattr(self, "_segment_start", 0.0)
            segment_duration = getattr(self, "_segment_duration", 0.0)
        else:
            segment_start = 0.0
            segment_duration = 0.0

        if self._signal_meta and self._signal_meta.signal_type == "ecg":
            ref_freq = 50.0
        else:
            ref_freq = None

        config = DatasetConfig(
            mode=mode,
            reference_type=reference_type,
            ref_freq=ref_freq,
            ref_amp=1.0,
            ref_phase=0.0,
            delay=1,
            segment_start=segment_start,
            segment_duration=segment_duration,
            smooth_mse=False,
        )

        if self.dataset_controller is not None:
            self.dataset_controller.configure(config)

    def _validate_anc_reference_or_rollback(self):
        if not self.radioButton_ANC.isChecked():
            return True

        ref_text = self.comboReferenceSignal.currentText()
        if ref_text.startswith("None"):
            QMessageBox.warning(
                self,
                "Invalid ANC configuration",
                "Active Noise Cancellation (ANC) requires a reference signal.\n\n"
                "Please select a reference signal or use System ID / RCSE mode."
            )

            if self._last_valid_dataset_mode == "System ID":
                self.radioButton_SysID.setChecked(True)
            else:
                self.radioButton_RCSE.setChecked(True)

            return False

        return True
    
    def _on_dataset_mode_changed(self):
        if self.radioButton_ANC.isChecked():
            if not self._validate_anc_reference_or_rollback():
                return

            self._last_valid_dataset_mode = "ANC"
            self._read_dataset_config()
            return

        if self.radioButton_SysID.isChecked():
            self._last_valid_dataset_mode = "System ID"
            self._read_dataset_config()
            return

        if self.radioButton_RCSE.isChecked():
            self._last_valid_dataset_mode = "Relative"
            self._read_dataset_config()
            return

    def reset_signal(self):
        self._x = None
        self._d = None
        self._y = None
        self._fs = None
        self._signal_meta = None
        self.dataset_controller = None
        self._signal_source = None
        self.current_algorithm = None
        self._synthetic_dirty = False

        self.radioButton_SysID.setChecked(True)
        self.comboReferenceSignal.setCurrentIndex(0)
        self.radioButton_EntireData.setChecked(True)

        self.tabWidget.setTabEnabled(self._param_tab_index, True)
        self.tabWidget.setTabEnabled(
            self.tabWidget.indexOf(self.tab_5),
            False
        )

        self._update_algorithm_buttons()

        self.gen_params = {
            "fs": 2000.0,
            "f0": 100.0,
            "T": 1.0,
            "nt": 32,
            "noise_mean": 0.0,
            "noise_std": 0.1,
            "seed": 0,
        }

        self._update_param_edits()
        self._reset_sliders_and_edits()

        self._clear_plots()
        if hasattr(self, "fft_legend"):
            self.fft_legend.clear()


class SegmentSelectDialog(QDialog):
    def __init__(self, parent, x, fs, t_max):
        super().__init__(parent)

        self.setWindowTitle("Select dataset segment")
        self.x = x
        self.fs = fs
        self.t_max = float(t_max)

        self.start = 0.0
        self.end = self.t_max

        layout = QVBoxLayout(self)

        self.plot = pg.PlotWidget()
        self.plot.setFixedHeight(300)
        layout.addWidget(self.plot)

        self.slider_start = pg.QtWidgets.QSlider(Qt.Horizontal)
        self.slider_end = pg.QtWidgets.QSlider(Qt.Horizontal)

        self.slider_start.setRange(0, int(self.t_max))
        self.slider_end.setRange(1, int(self.t_max))

        self.slider_start.setValue(0)
        self.slider_end.setValue(int(self.t_max))

        layout.addWidget(pg.QtWidgets.QLabel("Segment start [s]"))
        layout.addWidget(self.slider_start)
        self.label_start = pg.QtWidgets.QLabel("Start: 0.0 s")
        layout.addWidget(self.label_start)

        layout.addWidget(pg.QtWidgets.QLabel("Segment end [s]"))
        layout.addWidget(self.slider_end)
        self.label_end = pg.QtWidgets.QLabel(f"End: {self.t_max:.1f} s")
        layout.addWidget(self.label_end)

        btn_ok = pg.QtWidgets.QPushButton("OK")
        btn_ok.clicked.connect(self.accept)
        layout.addWidget(btn_ok)

        self.slider_start.valueChanged.connect(self._update_labels)
        self.slider_end.valueChanged.connect(self._update_labels)

        self._init_plot()
        self._update_labels()

    def _init_plot(self):
        self.plot.clear()

        t = np.arange(len(self.x)) / self.fs

        self.plot.plot(
            t,
            self.x,
            pen=pg.mkPen("b", width=1),
            name="Input signal"
        )

        self.plot.setLabel("bottom", "Time [s]")
        self.plot.setLabel("left", "Amplitude [a.u.]")
        self.plot.showGrid(x=True, y=True)

        self.plot.getPlotItem().getViewBox().setMouseEnabled(False, False)

        self.line_start = pg.InfiniteLine(
            angle=90,
            movable=False,
            pen=pg.mkPen("r", style=Qt.DashLine, width=2)
        )

        self.line_end = pg.InfiniteLine(
            angle=90,
            movable=False,
            pen=pg.mkPen("r", style=Qt.DashLine, width=2)
        )

        self.plot.addItem(self.line_start)
        self.plot.addItem(self.line_end)

        self.line_start.setValue(self.start)
        self.line_end.setValue(self.end)

    def _update_labels(self):
        start = float(self.slider_start.value())
        end = float(self.slider_end.value())

        self.start = start
        self.end = end

        self.label_start.setText(f"Start: {start:.1f} s")
        self.label_end.setText(f"End: {end:.1f} s")

        if hasattr(self, "line_start") and hasattr(self, "line_end"):
            self.line_start.setValue(start)
            self.line_end.setValue(end)

        if start >= end:
            self.label_end.setText("End: invalid (must be > start)")

    def get_segment(self):
        start = float(self.start)
        end = float(self.end)

        if start < 0.0:
            raise ValueError("Segment start must be >= 0 s.")

        if end <= start:
            raise ValueError("Segment end must be greater than segment start.")

        if end > self.t_max:
            raise ValueError("Segment end exceeds signal duration.")

        segment_start = start
        segment_duration = end - start

        return segment_start, segment_duration