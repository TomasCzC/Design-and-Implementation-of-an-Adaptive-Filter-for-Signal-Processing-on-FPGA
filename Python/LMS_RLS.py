import sys
import numpy as np
import padasip as pa
from PyQt5.QtWidgets import (
    QApplication, QWidget, QVBoxLayout, QHBoxLayout,
    QCheckBox, QLabel, QSlider, QPushButton, QTableWidget,
    QTableWidgetItem, QDialog
)
from PyQt5.QtCore import Qt
from matplotlib.backends.backend_qt5agg import FigureCanvasQTAgg as FigureCanvas
from matplotlib.figure import Figure

# --- basic settings ---
fs = 100000      # sampling
f0 = 5           # sine freq
T = 1.0          # signal length
n_taps = 32      # filter taps

# filter params (just picked for now)
mu_lms = 0.01
mu_nlms = 0.5
mu_rls = 0.99
eps_rls = 0.1


# make noisy sine
def make_sig(fs, f, T, m, std):
    t = np.arange(0, T, 1/fs)
    s = np.sin(2*np.pi*f*t)
    n = np.random.normal(m, std, len(t))
    x = s + n
    return t, s, x


# run adaptive filter
def run_filt(name, s, x, n, param):
    X = pa.input_from_history(x, n)
    d = s[n-1:]
    if name == "LMS":
        f = pa.filters.FilterLMS(n, mu=param)
        y, e, w = f.run(d, X)
    elif name == "NLMS":
        f = pa.filters.FilterNLMS(n, mu=param)
        y, e, w = f.run(d, X)
    elif name == "AP":
        mu, order, ifc = param
        f = pa.filters.FilterAP(n=n, order=order, mu=mu, ifc=ifc)
        y, e, w = f.run(d, X)
    elif name == "RLS":
        mu, eps = param
        f = pa.filters.FilterRLS(n=n, mu=mu, eps=eps)
        y, e, w = f.run(d, X)
    elif name == "SSLMS":
        f = pa.filters.FilterSSLMS(n, mu=param)
        y, e, w = f.run(d, X)
    elif name == "NLMF":
        f = pa.filters.FilterNLMF(n, mu=param)
        y, e, w = f.run(d, X)
    else:
        raise ValueError("unknown filter")
    return y, e, s[n-1:], x[n-1:]


# simple moving avg
def mov_avg(x, win):
    if win <= 1:
        return x
    c = np.cumsum(np.insert(x, 0, 0))
    y = (c[win:] - c[:-win]) / float(win)
    pad = np.full(win-1, y[0])
    return np.concatenate([pad, y])


# calc metrics (basic)
def get_metrics(s, x, y, e, fs, n):
    s_al = s[n-1:]
    x_al = x[n-1:]
    mse = e**2
    mse_avg = np.mean(mse[-5000:])  # avg at the end

    # SNRs
    Ps = np.mean(s_al**2)
    Pin = np.mean((x_al-s_al)**2)
    Pout = np.mean((y-s_al)**2)
    snr_in = 10*np.log10(Ps/Pin)
    snr_out = 10*np.log10(Ps/Pout)
    dsnr = snr_out - snr_in

    return {
        "mse_avg": mse_avg,
        "snr_in": snr_in,
        "snr_out": snr_out,
        "snr_impr": dsnr
    }


# --- table window ---
class ResTable(QDialog):
    def __init__(self, res):
        super().__init__()
        self.setWindowTitle("Results")
        self.resize(600, 300)

        tab = QTableWidget(self)
        tab.setRowCount(len(res))
        tab.setColumnCount(6)
        tab.setHorizontalHeaderLabels(
            ["Alg", "Params", "MSE avg", "SNR in", "SNR out", "ΔSNR"]
        )

        for r, (name, param, metr) in enumerate(res):
            tab.setItem(r, 0, QTableWidgetItem(name))
            tab.setItem(r, 1, QTableWidgetItem(str(param)))
            tab.setItem(r, 2, QTableWidgetItem(f"{metr['mse_avg']:.4e}"))
            tab.setItem(r, 3, QTableWidgetItem(f"{metr['snr_in']:.2f}"))
            tab.setItem(r, 4, QTableWidgetItem(f"{metr['snr_out']:.2f}"))
            tab.setItem(r, 5, QTableWidgetItem(f"{metr['snr_impr']:.2f}"))

        tab.resizeColumnsToContents()
        lay = QVBoxLayout(self)
        lay.addWidget(tab)


# --- main GUI ---
class MainWin(QWidget):
    def __init__(self):
        super().__init__()
        self.setWindowTitle("Adaptive filters demo")
        self.resize(1000, 1000)

        lay = QVBoxLayout(self)

        # checkboxes for algs
        cb_lay = QHBoxLayout()
        self.cb_lms = QCheckBox("LMS"); self.cb_lms.setChecked(True)
        self.cb_nlms = QCheckBox("NLMS"); self.cb_nlms.setChecked(True)
        self.cb_ap = QCheckBox("AP")
        self.cb_rls = QCheckBox("RLS")
        self.cb_sslms = QCheckBox("SSLMS")
        self.cb_nlmf = QCheckBox("NLMF")

        for cb in [self.cb_lms, self.cb_nlms, self.cb_ap, self.cb_rls, self.cb_sslms, self.cb_nlmf]:
            cb_lay.addWidget(cb)
            cb.stateChanged.connect(self.update_plot)

        lay.addLayout(cb_lay)

        # sliders for noise
        self.lab_std = QLabel("Noise std: 0.10")
        self.sld_std = QSlider(Qt.Horizontal)
        self.sld_std.setRange(0, 50)
        self.sld_std.setValue(10)

        self.lab_mean = QLabel("Noise mean: 0.00")
        self.sld_mean = QSlider(Qt.Horizontal)
        self.sld_mean.setRange(-50, 50)
        self.sld_mean.setValue(0)

        lay.addWidget(self.lab_std)
        lay.addWidget(self.sld_std)
        lay.addWidget(self.lab_mean)
        lay.addWidget(self.sld_mean)

        self.sld_std.valueChanged.connect(self.update_plot)
        self.sld_mean.valueChanged.connect(self.update_plot)
        self.cb_lms.stateChanged.connect(self.update_plot)
        self.cb_nlms.stateChanged.connect(self.update_plot)
        self.cb_rls.stateChanged.connect(self.update_plot)

        # figure
        self.fig = Figure(figsize=(8,10))
        self.canvas = FigureCanvas(self.fig)
        lay.addWidget(self.canvas)

        # btn for table
        btn = QPushButton("Show table")
        btn.clicked.connect(self.show_table)
        lay.addWidget(btn)

        self.res_cache = []
        self.update_plot()

    def update_plot(self):
        std = self.sld_std.value()/100
        mean = self.sld_mean.value()/100
        self.lab_std.setText(f"Noise std: {std:.2f}")
        self.lab_mean.setText(f"Noise mean: {mean:.2f}")

        t, s, x = make_sig(fs, f0, T, mean, std)
        self.fig.clear()
        ax1 = self.fig.add_subplot(411)
        ax2 = self.fig.add_subplot(412)
        ax3 = self.fig.add_subplot(413)
        ax4 = self.fig.add_subplot(414)

        # input
        ax1.plot(t, x, label="x = s + n")
        ax1.plot(t, s, label="s clean")
        ax1.set_title("Input"); ax1.legend(); ax1.grid(True)

        self.res_cache = []
        algs = []
        if self.cb_lms.isChecked():   algs.append(("LMS", 0.01))
        if self.cb_nlms.isChecked():  algs.append(("NLMS", 0.5))
        if self.cb_ap.isChecked():    algs.append(("AP", (0.5, 5, 0.001)))   # mu, order, ifc
        if self.cb_rls.isChecked():   algs.append(("RLS", (0.99, 0.1)))      # mu (forgetting), eps
        if self.cb_sslms.isChecked(): algs.append(("SSLMS", 0.01))
        if self.cb_nlmf.isChecked():  algs.append(("NLMF", 0.1))




        for name, param in algs:
            y, e, s_al, x_al = run_filt(name, s, x, n_taps, param)

            ax2.plot(t[n_taps-1:], y, label=name)
            ax3.plot(t[n_taps-1:], e, label=name)
            mse = e**2
            mse_smooth = mov_avg(mse, 500)
            ax4.plot(10*np.log10(mse_smooth+1e-15), label=name)

            metr = get_metrics(s, x, y, e, fs, n_taps)
            self.res_cache.append((name, param, metr))

        if algs:
            ax2.plot(t[n_taps-1:], s_al, 'k--', label="s ref")

        ax2.set_title("Filter outputs"); ax2.legend(); ax2.grid(True)
        ax3.set_title("Errors"); ax3.legend(); ax3.grid(True)
        ax4.set_title("MSE (dB)"); ax4.set_xlabel("samples"); ax4.set_ylabel("MSE [dB]")
        ax4.legend(); ax4.grid(True)

        self.fig.tight_layout()
        self.canvas.draw()

    def show_table(self):
        dlg = ResTable(self.res_cache)
        dlg.exec_()


# --- main ---
if __name__ == "__main__":
    app = QApplication(sys.argv)
    win = MainWin()
    win.show()
    sys.exit(app.exec_())
