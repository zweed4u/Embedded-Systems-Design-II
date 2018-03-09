import cv2
import numpy as np
img = cv2.imread('../images/rgbBall-1.jpg',cv2.IMREAD_GRAYSCALE)
laplacian = cv2.Laplacian(img,cv2.CV_64F)

cv2.imshow('Original',img)
cv2.imshow('Laplacian',laplacian)

cv2.waitKey()