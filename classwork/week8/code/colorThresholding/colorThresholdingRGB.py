import cv2
import numpy as np

img = cv2.imread('../images/rgbBall-2.jpg')
small_img = cv2.resize(img,(320,240))

def nothing(x):
    pass
    
# Creating a windows for later use
cv2.namedWindow('Image')
cv2.namedWindow('Threshold')

cv2.createTrackbar('red min', 'Threshold',0,255,nothing)
cv2.createTrackbar('red max', 'Threshold',0,255,nothing)
cv2.createTrackbar('green min', 'Threshold',0,255,nothing)
cv2.createTrackbar('green max', 'Threshold',0,255,nothing)
cv2.createTrackbar('blue min', 'Threshold',0,255,nothing)
cv2.createTrackbar('blue max', 'Threshold',0,255,nothing)


while(1):
    # get info from track bar and appy to result
    rMin = cv2.getTrackbarPos('red min','Threshold')
    rMax = cv2.getTrackbarPos('red max','Threshold')
    gMin = cv2.getTrackbarPos('green min','Threshold')
    gMax = cv2.getTrackbarPos('green max','Threshold')
    bMin = cv2.getTrackbarPos('blue min','Threshold')
    bMax = cv2.getTrackbarPos('blue max','Threshold')

    # generate threshold array
    lower = np.array([bMin,gMin,rMin])
    upper = np.array([bMax,gMax,rMax])
    
    #lower = np.array([0,0,39])
    #upper = np.array([108,67,205])
    
    mask = cv2.inRange(small_img, lower, upper)
    
    res = cv2.bitwise_and(small_img,small_img,mask=mask)
    
    cv2.imshow('Image',res)
    
    k = cv2.waitKey(5) & 0xFF
    if k == 27:
        break

cv2.destroyAllWindows()