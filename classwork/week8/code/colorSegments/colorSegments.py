import cv2
img = cv2.imread('../images/rgbBall-1.jpg')
hsv_img = cv2.cvtColor(img,cv2.COLOR_BGR2HSV)

cv2.imshow('H',img[:,:,0])
cv2.imshow('S',img[:,:,1])
cv2.imshow('V',img[:,:,2])
cv2.waitKey()