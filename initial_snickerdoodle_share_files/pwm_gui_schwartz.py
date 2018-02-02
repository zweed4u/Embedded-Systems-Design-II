#Marc Schwartz
#ESDII Lab3
#PWM GUI

#Import statements
import sys
from PyQt4 import QtGui,QtCore

import time
import mmap
import struct
import math
import csv

class Main_Window(QtGui.QMainWindow):
  
  def __init__(self):
    super(Main_Window, self).__init__()
    self.statusBar().showMessage("PWM ready")
    
    exitAction = QtGui.QAction(QtGui.QIcon('exit.png'), '&Exit', self)        
    exitAction.setShortcut('Ctrl+Q')
    exitAction.setStatusTip('Exit application')
    exitAction.triggered.connect(QtGui.qApp.quit)


    self.dock_main = QtGui.QDockWidget(self)
    self.lb_dock_main = QtGui.QLabel('Enables')
    self.bt_enable = QtGui.QPushButton("Generate Wave")
    self.bt_reset = QtGui.QPushButton("Reset")
    self.vLayout = QtGui.QVBoxLayout()
    self.vLayout.addWidget(self.lb_dock_main)
    self.vLayout.addWidget(self.bt_enable)
    self.vLayout.addWidget(self.bt_reset)
    self.dockFrame = QtGui.QFrame()
    self.dockFrame.setLayout(self.vLayout)
    self.dock_main.setWidget(self.dockFrame)
    self.addDockWidget(QtCore.Qt.DockWidgetArea(4),self.dock_main)

    self.dock_period = QtGui.QDockWidget(self)
    self.lb_period = QtGui.QLabel('Period (uS)')
    self.txt_period = QtGui.QLineEdit()
    self.txt_period.setValidator(QtGui.QIntValidator(0, 10000000, self) )
    self.vLayout_pd = QtGui.QVBoxLayout()
    self.vLayout_pd.addWidget(self.lb_period)
    self.vLayout_pd.addWidget(self.txt_period)
    self.dockFrame_pd = QtGui.QFrame()
    self.dockFrame_pd.setLayout(self.vLayout_pd)
    self.dock_period.setWidget(self.dockFrame_pd)
    self.addDockWidget(QtCore.Qt.DockWidgetArea(4),self.dock_period)

    self.dock_dutycycle = QtGui.QDockWidget(self)
    self.lb_dutycycle = QtGui.QLabel('Duty Cycle (% out of 1000)')
    self.txt_dutycycle = QtGui.QLineEdit()
    self.txt_dutycycle.setValidator(QtGui.QIntValidator(0, 1000, self) )
    self.vLayout_dc = QtGui.QVBoxLayout()
    self.vLayout_dc.addWidget(self.lb_dutycycle)
    self.vLayout_dc.addWidget(self.txt_dutycycle)
    self.dockFrame_dc = QtGui.QFrame()
    self.dockFrame_dc.setLayout(self.vLayout_dc)
    self.dock_dutycycle.setWidget(self.dockFrame_dc)
    self.addDockWidget(QtCore.Qt.DockWidgetArea(4),self.dock_dutycycle)

    self.statusBar()

    menubar = self.menuBar()
    fileMenu = menubar.addMenu('&File')
    fileMenu.addAction(exitAction)

    self.show()

    self.bt_enable.clicked.connect(lambda: generate(self))
    self.bt_reset.clicked.connect(lambda: reset(self))

    def generate(self):
      f = open("/dev/mem", "r+b")
      mem = mmap.mmap(f.fileno(), 32, offset=0x43c00000)

      toMemP = 50 * (int(self.txt_period.text()))
      reg   = 0

      mem.seek(reg)  
      mem.write(struct.pack('l', toMemP))

      time.sleep(.5) 

      toMemD = int(float(toMemP) * ((float(self.txt_dutycycle.text()))/1000.0))  
      reg = 4
    
      mem.seek(reg)  
      mem.write(struct.pack('l', toMemD))

      time.sleep(.5)
  
      toMem = 1
      reg   = 8

      mem.seek(reg)  
      mem.write(struct.pack('l', toMem))

      time.sleep(.5)
  
      mem.close()
      f.close()
      
    def reset(self):
      f = open("/dev/mem", "r+b")
      mem = mmap.mmap(f.fileno(), 32, offset=0x43c00000)

      toMem = 0
      reg   = 0

      mem.seek(reg)  
      mem.write(struct.pack('l', toMem))

      time.sleep(.5) 
      
      toMem = 0
      reg   = 4

      mem.seek(reg)  
      mem.write(struct.pack('l', toMem))

      time.sleep(.5) 

      toMem = 1
      reg   = 0x0c

      mem.seek(reg)  
      mem.write(struct.pack('l', toMem))

      time.sleep(.5) 

      toMem = 0
    
      mem.seek(reg)  
      mem.write(struct.pack('l', toMem))

      time.sleep(.5)
  
      mem.close()
      f.close()



class Screen(QtGui.QGraphicsView):   
  def __init__(self,parent):
    super(Screen, self).__init__()
    self.parent = parent
    self.scene = QtGui.QGraphicsScene(self)
    self.setScene(self.scene)
    
    self.screenWidth = 50
    self.screenHeight = 50    

        
  def resizeEvent(self, event):
    super(Screen, self).resizeEvent(event)
    self.fitInView(self.scene.sceneRect(), QtCore.Qt.KeepAspectRatio) 

def main():
  app = QtGui.QApplication(sys.argv)
  app.setFont(QtGui.QFont("Helvetica", 10))  
  main_Window = Main_Window()
  sys.exit(app.exec_())

if __name__ == '__main__':
  main()
