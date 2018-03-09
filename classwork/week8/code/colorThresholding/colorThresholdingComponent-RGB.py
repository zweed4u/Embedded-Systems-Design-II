import cv2
import numpy as np

img = cv2.imread('../images/redBall.jpg')
small_img = cv2.resize(img,(320,240))
blue,green,red = cv2.split(small_img)

def nothing(x):
    pass
    
# Creating a windows for later use
cv2.namedWindow('blueComp')
cv2.namedWindow('greenComp')
cv2.namedWindow('redComp')

cv2.createTrackbar('hmin', 'blueComp',12,179,nothing)
cv2.createTrackbar('hmax', 'blueComp',37,179,nothing)

cv2.createTrackbar('smin', 'greenComp',96,255,nothing)
cv2.createTrackbar('smax', 'greenComp',255,255,nothing)

cv2.createTrackbar('vmin', 'redComp',186,255,nothing)
cv2.createTrackbar('vmax', 'redComp',255,255,nothing)

while(1):
    # get info from track bar and appy to result
    hmn = cv2.getTrackbarPos('hmin','blueComp')
    hmx = cv2.getTrackbarPos('hmax','blueComp')
    
    smn = cv2.getTrackbarPos('smin','greenComp')
    smx = cv2.getTrackbarPos('smax','greenComp')

    vmn = cv2.getTrackbarPos('vmin','redComp')
    vmx = cv2.getTrackbarPos('vmax','redComp')

    # Apply thresholding
    hthresh = cv2.inRange(np.array(blue),np.array(hmn),np.array(hmx))
    sthresh = cv2.inRange(np.array(green),np.array(smn),np.array(smx))
    vthresh = cv2.inRange(np.array(red),np.array(vmn),np.array(vmx))

    #Show the result in frames
    cv2.imshow('blueComp',hthresh)
    cv2.imshow('greenComp',sthresh)
    cv2.imshow('redComp',vthresh)
    
    k = cv2.waitKey(5) & 0xFF
    if k == 27:
        break

cv2.destroyAllWindows()