#!/usr/bin/python
"""
Zachary Weeden
CPET-563 Lab 1
January 23, 2018
"""
import os
import sys
import json
from PyQt4 import QtGui, QtCore

hw_flag = 0  # 0 = read from file


class Encoders:
    def __init__(self, hw_flag):
        """Constructor for Encoder class"""
        self.hw_flag = hw_flag
        self.contents = None
        self.number_of_instructions = 0

    def get_encoders(self):
        """
        Opens the encoders text file and stores it into class attribute
        Assumes that the encoders txt file is named appropriately and in the same directory as invocation
        :return: str - the contents of the encoders.txt file
        """
        with open(os.getcwd() + '/encoders.txt', 'r') as f:
            self.contents = f.read()
        return self.contents

    def parse_file(self):
        """
        Parse the actual encoder text into usable data structure
        :return: dict - {'header_from_1st_row': [array_of_values_for_given_column]}
        """
        # Read from file
        if self.hw_flag == 0:
            if self.contents is None:
                self.get_encoders()
            # assumes format of l_dir\tleft\tr_dir\tright as the first row - data starts 2nd row
            headers = self.contents.split('\n')[0].split()
            control_bits = self.contents.split('\n')[1:]
            l_dir = []
            left = []
            r_dir = []
            right = []
            encoder_map = {}

            for row in control_bits:  # ensure that the line from the file was not empty
                if row.strip():
                    l_dir.append(int(row[0]))
                    left.append(int(row[2]))
                    r_dir.append(int(row[4]))
                    right.append(int(row[6]))
                    self.number_of_instructions += 1
            encoder_map[headers[0]] = l_dir
            encoder_map[headers[1]] = left
            encoder_map[headers[2]] = r_dir
            encoder_map[headers[3]] = right
            return encoder_map
        elif self.hw_flag == 1:
            return 0


class Board(QtGui.QGraphicsView):
    def __init__(self, parent):
        super(Board, self).__init__()
        # Timer update to be between 2 and 4 seconds
        self.timer_init = 3000.0
        self.parent = parent
        self.scene = QtGui.QGraphicsScene(self)
        self.setScene(self.scene)

        # Should be able to dynamically grab board dimensions based on machine
        self.board_width = 1000
        self.board_height = 1000

        # effectively sets the logical scene coordinates from 0,0 to 1000,1000
        self.scene.addRect(0, 0, self.board_width, self.board_height)

        self.rover = Rover(self, self.board_width, self.board_height)
        self.scene.addItem(self.rover)
        self.timer = QtCore.QBasicTimer()
        self.rover.setPos(500, 500)

    def startGame(self):
        self.status = 0
        self.rover.setPos(500, 500)
        self.timer.start(self.timer_init, self)

    def timerEvent(self, event):
        if self.status == 0:  # determine press
            print "Waiting on timer {}".format(self.timer_init)
            self.status = self.rover.basic_move()
            # self.status = self.rover.advanced_move()
        else:
            self.timer.stop()

    def resizeEvent(self, event):
        super(Board, self).resizeEvent(event)
        self.fitInView(self.scene.sceneRect(), QtCore.Qt.KeepAspectRatio)


class LabOne(QtGui.QMainWindow):
    def __init__(self, parsed_encoders):
        super(LabOne, self).__init__()
        self.encoders = parsed_encoders
        self.statusBar().showMessage('CPET-563 Lab 1 :: Zachary Weeden 2018')

        exitAction = QtGui.QAction(QtGui.QIcon('exit.png'), '&Exit', self)
        exitAction.setShortcut('Ctrl+Q')
        exitAction.setStatusTip('Exit application')
        exitAction.triggered.connect(QtGui.qApp.quit)

        menubar = self.menuBar()
        fileMenu = menubar.addMenu('&File')
        fileMenu.addAction(exitAction)

        self.hLayout = QtGui.QHBoxLayout()

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
        self.setWindowTitle("Lab 1")
        self.showMaximized()
        self.show()


class Rover(QtGui.QGraphicsItem):
    def __init__(self, parent, board_width, board_height):
        super(Rover, self).__init__()
        self.instruction_step = 0
        self.color = QtGui.QColor(0, 0, 255)
        self.xVel = 10
        self.yVel = 5
        self.rover_width = 100
        self.rover_height = 50
        self.board_width = board_width
        self.board_height = board_height
        self.parent = parent

    def boundingRect(self):
        return QtCore.QRectF(-self.rover_width / 2, -self.rover_height / 2, self.rover_width, self.rover_height)

    def set_color(self, color_tuple):
        self.color = QtGui.QColor(color_tuple[0], color_tuple[1], color_tuple[2])

    def paint(self, painter, option, widget):
        painter.setBrush(self.color)
        painter.drawRect(-self.rover_width / 2, -self.rover_height / 2, self.rover_width, self.rover_height)

    def basic_move(self):
        left_encoder = self.parent.parent.encoders['left']
        right_encoder = self.parent.parent.encoders['right']
        if self.instruction_step < len(left_encoder) or self.instruction_step < len(right_encoder):
            left_ticks, right_ticks = left_encoder[self.instruction_step], right_encoder[self.instruction_step]
            if left_ticks == right_ticks:
                if left_ticks == 0:
                    print "Received both 0s not moving"
                else:
                    print "Moving foward by scale of {}".format(left_ticks)
            else:
                # Different values for each encoder - parse
                # I'm so sorry - this is awful
                if (left_ticks, right_ticks) == (0, 1):
                    print "45 to the left"
                elif (left_ticks, right_ticks) == (0, 2):
                    print "90 to the left"
                elif (left_ticks, right_ticks) == (1, 0):
                    print "45 to the right"
                elif (left_ticks, right_ticks) == (1, 2):
                    print "45 to the left"
                elif (left_ticks, right_ticks) == (2, 0):
                    print "90 to the right"
                elif (left_ticks, right_ticks) == (2, 1):
                    print "45 to the right"
            self.instruction_step += 1
        else:
            print "Encoder text file fully traversed"
        return 0


if __name__ == '__main__':
    parsed_encoders = Encoders(hw_flag).parse_file()
    # Works for when hw_flag = 0, read from file as headers (1st line) is used as keys
    left_dir = parsed_encoders['l_dir']
    left = parsed_encoders['left']
    right_dir = parsed_encoders['r_dir']
    right = parsed_encoders['right']

    app = QtGui.QApplication(sys.argv)
    app.setFont(QtGui.QFont("Helvetica", 10))
    LabOne(parsed_encoders).board.startGame()
    sys.exit(app.exec_())
