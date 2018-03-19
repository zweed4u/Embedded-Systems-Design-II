from ctypes import cdll
lib = cdll.LoadLibrary('./helloFoo.so')
lib.foo(5)
