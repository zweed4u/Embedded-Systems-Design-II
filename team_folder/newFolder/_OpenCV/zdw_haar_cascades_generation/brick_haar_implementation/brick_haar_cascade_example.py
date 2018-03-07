#!/usr/bin/python3
# Zachary Weeden 2018

import cv2

# Using our haar cascades
front_inverted_mid_crop_cascade = cv2.CascadeClassifier(
    'resized_front_inverted_mid_crop_cascade.xml')
back_inverted_right_crop_cascade = cv2.CascadeClassifier(
    'resized_back_inverted_right_crop_cascade.xml')
back_right_crop_cascade = cv2.CascadeClassifier(
    'resized_back_right_crop_cascade.xml')
back_inverted_left_crop_cascade = cv2.CascadeClassifier(
    'resized_back_inverted_left_crop_cascade.xml')
front_inverted_left_crop_cascade = cv2.CascadeClassifier(
    'resized_front_inverted_left_crop_cascade.xml')
front_left_crop_cascade = cv2.CascadeClassifier(
    'resized_front_left_crop_cascade.xml')
front_inverted_right_crop_cascade = cv2.CascadeClassifier(
    'resized_front_inverted_right_crop_cascade.xml')
front_mid_crop_cascade = cv2.CascadeClassifier(
    'resized_front_mid_crop_cascade.xml')
back_left_crop_cascade = cv2.CascadeClassifier(
    'resized_back_left_crop_cascade.xml')
front_right_crop_cascade = cv2.CascadeClassifier(
    'resized_front_right_crop_cascade.xml')
back_mid_crop_cascade = cv2.CascadeClassifier(
    'resized_back_mid_crop_cascade.xml')
back_inverted_mid_crop_cascade = cv2.CascadeClassifier(
    'resized_back_inverted_mid_crop_cascade.xml')

# Webcam
cap = cv2.VideoCapture(0)

while 1:
    # Read in feed - convert to gray
    ret, frame = cap.read()
    gray = cv2.cvtColor(frame, cv2.COLOR_BGR2GRAY)

    # Detect object
    front_middle_bricks = front_mid_crop_cascade.detectMultiScale(gray, 100,
                                                                  100)

    # Find brick and mark with cyan square and yellow text
    for (front_middle_brick_x, front_middle_brick_y, front_middle_brick_w,
         front_middle_brick_h) in front_middle_bricks:
        font = cv2.FONT_HERSHEY_SIMPLEX
        cv2.putText(frame, 'Detected brick (front middle)',
                    (front_middle_brick_x - front_middle_brick_w,
                     front_middle_brick_y - front_middle_brick_h), font, .5,
                    (0, 255, 255), 2, cv2.LINE_AA)
        cv2.rectangle(frame, (front_middle_brick_x, front_middle_brick_y),
                      (front_middle_brick_x + front_middle_brick_w,
                       front_middle_brick_y + front_middle_brick_h),
                      (255, 255, 0), 2)

    # Show video
    cv2.imshow('Video feed', frame)

    # Close all on 'q' press
    k = cv2.waitKey(5) & 0xFF
    if k == ord('q'):
        break

cap.release()
cv2.destroyAllWindows()
