#!/usr/bin/python
# Zachary Weeden 2018

import time
import threading
from mem_access import MemAccess

# adjust accordingly
front_sensor_trigger_pin = 0x41200010
front_sensor_echo_pin = 0x41200014
left_sensor_trigger_pin = 0x41200018
left_sensor_echo_pin = 0x4120001C
right_sensor_trigger_pin = 0x41200020
right_sensor_echo_pin = 0x41200024
sensor_trigger_hold_microseconds = 10
sensor_cycle_time_milliseconds = 60
speed_of_sound_centimeters_per_second = 34000


class Sensor:
    def __init__(self, trigger_pin, echo_pin):
        """
        Constructor for the HC-SR04 sensor module
        :param trigger_pin: location of the trigger pin
        :param echo_pin: location of the echo pin
        """
        self.trigger_pin = trigger_pin
        self.echo_pin = echo_pin
        self.sensor_thread = threading.Thread(target=self.monitor, args=(0,))
        self.active = 1
        self.sensor_thread.daemon = True
        self.sensor_thread.start()

    def trigger(self, reg=0):
        """
        Triggers echo capture
        :param reg:
        :return:
        """
        MemAccess(reg=reg, data_to_mem=1,
                  address_offset=self.trigger_pin).write()
        time.sleep(sensor_trigger_hold_microseconds / 1000000)
        MemAccess(reg=reg, data_to_mem=0,
                  address_offset=self.trigger_pin).write()

    def get_echo_pulse(self):
        """
        Return the number of time elapsed in seconds from when the echo pin
        goes high to low
        :return: float - time in seconds of high echo pulse
        """
        while not self.fetch(self.echo_pin):
            echo_pulse_tic = time.time()
        while self.fetch(self.echo_pin):
            echo_pulse_toc = time.time()
        return echo_pulse_toc - echo_pulse_tic

    def monitor(self):
        """
        Main control of the sensor class
        :return:
        """
        while self.active:
            self.trigger()
            pulse_time = self.get_echo_pulse()
            pulse_cm_distance = pulse_time * (
                    speed_of_sound_centimeters_per_second / 2)
            # logic on pulse_cm_distance here
            time.sleep(sensor_cycle_time_milliseconds / 1000)

    def fetch(self, address, reg=0):
        """
        Retrieve contents of an address
        :param address:
        :param reg:
        :return: int
        """
        return MemAccess(reg=reg, address_offset=address).fetch()

    def start(self):
        """
        Sets thread's looping flag to active state
        :return:
        """
        self.active = 1

    def halt(self):
        """
        Sets thread's looping flag to inactive state
        :return:
        """
        self.active = 0


FrontSensor = Sensor(front_sensor_trigger_pin, front_sensor_echo_pin)
LeftSensor = Sensor(left_sensor_trigger_pin, left_sensor_echo_pin)
RightSensor = Sensor(right_sensor_trigger_pin, right_sensor_echo_pin)
