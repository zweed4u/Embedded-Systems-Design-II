#!/usr/bin/python
# Zachary Weeden
# Lab 3 backend

import time
import mmap
import struct
from threading import Thread


class Lab3Logic:
    def __init__(self, pwm_period_ms, duty_cycle_ms, enable):
        self.state = 0
        self.blink = 0
        self.pwm_period_ms = pwm_period_ms
        self.duty_cycle_ms = duty_cycle_ms
        self.duty_sleep = float(self.duty_cycle_ms)/float(1000)
        self.pwm_period_sleep = float(self.pwm_period_ms)/float(1000) - self.duty_sleep
        self.enable = enable

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

    def blink_me(self, sleep):
        while 1:
            if self.enable:
                if self.blink:
                    self.toggle()
                    time.sleep(self.duty_sleep)
                    self.toggle()
                    time.sleep(self.pwm_period_sleep)
            # 1 microsecond - so cpu isn't pegged - setting daemon attribute may mitigate this all together - RESEARCH
            time.sleep(.000001)

    def stop(self):
        self.blink = 0
        self.state = 0
        self.mem.seek(0)
        self.mem.write(struct.pack('l', 0))

    def toggle(self):
        self.mem.seek(0)
        if self.state == 0:
            self.state = 1
            self.mem.write(struct.pack('l', 1))
        else:
            self.state = 0
            self.mem.write(struct.pack('l', 0))
