import cv2
import numpy as np

noBall = cv2.imread('noBall.jpg',cv2.IMREAD_GRAYSCALE)
ball = cv2.imread('ball.jpg',cv2.IMREAD_GRAYSCALE)
subtract = ball - noBall

def nothing(x):
    pass

cv2.namedWindow('Canny')
cv2.createTrackbar('min','Canny',0,500,nothing)
cv2.createTrackbar('max','Canny',0,500,nothing)

while(1):
  min = cv2.getTrackbarPos('min','Canny')
  max = cv2.getTrackbarPos('max','Canny')

  mask = cv2.inRange(subtract, min, max)
  cv2.imshow('Canny',subtract)
  cv2.imshow('Mask',mask)

  k = cv2.waitKey(5) & 0xFF
  if k == 27:
    break
  
cv2.waitKey()