#!/usr/bin/python
# Zachary Weeden 2018

from mem_access import MemAccess

forward_movement = 1

# adjust accordingly
front_left_encoder_address = 0x41200000
front_right_encoder_address = 0x41200004
rear_left_encoder_address = 0x41200008
rear_right_encoder_address = 0x4120000C


class RoverMovement():
	def __init__(self):
		self.state = 0
		self.front_left = 0
		self.front_right = 0
		self.rear_left = 0
		self.rear_right = 0

	def move_forward(self, reg):
		# hardcode write value - 1 means go forward
		data = 1
		MemAccess(reg=reg, data_to_mem=data, address_offset=front_left_encoder_address).write()
		self.front_left = 1
		MemAccess(reg=reg, data_to_mem=data, address_offset=front_right_encoder_address).write()
		self.front_right = 1
		MemAccess(reg=reg, data_to_mem=data, address_offset=rear_left_encoder_address).write()
		self.rear_left = 1
		MemAccess(reg=reg, data_to_mem=data, address_offset=rear_right_encoder_address).write()
		self.rear_right = 1
		self.state = 1

	def move_backward(self, reg):
		# hardcode write value - -1 means go backward (probably need different value to write to address rather than negative number - 0 represents idle)
		data = -1
		MemAccess(reg=reg, data_to_mem=data, address_offset=front_left_encoder_address).write()
		self.front_left = -1
		MemAccess(reg=reg, data_to_mem=data, address_offset=front_right_encoder_address).write()
		self.front_right = -1
		MemAccess(reg=reg, data_to_mem=data, address_offset=rear_left_encoder_address).write()
		self.rear_left = -1
		MemAccess(reg=reg, data_to_mem=data, address_offset=rear_right_encoder_address).write()
		self.rear_right = -1
		self.state = -1

	def rotate_left(self, reg):
		# hardcode write value - 1 means go forward
		# hardcode write value - -1 means go backward (probably need different value to write to address rather than negative number - 0 represents idle)
		forward_data = 1
		backward_data = -1
		MemAccess(reg=reg, data_to_mem=backward_data, address_offset=front_left_encoder_address).write()
		self.front_left = -1
		MemAccess(reg=reg, data_to_mem=forward_data, address_offset=front_right_encoder_address).write()
		self.front_right = 1
		MemAccess(reg=reg, data_to_mem=backward_data, address_offset=rear_left_encoder_address).write()
		self.rear_left = -1
		MemAccess(reg=reg, data_to_mem=forward_data, address_offset=rear_right_encoder_address).write()
		self.rear_right = 1

	def rotate_right(self, reg):
		# hardcode write value - 1 means go forward
		# hardcode write value - -1 means go backward (probably need different value to write to address rather than negative number - 0 represents idle)
		forward_data = 1
		backward_data = -1
		MemAccess(reg=reg, data_to_mem=forward_data, address_offset=front_left_encoder_address).write()
		self.front_left = 1
		MemAccess(reg=reg, data_to_mem=backward_data, address_offset=front_right_encoder_address).write()
		self.front_right = -1
		MemAccess(reg=reg, data_to_mem=forward_data, address_offset=rear_left_encoder_address).write()
		self.rear_left = 1
		MemAccess(reg=reg, data_to_mem=backward_data, address_offset=rear_right_encoder_address).write()
		self.rear_right = -1

	def fetch(self, reg, address):
		MemAccess(reg=reg, address_offset=address).fetch()
