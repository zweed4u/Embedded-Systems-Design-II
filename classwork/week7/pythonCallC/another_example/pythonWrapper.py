#!/usr/bin/python
from ctypes import cdll
lib = cdll.LoadLibrary('./helloFoo.so')
print 'Passing 5 into foo function in HelloFoo shared object'
lib.foo(5)
print 'Main function in HelloFoo shared object'
lib.main()