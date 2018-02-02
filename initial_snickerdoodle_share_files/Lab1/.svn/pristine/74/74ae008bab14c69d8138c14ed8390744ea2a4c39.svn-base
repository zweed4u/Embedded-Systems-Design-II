#Marc Schwartz
#Rover Testing using Pong
#Code borrowed from Pong by Professor Kaputa

#Import Statements
import sys
from PyQt4 import QtGui, QtCore
import math

#Rover Class
class Rover(QtGui.QGraphicsItem):
  def __init__(self,parent):
    super(Rover,self).__init__()
    self.parent = parent
    self.roverWidth = 2
    self.roverHeight = 4
    self.boardWidth = 50
    self.boardHeight = 50
    self.angle = 90
    self.forwardX = 0
    self.forwardY = 0

  #Sets up a bounding box for the rover to move within
  def boundingRect(self):
      return QtCore.QRectF(-self.roverWidth/2,-self.roverHeight/2,self.boardWidth,self.boardHeight)

  #draws the rover
  def paint(self,painter,option,widget):
    painter.setBrush(QtGui.QColor(0,255,0))
    painter.drawRect(-self.roverHeight/2,-self.roverWidth/2,self.roverWidth,self.roverHeight)
    painter.setBrush(QtGui.QColor(0,0,255))
    painter.drawRect(-self.roverHeight/2,-self.roverWidth/2,self.roverWidth,self.roverHeight/4)

  #Forward movement for ticks
  def forward(self,ticks):
    #Calculate movement coordinates
    self.forwardX = ticks * math.cos(self.angle * (math.pi/180))
    self.forwardY = -1 * (ticks * math.sin(self.angle * math.pi/180))

    #Move to new coordinate
    print("\nX:")
    print(self.forwardX)
    print("\nY:")
    print(self.forwardY)
    self.setX(self.x() + self.forwardX)
    self.setY(self.y() + self.forwardY)

  #Rotate for ticks
  def turn(self,ticks,direct):
    #turn 45 degrees for each tick
    for i in range(0,ticks):
      self.angle += (direct * 45)
      self.rotate(direct * 45)

  #Rover movement code
  def move(self,l_dir,left,r_dir,right):
    #when both directions are forward
    if(l_dir == 1 and r_dir == 1):
      #equal values move straight
      if(left == right):
        self.forward(left)
      #If straight and or turn right
      elif(left > right):
        self.forward(right)
        self.turn(left-right,1)
      #If straight and or turn left
      elif(left < right):
        self.forward(left)
        self.turn(right-left,-1)
      #Catch all print error
      else:
        print("\nNotValidInput\n")
    #Catch all print error
    else:
      print("\nNotValidInput\n")

class MainWindow(QtGui.QMainWindow): 
  def __init__(self):
    super(MainWindow, self).__init__()

    #Exits Application safely
    exitAction = QtGui.QAction(QtGui.QIcon('exit.png'), '&Exit', self)        
    exitAction.setShortcut('Ctrl+Q')
    exitAction.setStatusTip('Exit application')
    exitAction.triggered.connect(QtGui.qApp.quit)     

    #Set up layout for manual buttons
    self.vLayout = QtGui.QVBoxLayout()

    self.tmp1 = QtGui.QPushButton("tmp1")
    self.tmp2 = QtGui.QPushButton("tmp2")
    self.tmp3 = QtGui.QPushButton("tmp3")
    self.tmp4 = QtGui.QPushButton("tmp4")
    self.tmp5 = QtGui.QPushButton("tmp5")
    self.tmp6 = QtGui.QPushButton("tmp6")

    self.vLayout.addWidget(self.tmp1)
    self.vLayout.addWidget(self.tmp2)
    self.vLayout.addWidget(self.tmp3)
    self.vLayout.addWidget(self.tmp4)
    self.vLayout.addWidget(self.tmp5)
    self.vLayout.addWidget(self.tmp6)

    #Sets up a dock for manual control
    self.dockFrame = QtGui.QFrame()
    self.dockFrame.setLayout(self.vLayout)

    self.dock = QtGui.QDockWidget(self)
    self.dock.setWidget(self.dockFrame)
    self.addDockWidget(QtCore.Qt.DockWidgetArea(4), self.dock)
    self.dock.setWindowTitle("Manual Inputs")

    self.setFocusPolicy(QtCore.Qt.StrongFocus)

    #Set up Arena window
    self.arena = Arena(self)
    self.hLayout = QtGui.QHBoxLayout()    
    self.hLayout.addWidget(self.arena)
    
    self.frame = QtGui.QFrame(self)
    self.frame.setLayout(self.hLayout)

    self.setCentralWidget(self.frame)
    self.setWindowTitle("Rover Maze") 
    self.showMaximized()
    self.show()

class Arena(QtGui.QGraphicsView):   
  def __init__(self,parent):
    super(Arena, self).__init__()
    self.parent = parent
    self.scene = QtGui.QGraphicsScene(self)
    self.setScene(self.scene)

    self.hwFlag = 0
    self.boardWidth = 50    #FIX################
    self.boardHeight = 50   #FIX################
    
    #Sets bounding box
    myFrame = self.scene.addRect(0,0,self.boardWidth,self.boardHeight) 

    #Set up and place rover in center
    self.rover = Rover(self)
    self.rover.setPos(25,25)
    self.rover.rotate(90)
    self.scene.addItem(self.rover)

    # Start Timer
    self.timer = QtCore.QBasicTimer()
    self.timer.start(1000,self)

  def timerEvent(self, event): 
    if(self.hwFlag == 0):
      self.rover.move(1,6,1,5)#Manual Remove#############################
      #encoderFile = open('encoders.txt','r')
      #next(encoderFile)
      #self.encoderReader = csv.reader(encoderFile,delimiter='\t')
    else:
      self.rover.move(0,0,0,0)
        
  def resizeEvent(self, event):
    super(Arena, self).resizeEvent(event)
    self.fitInView(self.scene.sceneRect(), QtCore.Qt.KeepAspectRatio) 
       
def main():
  app = QtGui.QApplication(sys.argv)
  app.setFont(QtGui.QFont("Helvetica", 10))  
  mainWindow = MainWindow()
  sys.exit(app.exec_())

if __name__ == '__main__':
  main()
