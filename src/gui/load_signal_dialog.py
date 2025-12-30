import json
import os

from PyQt5.QtWidgets import (
    QDialog, QLabel, QComboBox, QPushButton,
    QVBoxLayout, QHBoxLayout, QFileDialog,
    QLineEdit, QMessageBox, QSpinBox
)


class LoadSignalDialog(QDialog):
    def __init__(self, parent=None):
        super().__init__(parent)

        self.setWindowTitle("Load Signal")
        self.setModal(True)
        self.setFixedWidth(520)

        self.result = None
        self.preview_callback = None

        self.cmb_signal_type = QComboBox()
        self.cmb_signal_type.addItems(["ECG", "Radio"])
        self.cmb_signal_type.currentTextChanged.connect(
            self._on_signal_type_changed
        )

        self.cmb_format = QComboBox()
        self.cmb_format.currentTextChanged.connect(
            self._on_format_changed
        )

        self.lbl_mod = QLabel("Radio class")
        self.cmb_mod = QComboBox()

        self.lbl_snr = QLabel("SNR [dB]")
        self.spin_snr = QSpinBox()
        self.spin_snr.setRange(-30, 60)
        self.spin_snr.setValue(10)

        self.edit_file_1 = QLineEdit()
        self.edit_file_1.setReadOnly(True)
        self.btn_browse_1 = QPushButton("Browse…")
        self.btn_browse_1.clicked.connect(self._browse_file_1)

        self.edit_file_2 = QLineEdit()
        self.edit_file_2.setReadOnly(True)
        self.btn_browse_2 = QPushButton("Browse…")
        self.btn_browse_2.clicked.connect(self._browse_file_2)

        self.btn_preview = QPushButton("Preview")
        self.btn_ok = QPushButton("OK")
        self.btn_cancel = QPushButton("Cancel")

        self.btn_preview.clicked.connect(self._emit_preview)
        self.btn_ok.clicked.connect(self._accept)
        self.btn_cancel.clicked.connect(self.reject)

        layout = QVBoxLayout()

        layout.addWidget(QLabel("Signal type"))
        layout.addWidget(self.cmb_signal_type)

        layout.addWidget(QLabel("File format"))
        layout.addWidget(self.cmb_format)

        layout.addSpacing(6)
        layout.addWidget(self.lbl_mod)
        layout.addWidget(self.cmb_mod)
        layout.addWidget(self.lbl_snr)
        layout.addWidget(self.spin_snr)

        layout.addSpacing(10)

        l1 = QHBoxLayout()
        l1.addWidget(self.edit_file_1, 1)
        l1.addWidget(self.btn_browse_1)
        layout.addLayout(l1)

        l2 = QHBoxLayout()
        l2.addWidget(self.edit_file_2, 1)
        l2.addWidget(self.btn_browse_2)
        layout.addLayout(l2)

        layout.addSpacing(10)

        hb = QHBoxLayout()
        hb.addWidget(self.btn_preview)
        hb.addStretch()
        hb.addWidget(self.btn_ok)
        hb.addWidget(self.btn_cancel)
        layout.addLayout(hb)

        self.setLayout(layout)

        self._on_signal_type_changed(self.cmb_signal_type.currentText())

    def _on_signal_type_changed(self, sig_type):
        self.cmb_format.clear()
        self.edit_file_1.clear()
        self.edit_file_2.clear()
        self.cmb_mod.clear()

        if sig_type == "ECG":
            self.cmb_format.addItems([
                "CSV",
                "WFDB (.hea + .dat)"
            ])

        elif sig_type == "Radio":
            self.cmb_format.addItems([
                "CSV",
                "HDF5 (DeepSig / RML)"
            ])

        self._on_format_changed(self.cmb_format.currentText())

    def _on_format_changed(self, fmt):
        self._set_file_fields(0)
        self._set_radio_opts(False)

        if fmt == "CSV":
            self._set_file_fields(1)

        elif fmt.startswith("WFDB"):
            self._set_file_fields(2)

        elif fmt.startswith("HDF5"):
            self._set_file_fields(2)
            self._set_radio_opts(True)
            self.edit_file_2.setPlaceholderText("Select classes.json")

    def _set_radio_opts(self, visible):
        self.lbl_mod.setVisible(visible)
        self.cmb_mod.setVisible(visible)
        self.lbl_snr.setVisible(visible)
        self.spin_snr.setVisible(visible)

    def _set_file_fields(self, count):
        self.edit_file_1.setVisible(False)
        self.btn_browse_1.setVisible(False)
        self.edit_file_2.setVisible(False)
        self.btn_browse_2.setVisible(False)

        if count >= 1:
            self.edit_file_1.setVisible(True)
            self.btn_browse_1.setVisible(True)
            self.edit_file_1.setPlaceholderText("Select input file")

        if count == 2:
            self.edit_file_2.setVisible(True)
            self.btn_browse_2.setVisible(True)
            self.edit_file_2.setPlaceholderText("Select second file")

    def _browse_file_1(self):
        fmt = self.cmb_format.currentText()

        if fmt.startswith("WFDB"):
            path, _ = QFileDialog.getOpenFileName(
                self, "Select WFDB header", "", "WFDB header (*.hea)"
            )
        elif fmt.startswith("HDF5"):
            path, _ = QFileDialog.getOpenFileName(
                self, "Select HDF5 file", "", "HDF5 files (*.hdf5 *.h5)"
            )
        else:
            path, _ = QFileDialog.getOpenFileName(
                self, "Select CSV file", "", "CSV files (*.csv)"
            )

        if path:
            self.edit_file_1.setText(path)

    def _browse_file_2(self):
        fmt = self.cmb_format.currentText()

        if fmt.startswith("WFDB"):
            path, _ = QFileDialog.getOpenFileName(
                self, "Select WFDB data", "", "WFDB data (*.dat)"
            )
        else:
            path, _ = QFileDialog.getOpenFileName(
                self, "Select classes.json", "", "JSON files (*.json)"
            )

        if path:
            self.edit_file_2.setText(path)
            if path.lower().endswith(".json"):
                self._load_radio_classes(path)

    def _load_radio_classes(self, json_path):
        try:
            with open(json_path, "r", encoding="utf-8") as f:
                data = json.load(f)

            if isinstance(data, dict):
                classes = list(data.keys())
            elif isinstance(data, list):
                classes = data
            else:
                raise ValueError("Unsupported JSON format")

            self.cmb_mod.clear()
            self.cmb_mod.addItems(classes)

        except Exception as e:
            QMessageBox.critical(
                self, "Classes error",
                f"Cannot load classes.json:\n{e}"
            )
            self.cmb_mod.clear()

    def _emit_preview(self):
        if self.preview_callback is None:
            QMessageBox.warning(self, "Preview", "Preview handler not connected.")
            return

        if not self.edit_file_1.text():
            QMessageBox.warning(self, "Preview", "Select file first.")
            return

        info = {
            "signal_type": self.cmb_signal_type.currentText(),
            "format": self.cmb_format.currentText(),
            "files": [self.edit_file_1.text()],
            "classes_file": self.edit_file_2.text() if self.edit_file_2.isVisible() else None,
            "selected_class": self.cmb_mod.currentText() if self.cmb_mod.isVisible() else None,
            "class_index": self.cmb_mod.currentIndex() if self.cmb_mod.isVisible() else None,
            "snr": self.spin_snr.value() if self.spin_snr.isVisible() else None
        }

        if self.edit_file_2.isVisible() and self.edit_file_2.text():
            info["files"].append(self.edit_file_2.text())

        self.preview_callback(info)

    def _accept(self):
        sig_type = self.cmb_signal_type.currentText()
        fmt = self.cmb_format.currentText()

        if not self.edit_file_1.text():
            QMessageBox.warning(self, "Missing file", "Select input file.")
            return

        if sig_type == "Radio":
            class_index = self.cmb_mod.currentIndex()
            if class_index < 0:
                QMessageBox.warning(
                    self,
                    "Missing class",
                    "Select radio class."
                )
                return
        else:
            class_index = None

        files = [self.edit_file_1.text()]
        if self.edit_file_2.isVisible():
            files.append(self.edit_file_2.text())

        self.result = {
            "signal_type": sig_type,
            "format": fmt,
            "files": files,
            "radio": {
                "class_id": class_index
            } if sig_type == "Radio" else None
        }

        self.accept()
