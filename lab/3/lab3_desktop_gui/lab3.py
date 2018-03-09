#!/usr/bin/python
# Zachary Weeden
# Lab 3 Desktop GUI

import os
import time
import mmap
import struct
from threading import Thread
import sys
from PyQt4 import QtCore, QtGui


class MyWidget(QtGui.QWidget):
    def __init__(self):
        super(MyWidget, self).__init__()

        # Initialize in idle state
        self.pwm_period_ms = 0
        self.duty_cycle_ms = 0
        self.duty_sleep = float(self.duty_cycle_ms) / float(1000)
        self.pwm_period_sleep = float(self.pwm_period_ms) / float(
            1000) - self.duty_sleep
        self.enable = False

        self.state = 0
        self.blink = 0

        # layout stuff
        self.pwm_label = QtGui.QLabel(self)
        self.pwm_label.setText('PWM Period in ms:')

        self.duty_label = QtGui.QLabel(self)
        self.duty_label.setText('Duty Cycle in ms:')

        self.pwm_period_int_field = QtGui.QLineEdit(self)
        self.duty_cycle_int_field = QtGui.QLineEdit(self)
        self.enable_label = QtGui.QLabel(self)

        self.enable_label.setText('Enable:')
        self.enable_box = QtGui.QCheckBox()

        self.submit_button = QtGui.QPushButton("Submit")
        self.exit_button = QtGui.QPushButton("Exit")
        # toggle_button = QtGui.QPushButton("Toggle Me")
        # blink_button = QtGui.QPushButton("Blink Me")
        # clear_button = QtGui.QPushButton("Clear")
        # high_button = QtGui.QPushButton("Go High")

        vLayout = QtGui.QVBoxLayout()
        vLayout.addWidget(self.pwm_label)
        vLayout.addWidget(self.pwm_period_int_field)
        vLayout.addWidget(self.duty_label)
        vLayout.addWidget(self.duty_cycle_int_field)
        vLayout.addWidget(self.enable_label)
        vLayout.addWidget(self.enable_box)
        vLayout.addWidget(self.submit_button)
        # vLayout.addWidget(toggle_button)
        # vLayout.addWidget(blink_button)
        # vLayout.addWidget(high_button)
        # vLayout.addWidget(clear_button)
        vLayout.addWidget(self.exit_button)
        self.setLayout(vLayout)

        # open dev mem and see to base address
        f = open("/dev/mem", "r+b")

        # ensure that the offset address matches the offset address in the address editor in vivado
        self.mem = mmap.mmap(f.fileno(), 32, offset=0x43C00000)

        # Clear to get in known state on subsequent web submissions
        self.stop()

        # Blink thread init - just a wrapped toggle
        self.blink_thread = Thread(target=self.blink_me)
        self.blink = 1
        self.blink_thread.daemon = True
        self.blink_thread.start()

        # slots
        self.submit_button.clicked.connect(lambda: self.set_all())
        # toggle_button.clicked.connect(lambda: self.toggle())
        # blink_button.clicked.connect(lambda: self.blink_switch())
        # high_button.clicked.connect(lambda: self.set_high())
        # clear_button.clicked.connect(lambda: self.stop())
        self.exit_button.clicked.connect(lambda: self.exit())
        self.show()

    def set_all(self):
        self.pwm_period_ms = int(self.pwm_period_int_field.text())
        self.duty_cycle_ms = int(self.duty_cycle_int_field.text())
        self.duty_sleep = float(self.duty_cycle_ms) / float(1000)
        self.pwm_period_sleep = float(self.pwm_period_ms) / float(
            1000) - self.duty_sleep
        self.enable = self.enable_box.isChecked()

    def blink_me(self):
        while 1:
            if self.enable:
                if self.blink:
                    self.toggle()
                    time.sleep(self.duty_sleep)
                    self.toggle()
                    time.sleep(self.pwm_period_sleep)

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

    def toggle(self):
        self.mem.seek(0)
        if self.state == 0:
            self.state = 1
            self.mem.write(struct.pack('l', 1))
        else:
            self.state = 0
            self.mem.write(struct.pack('l', 0))
        if self.blink == 0:
            print 'State: Toggle'


def main():
    os.system('cat system.bin > /dev/xdevcfg')
    app = QtGui.QApplication(sys.argv)
    myWidget = MyWidget()
    sys.exit(app.exec_())


if __name__ == '__main__':
    main()
