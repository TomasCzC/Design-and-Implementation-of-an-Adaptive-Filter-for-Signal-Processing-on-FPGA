from PyQt5.QtWidgets import QApplication
from gui.main_window import MainWin
import sys

def main():
    app = QApplication(sys.argv)
    w = MainWin()
    w.show()
    sys.exit(app.exec_())

if __name__ == "__main__":
    main()
