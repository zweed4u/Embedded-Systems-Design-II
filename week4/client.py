from socket import *

host = "129.21.64.176"

print host

port=7777

s=socket(AF_INET, SOCK_STREAM)

print "socket made"

s.connect((host,port))

print "socket connected!!!"

msg=s.recv(1024)

print "Message from server : " + msg