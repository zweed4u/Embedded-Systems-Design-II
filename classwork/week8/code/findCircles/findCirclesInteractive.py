import cv2
import numpy as np
import copy

# cv2.HoughCircles(image, method, dp, minDist)
# image:      8-bit, single channel image.  If working with a color image, convert to grayscale first.
# method:     Defines the method to detect circles in images. Currently, the only implemented method is cv2.HOUGH_GRADIENT, which corresponds to the Yuen et al. paper.
# dp:         This parameter is the inverse ratio of the accumulator resolution to the image resolution (see Yuen et al. for more details). Essentially, the larger the dp gets, the smaller the accumulator array gets.
# minDist:    Minimum distance between the center (x, y) coordinates of detected circles. If the minDist is too small, multiple circles in the same neighborhood as the original may be (falsely) detected. If the minDist is too large, then some circles may not be detected at all.
# empty array input
# param1:     Gradient value used to handle edge detection in the Yuen et al. method.
# param2:     Accumulator threshold value for the cv2.HOUGH_GRADIENT method. The smaller the threshold is, the more circles will be detected (including false circles). The larger the threshold is, the more circles will potentially be returned.
# minRadius:  Minimum size of the radius (in pixels).
# maxRadius:  Maximum size of the radius (in pixels).

def nothing(x):
    pass
    
cv2.namedWindow('Threshold')
cv2.createTrackbar('dp', 'Threshold',1,255,nothing)
cv2.createTrackbar('minDist', 'Threshold',1,255,nothing)
cv2.createTrackbar('gradient', 'Threshold',1,255,nothing)
cv2.createTrackbar('accumulator', 'Threshold',1,255,nothing)
cv2.createTrackbar('minRadius', 'Threshold',1,255,nothing)
cv2.createTrackbar('maxRadius', 'Threshold',1,1000,nothing)


cv2.setTrackbarPos('dp', 'Threshold',30)
cv2.setTrackbarPos('maxRadius', 'Threshold',400)
img = cv2.imread('../images/rgbBall-1.jpg',cv2.IMREAD_GRAYSCALE)
img = cv2.resize(img,(640,480))

while(1):
  # get info from track bar and appy to result
  dp = cv2.getTrackbarPos('dp','Threshold')
  minDist = cv2.getTrackbarPos('minDist','Threshold')
  gradient = cv2.getTrackbarPos('gradient','Threshold')
  accumulator = cv2.getTrackbarPos('accumulator','Threshold')
  minRadius = cv2.getTrackbarPos('minRadius','Threshold')
  maxRadius = cv2.getTrackbarPos('maxRadius','Threshold')

  circles = cv2.HoughCircles(img, cv2.HOUGH_GRADIENT, dp, minDist, np.array([]), gradient, accumulator, minRadius, maxRadius)

  clone_img = copy.copy(img)
  
  if circles is not None:
    circles = np.uint16(np.around(circles))
    for i in circles[0,:]:
      # draw the outer circle
      cv2.circle(clone_img,(i[0],i[1]),i[2],(0,255,0),2)
      # draw the center of the circle
      cv2.circle(clone_img,(i[0],i[1]),2,(0,0,255),3)
  
  cv2.imshow('detected circles',clone_img)
  k = cv2.waitKey(5) & 0xFF
  if k == 27:
    break
     
cv2.destroyAllWindows()