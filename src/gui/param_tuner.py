from PyQt5.QtWidgets import (
    QDialog, QVBoxLayout, QHBoxLayout, QLabel,
    QDoubleSpinBox, QPushButton
)
import numpy as np


class ParamTuner(QDialog):
    def __init__(self, parent, alg, PARAMS, LIMITS, PRESETS):
        super().__init__(parent)
        self.setWindowTitle(f"Tune parameters – {alg}")
        self.alg = alg
        self.PARAMS = PARAMS
        self.LIMITS = LIMITS

        lay = QVBoxLayout(self)

        self.controls = {}

        for key, (lo, hi) in LIMITS[alg].items():
            row = QHBoxLayout()
            lab = QLabel(key)
            spin = QDoubleSpinBox()
            spin.setRange(lo, hi)
            spin.setDecimals(6)
            spin.setValue(PARAMS[alg].get(key, lo))
            spin.valueChanged.connect(
                lambda v, k=key: self._update_param(k, v)
            )

            row.addWidget(lab)
            row.addWidget(spin)
            lay.addLayout(row)

            self.controls[key] = spin

        btn = QPushButton("Close")
        btn.clicked.connect(self.accept)
        lay.addWidget(btn)

    def _update_param(self, key, value):
        lo, hi = self.LIMITS[self.alg][key]
        self.PARAMS[self.alg][key] = float(np.clip(value, lo, hi))
