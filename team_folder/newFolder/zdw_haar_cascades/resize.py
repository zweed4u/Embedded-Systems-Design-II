#!/usr/bin/python3
# Zachary Weeden

import urllib.request
import cv2
import numpy as np
import os

for pic in os.listdir('brick_crop_resize'):
    try:
        img = cv2.imread('brick_crop_resize/{}'.format(pic), cv2.IMREAD_COLOR)
        resized_img = cv2.resize(img, (75, 75))
        cv2.imwrite('brick_crop_resize/resized_{}.jpg'.format(pic), resized_img)
    except Exception as e:
        print(str(e))