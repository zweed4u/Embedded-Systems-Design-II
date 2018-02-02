# Dr. Kaputa
# pyqt pong example

import sys
from PyQt4 import QtGui, QtCore
import math

class Pong(QtGui.QMainWindow):
  Key_K = QtCore.pyqtSignal()  
  Key_M = QtCore.pyqtSignal()  
  Key_A = QtCore.pyqtSignal()  
  Key_Z = QtCore.pyqtSignal()  
  
  def __init__(self):
    super(Pong, self).__init__()
    self.statusBar().showMessage('Ready')
    self.setWindowIcon(QtGui.QIcon('cool.jpg')) 
    
    exitAction = QtGui.QAction(QtGui.QIcon('exit.png'), '&Exit', self)        
    exitAction.setShortcut('Ctrl+Q')
    exitAction.setStatusTip('Exit application')
    exitAction.triggered.connect(QtGui.qApp.quit)
    
    menubar = self.menuBar()
    fileMenu = menubar.addMenu('&File')
    fileMenu.addAction(exitAction)    
    
    self.hLayout = QtGui.QHBoxLayout()
 
    self.startButton = QtGui.QPushButton("Start")  

    self.hLayout.addWidget(self.startButton)      
    
    self.dockFrame = QtGui.QFrame()
    self.dockFrame.setLayout(self.hLayout)    
     
    self.dock = QtGui.QDockWidget(self)
    self.dock.setWidget(self.dockFrame)
    self.addDockWidget(QtCore.Qt.DockWidgetArea(4), self.dock)
    self.dock.setWindowTitle("Controls")

    self.setFocusPolicy(QtCore.Qt.StrongFocus)
 
    self.board = Board(self)
    self.vLayout = QtGui.QVBoxLayout()    
    self.vLayout.addWidget(self.board)
    
    self.frame = QtGui.QFrame(self)
    self.frame.setLayout(self.vLayout)

    self.setCentralWidget(self.frame)
    self.setWindowTitle("Pong") 
    self.showMaximized()
    self.show()
    
    self.startButton.clicked.connect(lambda: self.board.startGame()) 
    
class Paddle(QtGui.QGraphicsItem):
  def __init__(self,boardWidth,boardHeight):
    super(Paddle, self).__init__()     
    self.color = QtGui.QColor(0,0,255)
    self.boardWidth = boardWidth
    self.boardHeight = boardHeight
          
  def boundingRect(self):
    return QtCore.QRectF(0,0,20,100)
      
  def paint(self, painter, option, widget):
    painter.setBrush(self.color)
    painter.drawRect(0,0,20,100)
      
  def moveDown(self):
    y = self.y()
    if (y < self.boardHeight - 100):
        self.moveBy(0,50)
      
  def moveUp(self):
    y = self.y()
    if (y > 0):
      self.moveBy(0,-50)
        
class Ball(QtGui.QGraphicsItem):
  def __init__(self,parent,boardWidth,boardHeight):
    super(Ball, self).__init__()     
    self.color = QtGui.QColor(0,0,255)
    self.xVel = 4
    self.yVel = 2
    self.ballWidth = 2
    self.ballHeight = 2
    self.boardWidth = boardWidth
    self.boardHeight = boardHeight
    self.parent = parent
     
  def boundingRect(self):
    return QtCore.QRectF(-self.ballWidth/2,-self.ballHeight/2,self.ballWidth,self.ballHeight)
      
  def paint(self, painter, option, widget):
    painter.setBrush(self.color)
    painter.drawEllipse(-self.ballWidth/2,-self.ballHeight/2,self.ballWidth,self.ballHeight)       
     
  def reflectX(self):
    self.xVel = self.xVel * -1
      
  def reflectY(self):
    self.yVel = self.yVel * -1   
      
  def move(self):
    self.setX(self.x() + self.xVel)
    if (self.x() >= self.boardWidth - self.ballWidth/2):
      #return 2
      self.reflectX()
    elif (self.x() <= self.ballWidth/2):
      self.reflectX()
      #return 1
  
    self.setY(self.y() + self.yVel)
    if (self.y() >= self.boardHeight - self.ballHeight/2):
      self.reflectY()
    elif (self.y() <= self.ballHeight/2):
      self.reflectY()

    return 0

#Rover Class
class Rover(QtGui.QGraphicsItem):
  def __init__(self,parent):
    super(Rover,self).__init__()
    self.parent = parent
    self.roverWidth = 2
    self.roverHeight = 4
    self.boardWidth = 50
    self.boardHeight = 50
    self.angle = 0
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
    print(self.x)
    self.setX(self.x() + self.forwardX)
    self.setY(self.y() + self.forwardY)

  #Rotate for ticks
  def turn(self,ticks,direct):
    #turn 45 degrees for each tick
    for i in range(0,ticks):
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

class Board(QtGui.QGraphicsView):   
  def __init__(self,parent):
    super(Board, self).__init__()
    self.parent = parent
    self.scene = QtGui.QGraphicsScene(self)
    self.setScene(self.scene)

    self.hwFlag = 0
    
    self.boardWidth = 50
    self.boardHeight = 50    
    
    # effectively sets the logical scene coordinates from 0,0 to 1000,1000
    myFrame = self.scene.addRect(0,0,self.boardWidth,self.boardHeight) 


    self.ball = Ball(self,self.boardWidth,self.boardHeight)

    self.rover = Rover(self)
    self.rover.setPos(25,25)
    self.rover.rotate(90)
    self.scene.addItem(self.rover)

    self.scene.addItem(self.ball)
 
    self.timer = QtCore.QBasicTimer()

    self.ball.setPos(35,35)


  def startGame(self):
    self.status = 0
    self.ball.setPos(35,35)
    self.timer.start(100, self)   

  def timerEvent(self, event): 
    ##Ball code######
    if (self.status == 0):
      self.status = self.ball.move()
    else:
      self.timer.stop()
      self.parent.updateScore(self.status)
    ##Ball code######
    if(self.hwFlag == 0):
      self.rover.move(1,2,1,1)#Manual Remove#############################
      #encoderFile = open('encoders.txt','r')
      #next(encoderFile)
      #self.encoderReader = csv.reader(encoderFile,delimiter='\t')
    else:
      self.rover.move(0,0,0,0)
        
  def resizeEvent(self, event):
    super(Board, self).resizeEvent(event)
    self.fitInView(self.scene.sceneRect(), QtCore.Qt.KeepAspectRatio) 
       
def main():
  app = QtGui.QApplication(sys.argv)
  app.setFont(QtGui.QFont("Helvetica", 10))  
  pong = Pong()
  sys.exit(app.exec_())

if __name__ == '__main__':
  main()
