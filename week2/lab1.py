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
        print self.contents
        control_bits = self.contents.split('\n')[1:]
        l_dir = []
        l = []
        r_dir = []
        r = []
        encoder_map = {}
        for row in control_bits:  # ensure that the line from the file was not empty
            if row.strip():
                l_dir.append(int(row[0]))
                l.append(int(row[2]))
                r_dir.append(int(row[4]))
                r.append(int(row[6]))
        encoder_map['l_dir'] = l_dir
        encoder_map['l'] = l
        encoder_map['r_dir'] = r_dir
        encoder_map['r'] = r
        return encoder_map


print json.dumps(Encoders().parse_file(), indent=4)
