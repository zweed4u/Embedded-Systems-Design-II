#!/usr/bin/python
"""
Zachary Weeden
CPET-563 Lab 1
January 23, 2018
"""
import os
import json

hw_flag = 0  # 0 = read from file


class Encoders:
    def __init__(self, hw_flag):
        """Constructor for Encoder class"""
        self.hw_flag = hw_flag
        self.contents = None
        self.number_of_instructions = 0

    def get_encoders(self):
        """
        Opens the encoders text file and stores it into class attribute
        Assumes that the encoders txt file is named appropriately and in the same directory as invocation
        :return: str - the contents of the encoders.txt file
        """
        with open(os.getcwd() + '/encoders.txt', 'r') as f:
            self.contents = f.read()
        return self.contents

    def parse_file(self):
        """
        Parse the actual encoder text into usable data structure
        :return: dict - {'header_from_1st_row': [array_of_values_for_given_column]}
        """
        # Read from file
        if self.hw_flag == 0:
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
                    self.number_of_instructions += 1
            encoder_map[headers[0]] = l_dir
            encoder_map[headers[1]] = left
            encoder_map[headers[2]] = r_dir
            encoder_map[headers[3]] = right
            return encoder_map
        elif self.hw_flag == 1:
            return 0


parsed_encoders = Encoders(hw_flag).parse_file()
print json.dumps(parsed_encoders, indent=4)
# Works for when hw_flag = 0, read from file as headers (1st line) is used as keys
left_dir = parsed_encoders['l_dir']
left = parsed_encoders['left']
right_dir = parsed_encoders['r_dir']
right = parsed_encoders['right']
for l, r in zip(left, right):
    print "{} {}".format(l, r)
