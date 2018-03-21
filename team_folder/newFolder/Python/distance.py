#!/usr/bin/python
import math


class TickConversion:
	def __init__(self):
		self.GEAR_BOX_RATIO = 87  # 86.8:1 (driven/driving) - # of teeth - for every 87 rotations of driving effort gear, driven load gear makes 1 rotation
		self.ROVER_WHEEL_DIAMETER_MM = 60
		self.ROVER_WHEEL_DIAMETER_CM = self.ROVER_WHEEL_DIAMETER_MM / 10.0
		self.ROVER_WHEEL_DIAMETER_IN = self.ROVER_WHEEL_DIAMETER_CM / 2.54
		self.SYS_CLK = 100000000
		self.states_per_rotation = 1000 / 3.0  # From "Rover 5.pdf"

	def diameter_to_circumference(self, diameter):
		# C = 2 Pi r
		return 2 * math.pi * (diameter / 2.0)

	def ticks_to_distance(self, ticks):
		# (Ticks / 360) * diameter
		#return (ticks / 360.0) * self.diameter_to_circumference(self.ROVER_WHEEL_DIAMETER_MM)
		return (ticks / self.states_per_rotation) * self.diameter_to_circumference(self.ROVER_WHEEL_DIAMETER_MM)
