# Dr. Kaputa
# pyqt lambda function example

import sys
from PyQt4 import QtCore, QtGui

class MyWidget(QtGui.QWidget):
  def __init__(self):
    super(MyWidget, self).__init__()
    
    # layout stuff
    button1 = QtGui.QPushButton("btn1")
    button2 = QtGui.QPushButton("btn2")
    vLayout = QtGui.QVBoxLayout()
    vLayout.addWidget(button1)
    vLayout.addWidget(button2)
    self.setLayout(vLayout)
    
    #slots
    button1.clicked.connect(lambda: self.someoneClicked(1))
    button2.clicked.connect(lambda: self.someoneClicked(2))
    
    self.show() 

  def someoneClicked(self,val):
    print val

def main():
  app = QtGui.QApplication(sys.argv)
  myWidget = MyWidget()
  sys.exit(app.exec_())

if __name__ == '__main__':
  main()  