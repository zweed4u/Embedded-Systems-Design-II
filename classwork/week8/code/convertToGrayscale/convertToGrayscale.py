import cv2
img = cv2.imread('../images/redBall.jpg',cv2.IMREAD_GRAYSCALE)
cv2.imshow('Red Ball',img)
cv2.waitKey()