from PyQt5.QtWidgets import QDialog, QVBoxLayout, QLabel
from matplotlib.backends.backend_qt5agg import FigureCanvasQTAgg
from matplotlib.figure import Figure
import numpy as np


class PreviewWindow(QDialog):
    def __init__(self, signal, meta, parent=None):
        super().__init__(parent)

        self.setWindowTitle("Signal Preview")
        self.resize(900, 650)

        # ================= LAYOUT =================
        layout = QVBoxLayout(self)

        # ================= INFO PANEL =================
        info = QLabel(
            f"<b>Signal type:</b> {meta.signal_type}<br>"
            f"<b>Modulation:</b> {meta.modulation or '—'}<br>"
            f"<b>SNR:</b> {meta.snr_db if meta.snr_db is not None else '—'} dB<br>"
            f"<b>Dataset:</b> {meta.dataset or '—'}<br>"
        )
        info.setWordWrap(True)
        layout.addWidget(info)

        # ================= FIGURE =================
        fig = Figure()
        canvas = FigureCanvasQTAgg(fig)
        layout.addWidget(canvas)

        ax1 = fig.add_subplot(211)
        ax2 = fig.add_subplot(212)

        # ================= TIME AXIS =================
        if meta.fs:
            t = np.arange(len(signal)) / meta.fs
            time_label = "Time [s]"
        else:
            t = np.arange(len(signal))
            time_label = "Samples"

        # ================= TIME DOMAIN =================
        sig_plot = signal.real if meta.is_complex else signal
        ax1.plot(t, sig_plot, linewidth=0.8)
        ax1.set_title("Time domain")
        ax1.set_xlabel(time_label)
        ax1.set_ylabel(f"Amplitude [{meta.amplitude_unit}]")
        ax1.grid(True, alpha=0.3)

        # ================= FFT =================
        fft = np.abs(np.fft.rfft(sig_plot))
        if meta.fs:
            freq = np.fft.rfftfreq(len(sig_plot), d=1 / meta.fs)
            freq_label = "Frequency [Hz]"
        else:
            freq = np.linspace(0, 0.5, len(fft))
            freq_label = "Normalized frequency"

        ax2.plot(freq, fft, linewidth=0.8)
        ax2.set_title("Frequency spectrum (FFT)")
        ax2.set_xlabel(freq_label)
        ax2.set_ylabel("Magnitude")
        ax2.grid(True, alpha=0.3)

        fig.tight_layout()
