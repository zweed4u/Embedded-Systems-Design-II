#!/usr/bin/python
# Zachary Weeden 2018
# Lab 3 Desktop GUI

import os
import sys
from PyQt4 import QtGui
from ctypes import cdll, c_int

class MyWidget(QtGui.QWidget):
    def __init__(self):
        """
        Constructor for GUI widget
        """
        super(MyWidget, self).__init__()

        # Initialize in idle state
        self.pwm_period_ms = 0
        self.duty_cycle_ms = 0
        self.enable = False

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

        vLayout = QtGui.QVBoxLayout()
        vLayout.addWidget(self.pwm_label)
        vLayout.addWidget(self.pwm_period_int_field)
        vLayout.addWidget(self.duty_label)
        vLayout.addWidget(self.duty_cycle_int_field)
        vLayout.addWidget(self.enable_label)
        vLayout.addWidget(self.enable_box)
        vLayout.addWidget(self.submit_button)
        vLayout.addWidget(self.exit_button)
        self.setLayout(vLayout)

        # C wrapper 
        self.pwm_lib = cdll.LoadLibrary('./pwm_drv.so')
        self.pwm_lib.set_duty.argtypes = [c_int]
        self.pwm_lib.set_period.argtypes = [c_int]
        self.pwm_lib.set_enable.argtypes = [c_int]

        # slots
        self.submit_button.clicked.connect(lambda: self.set_all())
        self.exit_button.clicked.connect(lambda: self.exit())
        self.show()

    def set_all(self):
        """
        Setter method invoked on submit gui button press
        Sets class attributes used in pwm signal generation
        :return:
        """
        self.pwm_period_ms = self.pwm_lib.set_period(int(self.pwm_period_int_field.text()))
        self.duty_cycle_ms = self.pwm_lib.set_duty(int(self.duty_cycle_int_field.text()))
        self.enable = self.pwm_lib.set_enable(int(self.enable_box.isChecked()) == True)

    def exit(self):
        """
        Exit logic used when exit button pressed on gui
        :return:
        """
        print 'State: Exitting'
        sys.exit()


def main():
    """
    Main of lab 3 desktop gui
    :return:
    """
    os.system('cat design_1_wrapper.bin > /dev/xdevcfg')
    app = QtGui.QApplication(sys.argv)
    myWidget = MyWidget()
    sys.exit(app.exec_())


if __name__ == '__main__':
    main()
