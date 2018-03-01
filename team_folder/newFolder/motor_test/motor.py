#!/usr/bin/python
# Zachary Weeden 2018

from mem_access import MemAccess


class RoverMovement():
    def __init__(self):
        self.state = 0
        self.direction = 0
        self.front_left = 0
        self.front_right = 0
        self.rear_left = 0
        self.rear_right = 0

    def move(self, reg, data, address):
        MemAccess(reg=reg, data_to_mem=data, address_offset=address).write()

    def rotate(self, reg, data, address):
        MemAccess(reg=reg, data_to_mem=data, address_offset=address).write()

    def fetch(self, reg, address):
        MemAccess(reg=reg, address_offset=address).fetch()
