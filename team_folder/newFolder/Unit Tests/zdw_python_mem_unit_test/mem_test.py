#!/usr/bin/python
# Zachary Weeden 2018 - Memory Access Unit test

import sys
import unittest
from mem_address import MemAccess


class MemTest(unittest.TestCase):
    # Ick
    _mem_address = None
    _reg = None
    _data = None

    def setUp(self):
        pass

    def test_write_0_reg_0(self):
        MemAccess().write(reg=0, data_to_mem=0, address_offset=self._mem_address)
        self.assertEqual(int(MemAccess().fetch(reg=0, address_offset=self._mem_address)), 0)
 
    def test_write_1_reg_0(self):
        MemAccess().write(reg=0, data_to_mem=1, address_offset=self._mem_address)
        self.assertEqual(int(MemAccess().fetch(reg=0, address_offset=self._mem_address)), 1)

    def test_parameterization_read_write(self):
        MemAccess().write(reg=self._reg, data_to_mem=self._data, address_offset=self._mem_address)
        self.assertEqual(int(MemAccess().fetch(reg=self._reg, address_offset=self._mem_address)), self._data)
 
if __name__ == '__main__':
    """
    This is extremely bad practice and is more of an integration test
    than anything with parameterization but allows for easy interface 
    for poking mem from cli
    TODO: Values should be replaced/hardcoded once solidified
    """
    if len(sys.argv) > 4:
        print 'No tests ran - execute via \'./test.py 0x41300000 1 1\' (substituting address, register and data)'
        sys.exit()

    # can't access via index - pop() so cli params don't interfere with unittest's params 
    MemTest._data = int(sys.argv.pop())
    MemTest._reg = int(sys.argv.pop())
    MemTest._mem_address = int(sys.argv.pop())
    unittest.main()
