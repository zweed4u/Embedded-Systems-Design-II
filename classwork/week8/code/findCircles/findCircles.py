import cv2
import numpy as np

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

img = cv2.imread('../images/redBall.jpg',cv2.IMREAD_GRAYSCALE)
img = cv2.resize(img,(640,480))
circles = cv2.HoughCircles(img, cv2.HOUGH_GRADIENT, 10, 400, np.array([]), 100, 30, 30, 100)

circles = np.uint16(np.around(circles))
for i in circles[0,:]:
    # draw the outer circle
    cv2.circle(img,(i[0],i[1]),i[2],(0,255,0),2)
    # draw the center of the circle
    cv2.circle(img,(i[0],i[1]),2,(0,0,255),3)

cv2.imshow('detected circles',img)
cv2.waitKey(0)
cv2.destroyAllWindows()