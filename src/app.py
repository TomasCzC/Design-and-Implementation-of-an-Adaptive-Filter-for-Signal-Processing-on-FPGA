import sys
from PyQt5.QtWidgets import QApplication

from src.gui.main_window import MainWin


def main():
    app = QApplication(sys.argv)

    window = MainWin()
    window.show()

    sys.exit(app.exec_())


if __name__ == "__main__":
    main()
