#!/usr/bin/python
# Zachary Weeden 2018

import time
import threading
from mem_access import MemAccess

# adjust accordingly
sensor_trigger_pin = 0x41200010
sensor_echo_pin = 0x41200014
sensor_trigger_hold_microseconds = 10
sensor_cycle_time_milliseconds = 60
speed_of_sound_centimeters_per_second = 34000


class Sensor:
    def __init__(self):
        self.sensor_thread = threading.Thread(target=self.trigger, args=(0,))
        self.trigger = 1
        self.sensor_thread.daemon = True
        self.sensor_thread.start()

    def trigger(self, reg=0):
        while self.trigger:
            MemAccess(reg=reg, data_to_mem=1,
                      address_offset=sensor_trigger_pin).write()
            time.sleep(sensor_trigger_hold_microseconds / 1000000)
            MemAccess(reg=reg, data_to_mem=0,
                      address_offset=sensor_trigger_pin).write()
            while not self.fetch(sensor_echo_pin):
                echo_pulse_tic = time.time()
            while self.fetch(sensor_echo_pin):
                echo_pulse_toc = time.time()
            pulse_time = echo_pulse_toc - echo_pulse_tic
            pulse_cm_distance = pulse_time * (
                    speed_of_sound_centimeters_per_second / 2)
            # logic on pulse_cm_distance here
            time.sleep(sensor_cycle_time_milliseconds / 1000)

    def fetch(self, address, reg=0):
        return MemAccess(reg=reg, address_offset=address).fetch()

    def halt(self):
        self.trigger = 0
