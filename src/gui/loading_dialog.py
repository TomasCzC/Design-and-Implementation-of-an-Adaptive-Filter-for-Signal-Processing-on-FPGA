from PyQt5.QtWidgets import QDialog, QLabel, QVBoxLayout
from PyQt5.QtCore import Qt


class LoadingDialog(QDialog):
    def __init__(self, text="Loading… Please wait.", parent=None):
        super().__init__(parent)

        self.setWindowTitle("Processing")
        self.setModal(True)
        self.setFixedSize(320, 120)

        self.setWindowFlags(
            Qt.Dialog |
            Qt.CustomizeWindowHint |
            Qt.WindowTitleHint
        )

        label = QLabel(text)
        label.setAlignment(Qt.AlignCenter)

        layout = QVBoxLayout()
        layout.addStretch()
        layout.addWidget(label)
        layout.addStretch()

        self.setLayout(layout)
