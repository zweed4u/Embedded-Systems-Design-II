# Dr. Kaputa
# basic python read/write from memory

import time
import mmap
import struct

import sys
from PyQt4 import QtCore, QtGui

class MyWidget(QtGui.QWidget):
  def __init__(self):
    super(MyWidget, self).__init__()
    
    self.state = 0
    
    # layout stuff
    button1 = QtGui.QPushButton("Blink Me")
    vLayout = QtGui.QVBoxLayout()
    vLayout.addWidget(button1)
    self.setLayout(vLayout)
    
    # open dev mem and see to base address
    f = open("/dev/mem", "r+b")
    self.mem = mmap.mmap(f.fileno(), 32, offset=0x41200000)
    
    #slots
    button1.clicked.connect(lambda: self.someoneClicked(1))  
    self.show() 

  def someoneClicked(self,val):
    self.mem.seek(0)  
    if(self.state == 0):
        self.state = 1
        self.mem.write(struct.pack('l', 1))
    else:   
        self.state = 0
        self.mem.write(struct.pack('l', 0))

def main():
  app = QtGui.QApplication(sys.argv)
  myWidget = MyWidget()
  sys.exit(app.exec_())

if __name__ == '__main__':
  main()