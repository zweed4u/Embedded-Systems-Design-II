#!/usr/bin/python
# Zachary Weeden Homework 1
# January 22, 2018 Rev 2


import sys
import random
from PyQt4 import QtGui, QtCore


class Bounce(QtGui.QMainWindow):

    def __init__(self):
        super(Bounce, self).__init__()
        self.statusBar().showMessage('Welcome to Bounce by Zachary Weeden 2018')

        exitAction = QtGui.QAction(QtGui.QIcon('exit.png'), '&Exit', self)
        exitAction.setShortcut('Ctrl+Q')
        exitAction.setStatusTip('Exit application')
        exitAction.triggered.connect(QtGui.qApp.quit)

        menubar = self.menuBar()
        fileMenu = menubar.addMenu('&File')
        fileMenu.addAction(exitAction)

        self.hLayout = QtGui.QHBoxLayout()

        self.colorButton = QtGui.QPushButton("Change to random Color")
        self.accelerateButton = QtGui.QPushButton("Accelerate")
        self.decelerateButton = QtGui.QPushButton("Decelerate")
        self.hLayout.addWidget(self.colorButton)
        self.hLayout.addWidget(self.accelerateButton)
        self.hLayout.addWidget(self.decelerateButton)

        self.dockFrame = QtGui.QFrame()
        self.dockFrame.setLayout(self.hLayout)

        self.dock = QtGui.QDockWidget(self)
        self.dock.setWidget(self.dockFrame)
        self.addDockWidget(QtCore.Qt.DockWidgetArea(4), self.dock)

        self.setFocusPolicy(QtCore.Qt.StrongFocus)

        self.board = Board(self)
        self.vLayout = QtGui.QVBoxLayout()
        self.vLayout.addWidget(self.board)

        self.frame = QtGui.QFrame(self)
        self.frame.setLayout(self.vLayout)

        self.setCentralWidget(self.frame)
        self.setWindowTitle("Bounce")
        self.showMaximized()
        self.show()

        self.colorButton.clicked.connect(lambda: self.board.ball.changeColor())
        self.accelerateButton.clicked.connect(lambda: self.board.ball.accelerate())
        self.decelerateButton.clicked.connect(lambda: self.board.ball.decelerate())

class Bounds(QtGui.QGraphicsItem):
    def __init__(self, boardWidth, boardHeight):
        super(Bounds, self).__init__()
        self.color = QtGui.QColor(255, 255, 255)
        self.boardWidth = boardWidth
        self.boardHeight = boardHeight

    def boundingRect(self):
        return QtCore.QRectF(0, 0, 20, self.boardHeight)

    def paint(self, painter, option, widget):
        painter.setBrush(self.color)
        painter.drawRect(0, 0, 20, self.boardHeight)

class Ball(QtGui.QGraphicsItem):
    def __init__(self, parent, boardWidth, boardHeight):
        super(Ball, self).__init__()
        self.color = QtGui.QColor(255, 255, 255)
        self.xVel = 10
        self.yVel = 5
        self.ballWidth = 20
        self.ballHeight = 20
        self.boardWidth = boardWidth
        self.boardHeight = boardHeight
        self.parent = parent

    def boundingRect(self):
        return QtCore.QRectF(-self.ballWidth / 2, -self.ballHeight / 2, self.ballWidth, self.ballHeight)

    def paint(self, painter, option, widget):
        painter.setBrush(self.color)
        painter.drawEllipse(-self.ballWidth / 2, -self.ballHeight / 2, self.ballWidth, self.ballHeight)

    def accelerate(self):
        self.xVel *= 2.0
        self.yVel *= 2.0
        print "Accelerating {}, {}".format(self.xVel, self.yVel)

    def decelerate(self):
        self.xVel /= 2.0
        self.yVel /= 2.0
        print "Decelerating {}, {}".format(self.xVel, self.yVel)

    def changeColor(self):
        rand_color_tuple = (random.randint(0,255), random.randint(0,255), random.randint(0,255))
        print "Changing to color {}".format(rand_color_tuple)
        self.color = QtGui.QColor(rand_color_tuple[0], rand_color_tuple[1], rand_color_tuple[2])

    def reflectX(self):
        self.xVel *= -1

    def reflectY(self):
        self.yVel *= -1

    def move(self):
        self.setX(self.x() + self.xVel)
        if (self.x() >= self.boardWidth - self.ballWidth / 2):
            # ball has gone through the right most bound
            self.setX((self.boardWidth - self.ballWidth / 2) - 1)
            self.reflectX()
            self.parent.bounces += 1
            print "Bounces: {}".format(self.parent.bounces)

        elif (self.x() <= self.ballWidth / 2):
            # ball has gone through the left most bound
            self.setX((self.ballWidth / 2) + 1)
            self.reflectX()
            self.parent.bounces += 1
            print "Bounces: {}".format(self.parent.bounces)

        self.setY(self.y() + self.yVel)
        if (self.y() >= self.boardHeight - self.ballHeight / 2):
            # ball has gone through the top bound
            self.setY((self.boardHeight - self.ballHeight / 2) - 1)
            self.reflectY()
            self.parent.bounces += 1
            print "Bounces: {}".format(self.parent.bounces)

        elif (self.y() <= self.ballHeight / 2):
            # ball has gone through the lower bound
            self.setY((self.ballHeight / 2) + 1)
            self.reflectY()
            self.parent.bounces += 1
            print "Bounces: {}".format(self.parent.bounces)

        return 0


class Board(QtGui.QGraphicsView):
    def __init__(self, parent):
        super(Board, self).__init__()
        self.timer_init = 20.0
        self.bounces = 0
        self.parent = parent
        self.scene = QtGui.QGraphicsScene(self)
        self.setScene(self.scene)

        # Should be able to dynamically grab board dimensions based on machine
        self.boardWidth = 1000
        self.boardHeight = 1000

        # effectively sets the logical scene coordinates from 0,0 to 1000,1000
        self.scene.addRect(0, 0, self.boardWidth, self.boardHeight)

        self.ball = Ball(self, self.boardWidth, self.boardHeight)
        self.scene.addItem(self.ball)
        self.timer = QtCore.QBasicTimer()
        self.ball.setPos(500, 500)

    def startGame(self):
        self.status = 0
        self.ball.setPos(500, 500)
        self.timer.start(self.timer_init, self)

    def timerEvent(self, event):
        if (self.status == 0):
            self.status = self.ball.move()
        else:
            self.timer.stop()

    def resizeEvent(self, event):
        super(Board, self).resizeEvent(event)
        self.fitInView(self.scene.sceneRect(), QtCore.Qt.KeepAspectRatio)

def main():
    app = QtGui.QApplication(sys.argv)
    app.setFont(QtGui.QFont("Helvetica", 10))
    Bounce().board.startGame()
    sys.exit(app.exec_())

if __name__ == '__main__':
    main()
