#!/usr/bin/python
# Dr. Kaputa
# basic python read/write from memory

import sys
import time
import mmap
import struct

# open dev mem and see to base address
f = open("/dev/mem", "r+b")
mem = mmap.mmap(f.fileno(), 32, offset=0x41200000)

toMem = int(sys.argv[1])
reg   = 0

mem.seek(reg)  
mem.write(struct.pack('l', toMem))

time.sleep(.5) 

mem.seek(reg)  
fromMem = struct.unpack('l', mem.read(4))[0] 
  
print str(reg) + " = " + str(fromMem) 
  
mem.close()
f.close()
