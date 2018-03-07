#!/usr/bin/python2
# Zachary Weeden 2018

import cv2
import numpy as np

# BGR to HSV format - samples of reds on brick
print "BGR to HSV array samples used for bounds"

dark_red = np.uint8([[[50, 30, 150]]])
print cv2.cvtColor(dark_red, cv2.COLOR_BGR2HSV)

dark_red = np.uint8([[[50, 40, 180]]])
print cv2.cvtColor(dark_red, cv2.COLOR_BGR2HSV)

dark_red = np.uint8([[[40, 30, 150]]])
print cv2.cvtColor(dark_red, cv2.COLOR_BGR2HSV)

dark_red = np.uint8([[[40, 30, 180]]])
print cv2.cvtColor(dark_red, cv2.COLOR_BGR2HSV)

# light red - brick on top
light_red = np.uint8([[[125, 120, 255]]])
print cv2.cvtColor(light_red, cv2.COLOR_BGR2HSV)

# SUPER light red - brick on top left/right
light_red = np.uint8([[[160, 150, 240]]])
print cv2.cvtColor(light_red, cv2.COLOR_BGR2HSV)

capture = cv2.VideoCapture(0)

while 1:
    ret, img = capture.read()

    # read colors in hsv for range purposes
    hue_saturation_value = cv2.cvtColor(img, cv2.COLOR_BGR2HSV)

    # set bounds for object detection - make dynamic - maybe average all conversion calls above and add tolerance to each element in tuple/array for vals
    lower_red = np.array([130, 80, 130])
    upper_red = np.array([210, 230, 255])

    # Create our mask which is in within range - if in range = 1 (white) - out of range = black
    mask = cv2.inRange(hue_saturation_value, lower_red, upper_red)
    result = cv2.bitwise_and(img, img, mask=mask)

    # 15*15, average of 15x15 pixels
    kernel = np.ones((15, 15), np.float32) / 255

    # apply kernel for smoothing
    smooth = cv2.filter2D(result, -1, kernel)

    # Various blurs
    blur = cv2.GaussianBlur(result, (15, 15), 0)
    median = cv2.medianBlur(result, 15)
    bilateral = cv2.bilateralFilter(result, 15, 75, 75)


    # Show windows
    cv2.imshow('Original Image', img)
    cv2.imshow('Filtered Image Mask', mask)
    cv2.imshow('Filter Result', result)
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
