#!/usr/bin/python
import os
import json


class Encoders:
    def __init__(self):
        self.contents = None

    def get_encoders(self):
        """Opens the encoders text file and stores it into class attribute"""
        with open(os.getcwd() + '/encoders.txt', 'r') as f:
            self.contents = f.read()
        return self.contents

    def parse_file(self):
        """Parse the actual encoder text"""
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
        encoder_map[headers[0]] = l_dir
        encoder_map[headers[1]] = left
        encoder_map[headers[2]] = r_dir
        encoder_map[headers[3]] = right
        return encoder_map


print json.dumps(Encoders().parse_file(), indent=4)
