import cv2
import numpy as np
img = cv2.imread('../images/rgbBall-1.jpg',cv2.IMREAD_GRAYSCALE)

def nothing(x):
    pass

cv2.namedWindow('Canny')
cv2.createTrackbar('min','Canny',0,500,nothing)
cv2.createTrackbar('max','Canny',0,500,nothing)

while(1):
  min = cv2.getTrackbarPos('min','Canny')
  max = cv2.getTrackbarPos('max','Canny')
  canny = cv2.Canny(img,min,max)
  cv2.imshow('Canny',canny)

  k = cv2.waitKey(5) & 0xFF
  if k == 27:
    break
  
cv2.waitKey()