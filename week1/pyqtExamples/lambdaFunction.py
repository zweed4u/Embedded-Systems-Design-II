# Dr. Kaputa
# pyqt lambda function example

import sys
from PyQt4 import QtCore, QtGui


class MyWidget(QtGui.QWidget):
    def __init__(self):
        super(MyWidget, self).__init__()

        # layout stuff
        # Changed to class attributes (self) for use in someoneClicked method
        self.button1 = QtGui.QPushButton("btn1")
        self.button2 = QtGui.QPushButton("btn2")
        vLayout = QtGui.QVBoxLayout()
        vLayout.addWidget(self.button1)
        vLayout.addWidget(self.button2)
        self.setLayout(vLayout)

        # slots
        self.button1.clicked.connect(lambda: self.someoneClicked(1))
        self.button2.clicked.connect(lambda: self.someoneClicked(2))

        self.show()

    def someoneClicked(self, val):
        print "Button{} clicked".format(val)
        # Pyside QPushButton for setText method - had to see parent's methods
        if val == 1:
            self.button1.setText("I've been clicked")
        elif val == 2:
            self.button2.setText("I've been clicked")


def main():
    app = QtGui.QApplication(sys.argv)
    myWidget = MyWidget()
    sys.exit(app.exec_())


if __name__ == '__main__':
    main()
