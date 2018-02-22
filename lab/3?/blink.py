#!/usr/bin/python
# Zachary Weeden
# Blink

import time
import mmap
import struct
from threading import Thread
import sys
from PyQt4 import QtCore, QtGui


class MyWidget(QtGui.QWidget):
    def __init__(self):
        super(MyWidget, self).__init__()

        self.state = 0
        self.blink = 0

        # layout stuff
        button1 = QtGui.QPushButton("Toggle Me")
        button2 = QtGui.QPushButton("Blink Me")
        button3 = QtGui.QPushButton("Clear")
        button4 = QtGui.QPushButton("Exit")
        button5 = QtGui.QPushButton("Go High")

        vLayout = QtGui.QVBoxLayout()
        vLayout.addWidget(button1)
        vLayout.addWidget(button2)
        vLayout.addWidget(button5)
        vLayout.addWidget(button3)
        vLayout.addWidget(button4)
        self.setLayout(vLayout)

        # open dev mem and see to base address
        f = open("/dev/mem", "r+b")

        # ensure that the offset address matches the offset address in the address editor in vivado
        self.mem = mmap.mmap(f.fileno(), 32, offset=0x43C00000)

        self.blink_thread = Thread(target=self.blink_me, args=(.5,))
        self.blink = 1
        self.blink_thread.daemon = True
        self.blink_thread.start()
        self.blink = 0
        self.stop()

        # slots
        button1.clicked.connect(lambda: self.toggle())
        button2.clicked.connect(lambda: self.blink_switch())
        button5.clicked.connect(lambda: self.set_high())
        button3.clicked.connect(lambda: self.stop())
        button4.clicked.connect(lambda: self.exit())
        self.show()

    def exit(self):
        print 'State: Exitting'
        self.stop()
        sys.exit()

    def blink_switch(self):
        print 'State: Blink'
        self.blink = 1

    def stop(self):
        print 'State: Low'
        self.blink = 0
        self.state = 0
        self.mem.seek(0)
        self.mem.write(struct.pack('l', 0))

    def set_high(self):
        print 'State: High'
        self.blink = 0
        self.mem.seek(0)
        self.state = 1
        self.mem.write(struct.pack('l', 1))

    def blink_me(self, sleep):
        poll_rate = .1
        while 1:
            if self.blink:
                self.toggle()
                time.sleep(sleep - poll_rate)
            time.sleep(poll_rate)

    def toggle(self):
        # print 'State: Toggle' # causes to initial high - racecondition in thread start?
        self.mem.seek(0)
        if self.state == 0:
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
