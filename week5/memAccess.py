# Dr. Kaputa
# basic python read/write from memory

import time
import mmap
import struct

# open dev mem and see to base address
f = open("/dev/mem", "r+b")
mem = mmap.mmap(f.fileno(), 32, offset=0x43c00000)

toMem = 1234
reg   = 4

mem.seek(reg)  
mem.write(struct.pack('l', toMem))

time.sleep(.5) 

mem.seek(reg)  
fromMem = struct.unpack('l', mem.read(4))[0] 
  
print reg + " = " + fromMem 
  
mem.close()
f.close()