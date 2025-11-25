from PyQt5.QtWidgets import (
    QDialog, QVBoxLayout, QHBoxLayout, QLabel, QComboBox, QPushButton,
    QDoubleSpinBox, QSlider, QCheckBox, QMessageBox
)
from PyQt5.QtCore import Qt
import math
import numpy as np


class ParamTuner(QDialog):
    """
    Parameter tuner dialog.
    Ensures that parameters remain stable and safe.
    Updates PARAMS dict inside main_window.
    """
    def __init__(self, parent, alg_name: str, PARAMS, LIMITS, PRESETS):
        super().__init__(parent)
        self.setWindowTitle(f"Tune parameters – {alg_name}")
        self.resize(580, 460)

        self.parent = parent
        self.alg = alg_name
        self.PARAMS = PARAMS
        self.LIMITS = LIMITS
        self.PRESETS = PRESETS
        self.ctrls = {}

        lay = QVBoxLayout(self)

        # ─────────────────────────────
        # Preset Row
        # ─────────────────────────────
        top = QHBoxLayout()
        top.addWidget(QLabel("Preset:"))
        self.cmb_preset = QComboBox()
        self.cmb_preset.addItems(list(self.PRESETS.get(alg_name, {"Default": {}}).keys()))
        btn_apply = QPushButton("Apply")
        btn_apply.clicked.connect(self.apply_preset)
        top.addWidget(self.cmb_preset)
        top.addWidget(btn_apply)
        top.addStretch(1)
        lay.addLayout(top)

        # ─────────────────────────────
        # Parameter Controls
        # ─────────────────────────────
        for key, (lo, hi) in self.LIMITS.get(alg_name, {}).items():
            row = QHBoxLayout()

            lab = QLabel(f"{key}:")
            spn = QDoubleSpinBox()
            spn.setDecimals(6)
            spn.setRange(lo, hi)
            init_val = float(self.PARAMS[alg_name].get(key, (lo + hi) / 2))
            spn.setValue(init_val)
            spn.setSingleStep(max((hi - lo) / 1000.0, 1e-9))

            sld = QSlider(Qt.Horizontal)
            sld.setRange(0, 1000)

            # logarithmic slider for small ranges
            use_log = lo > 0 and hi / lo >= 1e3 and key not in ("order",)
            log_cb = QCheckBox("log")
            log_cb.setChecked(use_log)

            def value_to_slider(v, lo=lo, hi=hi, use_log=use_log):
                v = float(np.clip(v, lo, hi))
                if use_log:
                    loL, hiL = math.log(lo), math.log(hi)
                    return int(round((math.log(v) - loL) / (hiL - loL) * 1000))
                return int(round((v - lo) / (hi - lo) * 1000))

            def slider_to_value(pos, lo=lo, hi=hi, use_log=use_log):
                pos = int(np.clip(pos, 0, 1000))
                if use_log:
                    loL, hiL = math.log(lo), math.log(hi)
                    return math.exp(loL + (hiL - loL) * pos / 1000.0)
                return lo + (hi - lo) * pos / 1000.0

            sld.setValue(value_to_slider(init_val))

            # ─────────────── call-backs
            def on_slider(v, k=key, spin=spn, lo=lo, hi=hi, log_cb=log_cb):
                val = slider_to_value(v, lo, hi, log_cb.isChecked())
                val = self.enforce_stability(k, val)
                spin.blockSignals(True)
                spin.setValue(val)
                spin.blockSignals(False)
                self.apply_param(k, float(val))

            def on_spin(val, k=key, slider=sld, lo=lo, hi=hi, log_cb=log_cb):
                val = self.enforce_stability(k, val)
                slider.blockSignals(True)
                slider.setValue(value_to_slider(val, lo, hi, log_cb.isChecked()))
                slider.blockSignals(False)
                self.apply_param(k, float(val))

            spn.valueChanged.connect(on_spin)
            sld.valueChanged.connect(on_slider)

            def on_log_toggled(_state, k=key, spin=spn, slider=sld, lo=lo, hi=hi):
                slider.blockSignals(True)
                slider.setValue(value_to_slider(spin.value()))
                slider.blockSignals(False)

            log_cb.toggled.connect(on_log_toggled)

            row.addWidget(lab)
            row.addWidget(spn, 1)
            row.addWidget(sld, 2)
            row.addWidget(log_cb)
            lay.addLayout(row)

            self.ctrls[key] = dict(
                label=lab, spin=spn, slider=sld, log_cb=log_cb, lo=lo, hi=hi
            )

        lay.addWidget(QLabel("Notes: NLMS μ<2. AP μ<1/order. RLS μ≈λ∈(0.9,1)."))

    # ────────────────────────────────────────
    # Preset Application
    # ────────────────────────────────────────
    def apply_preset(self):
        preset_name = self.cmb_preset.currentText()
        preset = self.PRESETS.get(self.alg, {}).get(preset_name, {})
        if not preset:
            return

        for k, v in preset.items():
            if k not in self.ctrls:
                continue
            lo = self.ctrls[k]["lo"]
            hi = self.ctrls[k]["hi"]
            v_clamped = float(np.clip(v, lo, hi))

            self.PARAMS[self.alg][k] = int(v_clamped) if k == "order" else float(v_clamped)

            spin = self.ctrls[k]["spin"]
            sl = self.ctrls[k]["slider"]
            log_cb = self.ctrls[k]["log_cb"]

            spin.blockSignals(True)
            sl.blockSignals(True)
            spin.setValue(v_clamped)

            if log_cb.isChecked() and lo > 0:
                loL, hiL = math.log(lo), math.log(hi)
                sl_val = int(round((math.log(v_clamped) - loL) / (hiL - loL) * 1000))
            else:
                sl_val = int(round((v_clamped - lo) / (hi - lo) * 1000))

            sl.setValue(sl_val)
            spin.blockSignals(False)
            sl.blockSignals(False)

        self.parent.run_once()

    # ────────────────────────────────────────
    # Stability Enforcement
    # ────────────────────────────────────────
    def enforce_stability(self, key, val):
        # NLMS
        if self.alg == "NLMS" and key == "mu":
            if val > 1.95:
                QMessageBox.warning(self, "Stability limit", "NLMS μ is capped at 1.95.")
                return 1.95

        # AP: μ < 1/order
        if self.alg == "AP" and key in ("mu", "order"):
            order = int(self.PARAMS["AP"].get("order", 3))
            if key == "order":
                order = max(1, int(round(val)))
                self.PARAMS["AP"]["order"] = order
            mu_max = 1.0 / order - 1e-6

            if key == "mu" and val > mu_max:
                QMessageBox.warning(self, "Stability limit", f"AP μ limited to < 1/order (order={order}).")
                return mu_max

            return max(val, 1e-6)

        if key == "order":
            return max(1, int(round(val)))

        return val

    def apply_param(self, key, val):
        lo = self.ctrls[key]["lo"]
        hi = self.ctrls[key]["hi"]
        v = float(np.clip(val, lo, hi))

        # update PARAMS
        if key == "order":
            self.PARAMS[self.alg][key] = int(round(v))
        else:
            self.PARAMS[self.alg][key] = float(v)

        self.parent.run_once()
