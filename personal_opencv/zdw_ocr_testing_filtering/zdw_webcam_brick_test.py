#!/usr/bin/python
# Zachary Weeden 2018

import cv2
import numpy as np

# BGR to HSV format - samples of reds on brick
print "BGR to HSV array samples used for bounds"

# 214929
dark_red = np.uint8([[[80, 70, 115]]])
print cv2.cvtColor(dark_red, cv2.COLOR_BGR2HSV)

dark_red = np.uint8([[[60, 50, 110]]])
print cv2.cvtColor(dark_red, cv2.COLOR_BGR2HSV)

dark_red = np.uint8([[[50, 25, 100]]])
print cv2.cvtColor(dark_red, cv2.COLOR_BGR2HSV)

dark_red = np.uint8([[[70, 50, 110]]])
print cv2.cvtColor(dark_red, cv2.COLOR_BGR2HSV)

dark_red = np.uint8([[[30, 20, 100]]])
print cv2.cvtColor(dark_red, cv2.COLOR_BGR2HSV)

dark_red = np.uint8([[[30, 20, 90]]])
print cv2.cvtColor(dark_red, cv2.COLOR_BGR2HSV)

# 215032
dark_red = np.uint8([[[25, 15, 90]]])
print cv2.cvtColor(dark_red, cv2.COLOR_BGR2HSV)

dark_red = np.uint8([[[60, 50, 100]]])
print cv2.cvtColor(dark_red, cv2.COLOR_BGR2HSV)

dark_red = np.uint8([[[40, 30, 95]]])
print cv2.cvtColor(dark_red, cv2.COLOR_BGR2HSV)

dark_red = np.uint8([[[35, 15, 85]]])
print cv2.cvtColor(dark_red, cv2.COLOR_BGR2HSV)

dark_red = np.uint8([[[40, 30, 90]]])
print cv2.cvtColor(dark_red, cv2.COLOR_BGR2HSV)

dark_red = np.uint8([[[20, 20, 90]]])
print cv2.cvtColor(dark_red, cv2.COLOR_BGR2HSV)

dark_red = np.uint8([[[20, 10, 85]]])
print cv2.cvtColor(dark_red, cv2.COLOR_BGR2HSV)

# NEW_front_close
dark_red = np.uint8([[[70, 55, 140]]])
print cv2.cvtColor(dark_red, cv2.COLOR_BGR2HSV)

dark_red = np.uint8([[[60, 30, 130]]])
print cv2.cvtColor(dark_red, cv2.COLOR_BGR2HSV)

dark_red = np.uint8([[[60, 50, 140]]])
print cv2.cvtColor(dark_red, cv2.COLOR_BGR2HSV)

# NEW_close_3
dark_red = np.uint8([[[55, 45, 110]]])
print cv2.cvtColor(dark_red, cv2.COLOR_BGR2HSV)

dark_red = np.uint8([[[65, 50, 125]]])
print cv2.cvtColor(dark_red, cv2.COLOR_BGR2HSV)

dark_red = np.uint8([[[45, 30, 105]]])
print cv2.cvtColor(dark_red, cv2.COLOR_BGR2HSV)

dark_red = np.uint8([[[60, 40, 120]]])
print cv2.cvtColor(dark_red, cv2.COLOR_BGR2HSV)

dark_red = np.uint8([[[70, 60, 125]]])
print cv2.cvtColor(dark_red, cv2.COLOR_BGR2HSV)

# NEW_close_2
dark_red = np.uint8([[[80, 65, 150]]])
print cv2.cvtColor(dark_red, cv2.COLOR_BGR2HSV)

dark_red = np.uint8([[[65, 55, 150]]])
print cv2.cvtColor(dark_red, cv2.COLOR_BGR2HSV)

dark_red = np.uint8([[[60, 40, 145]]])
print cv2.cvtColor(dark_red, cv2.COLOR_BGR2HSV)

dark_red = np.uint8([[[80, 45, 150]]])
print cv2.cvtColor(dark_red, cv2.COLOR_BGR2HSV)

dark_red = np.uint8([[[77, 55, 145]]])
print cv2.cvtColor(dark_red, cv2.COLOR_BGR2HSV)

capture = cv2.VideoCapture(0)

# img = cv2.imread('brick_images/2018-03-06-214929.jpg')
img = cv2.imread('brick_images/2018-03-06-215032_1.jpg')
# img = cv2.imread('brick_images/NEW_front_close.jpg')
# img = cv2.imread('brick_images/NEW_front_close3.jpg')
# img = cv2.imread('brick_images/NEW_front_close_2.jpg')

hue_saturation_value_img = cv2.cvtColor(img, cv2.COLOR_BGR2HSV)
lower_red = np.array([160, 90, 80])
upper_red = np.array([180, 210, 155])
mask_img = cv2.inRange(hue_saturation_value_img, lower_red, upper_red)
result_img = cv2.bitwise_and(img, img, mask=mask_img)

# 15*15, average of 15x15 pixels
kernel = np.ones((15, 15), np.float32) / 255

# Various blurs - perform relatively poorly with still image
# blur = cv2.GaussianBlur(result_img, (15, 15), 0)
# median = cv2.medianBlur(result_img, 15)
# bilateral = cv2.bilateralFilter(result_img, 15, 75, 75)
#
# cv2.imshow('Filtering and Gauss Blur Img', blur)
# cv2.imshow('Filtering and Median Blur Img', median)
# cv2.imshow('Filtering and Bilateral Blur Img', bilateral)

cv2.imshow('Original Image', img)
cv2.imshow('Filtered Image Mask', mask_img)
cv2.imshow('Filter Result', result_img)

while 1:
    ret, frame = capture.read()

    # read colors in hsv for range purposes
    hue_saturation_value = cv2.cvtColor(frame, cv2.COLOR_BGR2HSV)

    # set bounds for object detection - make dynamic - maybe average all conversion calls above and add tolerance to each element in tuple/array for vals
    # 2018-03-06-214929 also work well for 215032_1 and NEW_front_close*
    # Defined above/outside while loop
    # lower_red = np.array([160, 90, 80])
    # upper_red = np.array([180, 210, 155])

    # Create our mask which is in within range - if in range = 1 (white) - out of range = black
    mask = cv2.inRange(hue_saturation_value, lower_red, upper_red)
    result = cv2.bitwise_and(frame, frame, mask=mask)

    """
    # 15*15, average of 15x15 pixels
    kernel = np.ones((15, 15), np.float32) / 255

    # apply kernel for smoothing
    smooth = cv2.filter2D(result, -1, kernel)

    # Various blurs
    blur = cv2.GaussianBlur(result, (15, 15), 0)
    median = cv2.medianBlur(result, 15)
    bilateral = cv2.bilateralFilter(result, 15, 75, 75)
    """

    # Show windows
    cv2.imshow('Original Frame', frame)
    cv2.imshow('Filtered Frame Mask', mask)
    cv2.imshow('Filter Frame Result', result)
    # cv2.imshow('Filtering and Smoothing', smooth)
    # cv2.imshow('Filtering and Gauss Blur', blur)
    # cv2.imshow('Filtering and Median Blur', median)
    # cv2.imshow('Filtering and Bilateral Blur', bilateral)

    # If 'q' is pressed
    if cv2.waitKey(1) & 0xFF == ord('q'):
        break

# Release webcam from CV so we can use in other processes
capture.release()
cv2.destroyAllWindows()
