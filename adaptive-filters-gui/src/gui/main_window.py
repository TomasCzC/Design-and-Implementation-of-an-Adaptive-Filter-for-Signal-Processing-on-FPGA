from PyQt5 import QtWidgets
from PyQt5.QtWidgets import (
    QMainWindow, QWidget, QLabel, QComboBox, QDoubleSpinBox, QSpinBox,
    QCheckBox, QPushButton, QGridLayout, QHBoxLayout, QVBoxLayout,
    QTableWidget, QTableWidgetItem, QFileDialog, QMessageBox
)
from PyQt5.QtCore import Qt

from gui.canvases import MplCanvas, FftCanvas
from gui.param_tuner import ParamTuner

from filters.signal_generation import make_signals, hist_input
from filters.metrics import compute_metrics, moving_avg
from filters.fft_utils import fft_mag
from filters.filter_runner import run_padasip_filter, enforce_runtime_stability
from filters.safety import clamp_array, is_diverged, safe_log10_of_square

from src.config import PARAMS, LIMITS, PRESETS

import numpy as np


class MainWin(QMainWindow):
    def __init__(self):
        super().__init__()

        self.setWindowTitle("Adaptive Filters GUI — Safe Mode")
        self.resize(1280, 920)

        ctrl = QWidget()
        grid = QGridLayout(ctrl)

        r = 0
        grid.addWidget(QLabel("Algorithm"), r, 0)
        self.cmb_alg = QComboBox()
        self.cmb_alg.addItems(list(PARAMS.keys()))
        grid.addWidget(self.cmb_alg, r, 1)

        r += 1
        grid.addWidget(QLabel("Taps (nt)"), r, 0)
        self.spin_nt = QSpinBox()
        self.spin_nt.setRange(1, 512)
        self.spin_nt.setValue(32)
        grid.addWidget(self.spin_nt, r, 1)

        r += 1
        grid.addWidget(QLabel("fs [Hz]"), r, 0)
        self.spin_fs = QDoubleSpinBox()
        self.spin_fs.setRange(100.0, 192000.0)
        self.spin_fs.setValue(2000.0)
        grid.addWidget(self.spin_fs, r, 1)

        r += 1
        grid.addWidget(QLabel("f0 [Hz]"), r, 0)
        self.spin_f0 = QDoubleSpinBox()
        self.spin_f0.setRange(0.1, 5000.0)
        self.spin_f0.setValue(100.0)
        grid.addWidget(self.spin_f0, r, 1)

        r += 1
        grid.addWidget(QLabel("T [s]"), r, 0)
        self.spin_T = QDoubleSpinBox()
        self.spin_T.setRange(0.05, 20.0)
        self.spin_T.setValue(0.8)
        grid.addWidget(self.spin_T, r, 1)

        r += 1
        grid.addWidget(QLabel("Noise mean"), r, 0)
        self.spin_mean = QDoubleSpinBox()
        self.spin_mean.setRange(-2.0, 2.0)
        self.spin_mean.setValue(0.0)
        grid.addWidget(self.spin_mean, r, 1)

        r += 1
        grid.addWidget(QLabel("Noise std"), r, 0)
        self.spin_std = QDoubleSpinBox()
        self.spin_std.setRange(0.0, 2.0)
        self.spin_std.setValue(0.1)
        grid.addWidget(self.spin_std, r, 1)

        r += 1
        grid.addWidget(QLabel("Seed"), r, 0)
        self.spin_seed = QSpinBox()
        self.spin_seed.setRange(0, 999999)
        self.spin_seed.setValue(0)
        grid.addWidget(self.spin_seed, r, 1)

        r += 1
        self.cb_anc = QCheckBox("ANC mode (Adaptive Noise Canceller)")
        grid.addWidget(self.cb_anc, r, 0, 1, 2)

        r += 1
        grid.addWidget(QLabel("Preset"), r, 0)
        self.cmb_preset_main = QComboBox()
        grid.addWidget(self.cmb_preset_main, r, 1)
        self._refresh_main_presets()

        r += 1
        self.btn_apply_preset = QPushButton("Apply preset")
        grid.addWidget(self.btn_apply_preset, r, 0, 1, 2)

        r += 1
        self.btn_tune = QPushButton("\u2699 Tune parameters…")
        grid.addWidget(self.btn_tune, r, 0, 1, 2)

        r += 1
        self.btn_run = QPushButton("Run")
        grid.addWidget(self.btn_run, r, 0)
        self.btn_save = QPushButton("Save Figures…")
        grid.addWidget(self.btn_save, r, 1)

        right = QWidget()
        right_v = QVBoxLayout(right)

        self.canvas = MplCanvas(self, width=9, height=7)
        right_v.addWidget(self.canvas)

        self.fftcanvas = FftCanvas(self, width=9, height=4)
        right_v.addWidget(self.fftcanvas)

        # metrics table
        self.tbl = QTableWidget(1, 8)
        self.tbl.setHorizontalHeaderLabels([
            "MSE_end", "EMSE", "J_min", "Misadj",
            "SNR_in [dB]", "SNR_out [dB]", "ΔSNR [dB]", "N90%"
        ])
        right_v.addWidget(self.tbl)

        central = QWidget()
        main_h = QHBoxLayout(central)
        main_h.addWidget(ctrl)
        main_h.addWidget(right, 1)
        self.setCentralWidget(central)

        # connect signals
        self.btn_run.clicked.connect(self.run_once)
        self.btn_save.clicked.connect(self.save_figures)
        self.btn_tune.clicked.connect(self.open_tuner)
        self.cmb_alg.currentTextChanged.connect(self.on_alg_change)
        self.btn_apply_preset.clicked.connect(self.apply_preset_main)

        self._last_state = None
        self.run_once()

    # GUI Actions
    def _refresh_main_presets(self):
        alg = self.cmb_alg.currentText()
        self.cmb_preset_main.clear()
        self.cmb_preset_main.addItems(list(PRESETS.get(alg, {"Default": {}}).keys()))

    def on_alg_change(self, *_):
        self._refresh_main_presets()
        self.run_once()

    def open_tuner(self):
        alg = self.cmb_alg.currentText()
        dlg = ParamTuner(self, alg, PARAMS, LIMITS, PRESETS)
        dlg.exec_()

    def apply_preset_main(self):
        alg = self.cmb_alg.currentText()
        preset_name = self.cmb_preset_main.currentText()
        preset = PRESETS.get(alg, {}).get(preset_name, {})
        if not preset:
            return
        for k, v in preset.items():
            if k in PARAMS[alg]:
                lo, hi = LIMITS[alg][k]
                PARAMS[alg][k] = float(np.clip(v, lo, hi))
        self.run_once()

    # MAIN RUN FUNCTION
    def run_once(self):
        alg = self.cmb_alg.currentText()
        nt = int(self.spin_nt.value())
        fs = float(self.spin_fs.value())
        f0 = float(self.spin_f0.value())
        T = float(self.spin_T.value())
        mean = float(self.spin_mean.value())
        std = float(self.spin_std.value())
        anc = bool(self.cb_anc.isChecked())
        seed = int(self.spin_seed.value())

        t, s, x = make_signals(fs=fs, f0=f0, T=T,
                               noise_mean=mean, noise_std=std,
                               anc=anc, seed=seed)

        L = len(t)
        if nt > L:
            QMessageBox.warning(self, "Parameter error",
                                f"Taps nt ({nt}) larger than signal length ({L}).")
            nt = L
            self.spin_nt.setValue(nt)

        # ANC mode
        if anc:
            d_full, s_clean = s
            X = hist_input(x, nt)
            d = d_full[nt - 1:]
            s_ref = s_clean[nt - 1:]
            x_in = d_full[nt - 1:]

        # non-ANC
        else:
            s_clean = s
            X = hist_input(x, nt)
            d = s_clean[nt - 1:]
            s_ref = s_clean[nt - 1:]
            x_in = x[nt - 1:]

        # prepare params with stability enforcement
        params = PARAMS.get(alg, {}).copy()
        params = enforce_runtime_stability(alg, params, LIMITS)

        print(f"[DEBUG] alg={alg}, nt={nt}, mu={params.get('mu')}, order={params.get('order', None)}")

        try:
            y, e, w = run_padasip_filter(alg, d, X, params)
        except Exception as ex:
            QMessageBox.warning(self, "Filter error",
                                f"{alg} failed during run:\n{ex}\nParams: {params}")
            return

        y = clamp_array(y)
        e = clamp_array(e)

        if is_diverged(y, e):
            QMessageBox.warning(self, "Divergence detected",
                                "Filter diverged — reduce mu or adjust parameters.")
            return

        print(f"[DEBUG] max|y|={np.max(np.abs(y))}, max|e|={np.max(np.abs(e))}")

        m = compute_metrics(s, x, y, e, nt, anc=anc)

        try:
            self.redraw_main_plots(t, s, x, y, e, nt, f"{alg} {params}", anc)
            self.redraw_fft(t, s, x, y, nt, fs, f"{alg}", anc)
            self.update_table(m)
            self._last_state = dict(
                t=t, s=s, x=x, y=y, e=e, nt=nt, fs=fs, alg=alg,
                anc=anc, w=w, params=params
            )
        except Exception as ex:
            QMessageBox.warning(self, "Plot error", f"Plotting failed:\n{ex}")

    # PLOTTING
    def redraw_main_plots(self, t, s, x, y, e, nt, title, anc):
        c = self.canvas

        for ax in (c.ax1, c.ax2, c.ax3, c.ax4):
            ax.clear()

        # Inputs
        if anc:
            d_full, s_clean = s
            c.ax1.plot(t, d_full, label="d (primary)")
            c.ax1.plot(t, x, label="x (ref)")
            c.ax1.plot(t, s_clean, 'k--', label="s clean")
        else:
            c.ax1.plot(t, x, label="x (noisy)")
            c.ax1.plot(t, s, 'k--', label="s clean")

        c.ax1.set_title(f"{title} – Inputs")
        c.ax1.grid(True)
        c.ax1.legend()

        # Output
        if anc:
            s_ref = s[1][nt - 1:]
        else:
            s_ref = s[nt - 1:]

        c.ax2.plot(t[nt - 1:], y, label="y (out)")
        c.ax2.plot(t[nt - 1:], s_ref, 'k--', label="s ref")
        c.ax2.set_title("Output vs reference")
        c.ax2.grid(True)
        c.ax2.legend()

        # Error
        c.ax3.plot(t[nt - 1:], e, label="e")
        c.ax3.set_title("Error")
        c.ax3.grid(True)
        c.ax3.legend()

        # MSE (dB)
        mse_db = safe_log10_of_square(e)
        mse_db = moving_avg(mse_db, max(1, int(0.05 * len(mse_db))))
        c.ax4.plot(t[nt - 1:], mse_db, label="MSE (dB)")
        c.ax4.set_title("MSE (dB)")
        c.ax4.grid(True)
        c.ax4.legend()

        c.draw()

    # FFT Plot
    def redraw_fft(self, t, s, x, y, nt, fs, title, anc):
        ax = self.fftcanvas.ax
        ax.clear()

        if anc:
            d_full, s_clean = s
            xin = d_full[nt - 1:]
            sref = s_clean[nt - 1:]
        else:
            xin = x[nt - 1:]
            sref = s[nt - 1:]

        xin = clamp_array(xin)
        y = clamp_array(y)
        sref = clamp_array(sref)

        f1, Xin = fft_mag(xin, fs)
        f2, Y = fft_mag(y, fs)
        f3, S = fft_mag(sref, fs)

        ax.semilogy(f1, Xin, label="Input")
        ax.semilogy(f2, Y, label="Output")
        ax.semilogy(f3, S, 'k--', label="Reference s")

        ax.set_title(f"{title} – FFT magnitude")
        ax.set_xlabel("Frequency [Hz]")
        ax.set_ylabel("|X(f)|")
        ax.grid(True, which="both")
        ax.legend()

        self.fftcanvas.draw()

    # Metrics Table
    def update_table(self, m):
        self.tbl.setItem(0, 0, QTableWidgetItem(f"{m['mse']:.4e}"))
        self.tbl.setItem(0, 1, QTableWidgetItem(f"{m['emse']:.4e}"))
        self.tbl.setItem(0, 2, QTableWidgetItem(f"{m['jmin']:.4e}"))
        self.tbl.setItem(0, 3, QTableWidgetItem(f"{m['misadj']:.6f}"))
        self.tbl.setItem(0, 4, QTableWidgetItem(f"{m['snr_in']:.2f}"))
        self.tbl.setItem(0, 5, QTableWidgetItem(f"{m['snr_out']:.2f}"))
        self.tbl.setItem(0, 6, QTableWidgetItem(f"{m['dsnr']:.2f}"))
        self.tbl.setItem(0, 7, QTableWidgetItem(str(m['n90'])))
        self.tbl.resizeColumnsToContents()

    # Saving Figures
    def save_figures(self):
        if not self._last_state:
            QMessageBox.information(self, "No data",
                                    "Run simulation first.")
            return

        fn, _ = QFileDialog.getSaveFileName(
            self, "Save base name", "adaptive_output", "PNG (*.png)"
        )
        if not fn:
            return

        if not fn.lower().endswith(".png"):
            fn = fn + ".png"

        self.canvas.figure.savefig(fn, dpi=140)
        base = fn[:-4]
        self.fftcanvas.figure.savefig(base + "_FFT.png", dpi=140)
