# src/gui/param_tuner.py
from PyQt5.QtWidgets import QDialog, QVBoxLayout, QHBoxLayout, QLabel, QComboBox, QPushButton, QDoubleSpinBox, QSlider, QCheckBox, QMessageBox
from PyQt5.QtCore import Qt
import math
from filters import safety
from typing import Dict

class ParamTuner(QDialog):
    """
    Parameter tuner dialog.
    Enforces simple stability heuristics and writes values into global PARAMS dict
    (imported in main_window). Uses QMessageBox to warn when input would be unstable.
    """
    def __init__(self, parent, alg_name: str, PARAMS: Dict, LIMITS: Dict, PRESETS: Dict):
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

        # build controls from LIMITS[alg_name]
        for key, (lo, hi) in self.LIMITS.get(alg_name, {}).items():
            row = QHBoxLayout()
            lab = QLabel(f"{key}:")
            spn = QDoubleSpinBox()
            spn.setDecimals(6)
            spn.setRange(lo, hi)
            init_val = self.PARAMS.get(alg_name, {}).get(key, float(lo + (hi - lo) / 2.0))
            spn.setValue(float(init_val))
            spn.setSingleStep(max((hi - lo) / 1000.0, 1e-9))

            sld = QSlider(Qt.Horizontal)
            sld.setRange(0, 1000)

            use_log = (lo > 0 and hi / lo >= 1e3 and key not in ("order",))
            log_cb = QCheckBox("log")
            log_cb.setChecked(use_log)

            def value_to_slider(v, lo=lo, hi=hi, use_log=use_log):
                v = float(max(min(v, hi), lo))
                if use_log:
                    loL, hiL = math.log(lo), math.log(hi)
                    return int(round((math.log(v) - loL) / (hiL - loL) * 1000))
                else:
                    return int(round((v - lo) / (hi - lo) * 1000))

            def slider_to_value(pos, lo=lo, hi=hi, use_log=use_log):
                pos = max(min(int(pos), 1000), 0)
                if use_log:
                    loL, hiL = math.log(lo), math.log(hi)
                    return math.exp(loL + (hiL - loL) * pos / 1000.0)
                else:
                    return lo + (hi - lo) * pos / 1000.0

            sld.setValue(value_to_slider(init_val, lo, hi, use_log))

            def on_slider(v, k=key, spin=spn, lo=lo, hi=hi, log_cb=log_cb):
                val = slider_to_value(v, lo, hi, log_cb.isChecked())
                val_safe = self.enforce_stability(k, val)
                spin.blockSignals(True)
                spin.setValue(val_safe)
                spin.blockSignals(False)
                self.apply_param(k, float(spin.value()))

            sld.valueChanged.connect(on_slider)

            def on_spin(val, k=key, slider=sld, lo=lo, hi=hi, log_cb=log_cb):
                val_safe = self.enforce_stability(k, val)
                slider.blockSignals(True)
                slider.setValue(value_to_slider(val_safe, lo, hi, log_cb.isChecked()))
                slider.blockSignals(False)
                self.apply_param(k, float(val_safe))

            spn.valueChanged.connect(on_spin)

            def on_log_toggled(_state, k=key, spin=spn, slider=sld, lo=lo, hi=hi, log_cb=log_cb):
                v = float(spin.value())
                slider.blockSignals(True)
                slider.setValue(value_to_slider(v, lo, hi, log_cb.isChecked()))
                slider.blockSignals(False)

            log_cb.toggled.connect(on_log_toggled)

            row.addWidget(lab)
            row.addWidget(spn, 1)
            row.addWidget(sld, 2)
            row.addWidget(log_cb)
            lay.addLayout(row)
            self.ctrls[key] = dict(label=lab, spin=spn, slider=sld, log_cb=log_cb, lo=lo, hi=hi)

        lay.addWidget(QLabel("Notes: NLMS μ∈(0,2). AP: prefer μ < 1/order. RLS μ≈λ∈(0.9,1)."))

    def apply_preset(self):
        preset_name = self.cmb_preset.currentText()
        preset = self.PRESETS.get(self.alg, {}).get(preset_name, {})
        if not preset:
            return
        for k, v in preset.items():
            if k not in self.ctrls:
                continue
            lo = self.ctrls[k]["lo"]; hi = self.ctrls[k]["hi"]
            v_clamped = float(max(min(v, hi), lo))
            self.PARAMS[self.alg][k] = int(round(v_clamped)) if k == "order" else float(v_clamped)
            spn = self.ctrls[k]["spin"]; sld = self.ctrls[k]["slider"]; log_cb = self.ctrls[k]["log_cb"]
            sld.blockSignals(True); spn.blockSignals(True)
            spn.setValue(v_clamped)
            sld.setValue(value_to_slider := (lambda val, lo=lo, hi=hi, use_log=log_cb.isChecked(): int(round((math.log(val)-math.log(lo))/(math.log(hi)-math.log(lo))*1000)) if (lo>0 and use_log) else int(round((val-lo)/(hi-lo)*1000)))(v_clamped))
            sld.blockSignals(False); spn.blockSignals(False)
        self.parent.run_once()

    def enforce_stability(self, key, val):
        """Enforce simple stability heuristics for mu/order in the tuner UI."""
        # NLMS mu capped
        if self.alg == "NLMS" and key == "mu":
            if val > 1.95:
                QMessageBox.warning(self, "Stability limit", "NLMS μ is capped to 1.95 for safety.")
                return 1.95
            return val
        # AP: mu < 1/order
        if self.alg == "AP" and key in ("mu", "order"):
            ord_val = int(self.PARAMS.get("AP", {}).get("order", 3))
            if key == "order":
                ord_new = max(1, int(round(val)))
                self.PARAMS["AP"]["order"] = ord_new
                mu_max = max(1e-6, 1.0 / ord_new - 1e-6)
                mu_val = float(self.PARAMS["AP"].get("mu", 0.05))
                if mu_val > mu_max:
                    QMessageBox.warning(self, "Stability limit", f"AP μ adjusted to < 1/order (order={ord_new}). Setting μ to {mu_max:.6g}.")
                    self.PARAMS["AP"]["mu"] = mu_max
                return ord_new
            else:
                mu_max = max(1e-6, 1.0 / ord_val - 1e-6)
                if val > mu_max:
                    QMessageBox.warning(self, "Stability limit", f"AP μ limited to < 1/order (current order={ord_val}). Setting μ to {mu_max:.6g}.")
                    return mu_max
                return val
        # order bounds
        if key == "order":
            return max(int(round(val)), int(self.ctrls[key]["lo"]))
        return val

    def apply_param(self, key, val):
        lo = self.ctrls[key]["lo"]; hi = self.ctrls[key]["hi"]
        v = float(max(min(val, hi), lo))

        if self.alg == "NLMS" and key == "mu":
            v = min(v, 1.95)

        if self.alg == "AP" and key == "order":
            ord_new = max(1, int(round(v)))
            self.PARAMS["AP"]["order"] = ord_new
            mu_lo, mu_hi = self.LIMITS["AP"]["mu"]
            self.PARAMS["AP"]["mu"] = float(max(min(self.PARAMS["AP"].get("mu", 0.05), mu_hi), max(mu_lo, 1.0/ord_new - 1e-3)))
            if "mu" in self.ctrls:
                mu_spn = self.ctrls["mu"]["spin"]
                mu_spn.blockSignals(True)
                mu_spn.setValue(self.PARAMS["AP"]["mu"])
                mu_spn.blockSignals(False)
            self.parent.run_once()
            return

        if key == "order":
            self.PARAMS[self.alg][key] = int(round(v))
        else:
            self.PARAMS[self.alg][key] = float(v)

        self.parent.run_once()
