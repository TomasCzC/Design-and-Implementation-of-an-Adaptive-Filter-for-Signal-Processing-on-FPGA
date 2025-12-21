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

# ---------- Unit tables ----------
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

# ======================================================
# Qt6 .ui compatibility loader
# ======================================================
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
        self._y = None
        self._fs = None
        self._signal_meta = None
        ui_path = os.path.join(os.path.dirname(__file__), "main_window.ui")
        load_ui_compat(ui_path, self)

        pg.setConfigOptions(antialias=True, background="w", foreground="k")
        self._signal_source = None  # "synthetic" | "dataset"
        # ----- stav -----
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

        # ----- parametry (SI) -----
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

        # ----- radio dataset state -----
        self.radio_X = None        # signály
        self.radio_Y = None        # třídy (ID)
        self.radio_classes = {}    # id -> název
        self.radio_class_ids = []  # dostupné ID tříd
        self.selected_radio_class = None

        self.fs_unit = "kHz"
        self.f0_unit = "Hz"
        self.T_unit = "s"

        self.comboBox_fs_unit.setCurrentText(self.fs_unit)
        self.comboBox_f0_unit.setCurrentText(self.f0_unit)
        self.comboBox_T_unit.setCurrentText(self.T_unit)

        # ----- checkboxy -----
        self.checkBox_ANC.toggled.connect(self.on_anc_toggled)
        self.checkBox_FFT.toggled.connect(self.on_fft_db_toggled)

        # ----- slider <-> lineedit -----
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

        # ----- jednotky -----
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

        self.pushButton_Alg_on_data.clicked.connect(self.run_filter_on_data)

        # ----- RUN -----
        self.pushButton_Run.clicked.connect(self.on_run_clicked)

        # ----- grafy -----
        self._init_plots()
        self._update_param_edits()
        # --- nt slider init ---
        self.slider_nt.setMinimum(1)
        self.slider_nt.setMaximum(512)   # nebo 256, podle BP
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

    def run_filter_on_data(self):
        if self._x is None:
            QMessageBox.warning(self, "No data", "Load dataset first.")
            return

        if self.current_algorithm is None:
            QMessageBox.warning(self, "No algorithm", "Select algorithm first.")
            return

        if not self.anc_enabled:
            QMessageBox.information(
                self,
                "ANC disabled",
                "Enable ANC to filter dataset signals."
            )
            return

        # ===== ONLY ECG SUPPORTED =====
        if self._signal_meta.signal_type != "ecg":
            QMessageBox.warning(
                self,
                "Unsupported signal",
                "ANC filtering is supported only for ECG signals."
            )
            return

        # ===== INPUT SIGNAL =====
        x = self._x.astype(float)
        fs = self._fs

        # ===== REFERENCE (50 Hz mains) =====
        t = np.arange(len(x)) / fs
        d = np.sin(2 * np.pi * 100 * t)

        # normalize (important for RLS stability)
        x = x / (np.std(x) + 1e-12)
        d = d / (np.std(d) + 1e-12)

        nt = int(self.gen_params["nt"])

        if nt >= len(x):
            QMessageBox.warning(
                self,
                "Invalid taps",
                "Number of taps must be smaller than signal length."
            )
            return

        # ===== ADAPTIVE FILTER =====
        X = hist_input(x, nt)
        d_eff = d[nt - 1:]

        params = enforce_runtime_stability(
            self.current_algorithm,
            PARAMS[self.current_algorithm],
            LIMITS,
        )

        y, e, _ = run_padasip_filter(
            self.current_algorithm,
            d_eff,
            X,
            params
        )

        # ===== STORE + DISPLAY =====
        self._y = y

        self.update_plots(x, y, e)
        self.update_fft(x, y)
        self.update_metrics(x, y, e, nt)

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

            layout = QVBoxLayout(container)
            layout.setContentsMargins(0, 0, 0, 0)
            layout.addWidget(plot)

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

        # načti parametry z GUI
        try:
            self.gen_params["fs"] = float(self.lineEdit_fs.text()) * FREQ_UNITS[self.fs_unit]
            self.gen_params["f0"] = float(self.lineEdit_f0.text()) * FREQ_UNITS[self.f0_unit]
            self.gen_params["T"]  = float(self.lineEdit_T.text())  * TIME_UNITS[self.T_unit]
            self.gen_params["nt"] = int(self.lineEdit_nt.text())
            self.gen_params["noise_mean"] = float(self.lineEdit_Noise_mean.text())
            self.gen_params["noise_std"]  = float(self.lineEdit_Noise_std.text())
            self.gen_params["seed"] = int(self.lineEdit_seed.text())
        except ValueError:
            QMessageBox.warning(self, "Input error", "Invalid numeric input.")
            return

        self._sanitize_gen_params()

        # === ROZHODNUTÍ PODLE ZDROJE SIGNÁLU ===
        if self._signal_source is None:
            self.generate_synthetic()
            self._synthetic_dirty = False
            return

        if self._signal_source == "synthetic":
            if self._synthetic_dirty:
                self.generate_synthetic()
                self._synthetic_dirty = False
            else:
                self.run_filter()
            return

        if self._signal_source == "dataset":
            QMessageBox.information(
                self,
                "External signal loaded",
                "Use 'Apply filter on data' for datasets."
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

        # omez rozsah
        value_unit = max(lo, min(hi, value_unit))

        # přepočet do SI
        value_si = value_unit * unit_table[unit]
        self.gen_params[param] = value_si

        # posuň slider
        slider.blockSignals(True)
        slider.setValue(int(round(value_unit)))
        slider.blockSignals(False)

        self._sanitize_gen_params()
        self._update_param_edits()

    def generate_synthetic(self):
        self._signal_source = "synthetic"
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
        self._t = np.arange(N) / self._fs


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
        if self._x is not None and hasattr(self, "_y"):
            self.update_fft(self._x, self._y)

    def _change_unit(self, param, old_unit, new_unit, table):
        value_si = self.gen_params[param]          # v SI
        value_new = value_si / table[new_unit]     # jen jiný pohled

        self._update_param_edits()                  # zobrazí nové číslo

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

        # --- SPECIÁLNÍ CHOVÁNÍ PRO ČAS ---
        if param == "T":
            # vždy zobraz 1 v nové jednotce
            value_disp = 1.0
            value_si = cfg["units"][unit] * value_disp
        else:
            # ostatní parametry se normálně přepočítají
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
        # vybere největší jednotku, kde hodnota >= 1
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

        self.run_filter()

    def _ensure_signal_loaded(self):
        if self._x is None:
            QMessageBox.warning(self, "No signal", "No signal loaded.")
            return False
        return True

    def run_filter(self):
        if self._x is None:
            return

        if not hasattr(self, "_d") or self._d is None:
            QMessageBox.information(
                self,
                "No reference signal",
                "Adaptive filtering requires a reference signal d[n]."
            )
            return

        x_raw = self._x.astype(float)
        d_raw = self._d.astype(float)

        nt = int(self.gen_params["nt"])
        if nt > len(x_raw):
            QMessageBox.warning(
                self,
                "Invalid taps",
                f"Taps ({nt}) must be <= signal length ({len(x_raw)})."
            )
            return

        # normalizace pouze pro adaptaci
        x = x_raw / (np.std(x_raw) + 1e-12)
        d = d_raw / (np.std(d_raw) + 1e-12)

        X = hist_input(x, nt)
        d_filt = d[nt - 1:]

        params = enforce_runtime_stability(
            self.current_algorithm,
            PARAMS[self.current_algorithm],
            LIMITS,
        )

        y_norm, e_norm, _ = run_padasip_filter(
            self.current_algorithm,
            d_filt,
            X,
            params
        )

        # návrat do původního měřítka
        scale = np.std(x_raw) + 1e-12
        y = y_norm * scale
        e = e_norm * scale

        self._y = y
        self.update_plots(x_raw, y, e)
        self.update_fft(x_raw, y)
        self.update_metrics(x_raw, y, e, nt)

    def update_plots(self, x, y, e):
        # ===== TIME AXIS =====
        if self._signal_source == "synthetic":
            t_sec = self._t
        else:
            fs = self._fs
            t_sec = np.arange(len(x)) / fs

        t_disp, xlabel = self._time_axis(t_sec)

        t_min = t_disp[0]
        t_max = t_disp[-1]

        # ---------- INPUT ----------
        self.plot_input.clear()
        x_plot = x.real if np.iscomplexobj(x) else x
        self.plot_input.plot(t_disp, x_plot, pen=pg.mkPen("b", width=1))
        self.plot_input.setLabel("bottom", xlabel)
        self.plot_input.setLabel("left", "Amplitude [a.u.]")
        self.plot_input.setXRange(t_min, t_max, padding=0)
        self.plot_input.getViewBox().enableAutoRange(x=False, y=True)

        # ---------- OUTPUT ----------
        self.plot_output.clear()
        y_plot = y.real if np.iscomplexobj(y) else y
        self.plot_output.plot(
            t_disp[:len(y_plot)],
            y_plot,
            pen=pg.mkPen("b", width=1)
        )
        self.plot_output.setLabel("bottom", xlabel)
        self.plot_output.setLabel("left", "Amplitude [a.u.]")
        self.plot_output.setXRange(t_min, t_max, padding=0)
        self.plot_output.getViewBox().enableAutoRange(x=False, y=True)

        # ---------- ERROR ----------
        self.plot_error.clear()
        e_plot = e.real if np.iscomplexobj(e) else e
        self.plot_error.plot(
            t_disp[:len(e_plot)],
            e_plot,
            pen=pg.mkPen("r", width=1)
        )
        self.plot_error.setLabel("bottom", xlabel)
        self.plot_error.setLabel("left", "Error [a.u.]")
        self.plot_error.setXRange(t_min, t_max, padding=0)
        self.plot_error.getViewBox().enableAutoRange(x=False, y=True)

        # ---------- MSE ----------
        self.plot_mse.clear()
        self.plot_mse.plot(
            t_disp[:len(e_plot)],
            e_plot ** 2,
            pen=pg.mkPen("k", width=1)
        )
        self.plot_mse.setLabel("bottom", xlabel)
        self.plot_mse.setLabel("left", "MSE [a.u.^2]")
        self.plot_mse.setLogMode(y=True)
        self.plot_mse.setXRange(t_min, t_max, padding=0)
        self.plot_mse.getViewBox().enableAutoRange(x=False, y=True)

    def update_fft(self, x, y):
        fs = self.gen_params["fs"]
        N = min(len(x), len(y))

        f, X = fft_mag(x[:N], fs)
        _, Y = fft_mag(y[:N], fs)

        if self.fft_db:
            X = 20 * np.log10(np.maximum(X, 1e-12))
            Y = 20 * np.log10(np.maximum(Y, 1e-12))
            y_label = "Magnitude [dB]"
        else:
            y_label = "Magnitude"

        if f[-1] >= 1e6:
            f_disp, xlabel = f / 1e6, "Frequency [MHz]"
        elif f[-1] >= 1e3:
            f_disp, xlabel = f / 1e3, "Frequency [kHz]"
        else:
            f_disp, xlabel = f, "Frequency [Hz]"

        self.plot_fft.clear()
        self.plot_fft.plot(f_disp, X, pen="b")
        self.plot_fft.plot(f_disp, Y, pen="r")
        self.plot_fft.setLabel("bottom", xlabel)
        self.plot_fft.setLabel("left", y_label)
        self.plot_fft.autoRange()

    def update_metrics(self, x, y, e, nt):
        if not hasattr(self, "_d") or self._d is None:
            self.tableWidget.clearContents()
            return

        m = compute_metrics(x, self._d, y, e, nt)

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
        path, _ = QFileDialog.getSaveFileName(
            self,
            "Save plot",
            f"{name}.png",
            "PNG image (*.png)"
        )
        if not path:
            return

        exporter = ImageExporter(plot_widget.plotItem)
        exporter.export(path)

    def save_all(self):
        directory = QFileDialog.getExistingDirectory(
            self, "Select directory to save all plots"
        )
        if not directory:
            return

        self._export(self.plot_input, os.path.join(directory, "input.png"))
        self._export(self.plot_output, os.path.join(directory, "output.png"))
        self._export(self.plot_error, os.path.join(directory, "error.png"))
        self._export(self.plot_mse, os.path.join(directory, "mse.png"))
        self._export(self.plot_fft, os.path.join(directory, "fft.png"))

    def _export(self, plot, path):
        exporter = ImageExporter(plot.plotItem)
        exporter.export(path)

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
                    signal_type="radio",
                    fs=fs,
                    time_unit="s",
                    amplitude_unit="a.u.",
                    is_complex=True,
                    modulation=info.get("selected_class")
                )

        except Exception as e:
            QMessageBox.critical(self, "Preview error", str(e))
            return

        PreviewWindow(x, meta, self).exec_()

    def open_load_signal_dialog(self):
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

        # okamžitý náhled vstupu
        self._clear_plots()

        t = np.linspace(0, len(self._x) / self._fs, len(self._x), endpoint=False)
        t_disp, xlabel = self._time_axis(t)

        x_plot = self._x.real if np.iscomplexobj(self._x) else self._x

        self.plot_input.plot(t_disp, x_plot, pen=pg.mkPen("b", width=1))
        self.plot_input.setLabel("bottom", xlabel)
        self.plot_input.setLabel("left", f"Amplitude [{meta.amplitude_unit}]")
        self.plot_input.autoRange()

        # FFT vstupu
        self.update_fft(self._x, self._x)
        self._signal_source = "dataset"
        self.tabWidget.setTabEnabled(self._param_tab_index, False)


    def reset_signal(self):
        self.gen_params["T"] = 1.0
        self._x = None
        self._y = None
        self._fs = None
        self._signal_meta = None

        # vymazání grafů
        for plot in (
            self.plot_input,
            self.plot_output,
            self.plot_error,
            self.plot_mse,
            self.plot_fft,
        ):
            plot.clear()

        # slidery na minimum
        for cfg in PARAM_UI.values():
            slider = getattr(self, cfg["slider"])
            slider.blockSignals(True)
            slider.setValue(slider.minimum())
            slider.blockSignals(False)

        # lineEdity na 0 / minimum
        self._update_param_edits()
        self.current_algorithm = None
        self._update_algorithm_buttons()
        self._signal_source = None
        self.tabWidget.setTabEnabled(self._param_tab_index, True)

        self._synthetic_dirty = False

