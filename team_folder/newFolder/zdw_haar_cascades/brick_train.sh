#!/bin/bash

# Create positive samples here...
opencv_createsamples -img resized_back_inverted_left_crop.jpg -bg bg.txt -info resized_back_inverted_left_crop_info/info.lst -pngoutput resized_back_inverted_left_crop_info -maxxangle 0.5 -maxyangle -0.5 -maxzangle 0.5 -num 1900
opencv_createsamples -img resized_back_inverted_mid_crop.jpg -bg bg.txt -info resized_back_inverted_mid_crop_info/info.lst -pngoutput resized_back_inverted_mid_crop_info -maxxangle 0.5 -maxyangle -0.5 -maxzangle 0.5 -num 1900
opencv_createsamples -img resized_back_inverted_right_crop.jpg -bg bg.txt -info resized_back_inverted_right_crop_info/info.lst -pngoutput resized_back_inverted_right_crop_info -maxxangle 0.5 -maxyangle -0.5 -maxzangle 0.5 -num 1900

opencv_createsamples -img resized_back_left_crop.jpg -bg bg.txt -info resized_back_left_crop_info/info.lst -pngoutput resized_back_left_crop_info -maxxangle 0.5 -maxyangle -0.5 -maxzangle 0.5 -num 1900
opencv_createsamples -img resized_back_mid_crop.jpg -bg bg.txt -info resized_back_mid_crop_info/info.lst -pngoutput resized_back_mid_crop_info -maxxangle 0.5 -maxyangle -0.5 -maxzangle 0.5 -num 1900
opencv_createsamples -img resized_back_right_crop.jpg -bg bg.txt -info resized_back_right_crop_info/info.lst -pngoutput resized_back_right_crop_info -maxxangle 0.5 -maxyangle -0.5 -maxzangle 0.5 -num 1900

opencv_createsamples -img resized_front_inverted_left_crop.jpg -bg bg.txt -info resized_front_inverted_left_crop_info/info.lst -pngoutput resized_front_inverted_left_crop_info -maxxangle 0.5 -maxyangle -0.5 -maxzangle 0.5 -num 1900
opencv_createsamples -img resized_front_inverted_mid_crop.jpg -bg bg.txt -info resized_front_inverted_mid_crop_info/info.lst -pngoutput resized_front_inverted_mid_crop_info -maxxangle 0.5 -maxyangle -0.5 -maxzangle 0.5 -num 1900
opencv_createsamples -img resized_front_inverted_right_crop.jpg -bg bg.txt -info resized_front_inverted_right_crop_info/info.lst -pngoutput resized_front_inverted_right_crop_info -maxxangle 0.5 -maxyangle -0.5 -maxzangle 0.5 -num 1900

opencv_createsamples -img resized_front_left_crop.jpg -bg bg.txt -info resized_front_left_crop_info/info.lst -pngoutput resized_front_left_crop_info -maxxangle 0.5 -maxyangle -0.5 -maxzangle 0.5 -num 1900
opencv_createsamples -img resized_front_mid_crop.jpg -bg bg.txt -info resized_front_mid_crop_info/info.lst -pngoutput resized_front_mid_crop_info -maxxangle 0.5 -maxyangle -0.5 -maxzangle 0.5 -num 1900
opencv_createsamples -img resized_front_right_crop.jpg -bg bg.txt -info resized_front_right_crop_info/info.lst -pngoutput resized_front_right_crop_info -maxxangle 0.5 -maxyangle -0.5 -maxzangle 0.5 -num 1900

# Create vector commands here...
opencv_createsamples -info resized_back_inverted_left_crop_info/info.lst -num 1900 -w 20 -h 20 -vec resized_back_inverted_left_crop_positives.vec
opencv_createsamples -info resized_back_inverted_mid_crop_info/info.lst -num 1900 -w 20 -h 20 -vec resized_back_inverted_mid_crop_positives.vec
opencv_createsamples -info resized_back_inverted_right_crop_info/info.lst -num 1900 -w 20 -h 20 -vec resized_back_inverted_right_crop_positives.vec

opencv_createsamples -info resized_back_left_crop_info/info.lst -num 1900 -w 20 -h 20 -vec resized_back_left_crop_positives.vec
opencv_createsamples -info resized_back_mid_crop_info/info.lst -num 1900 -w 20 -h 20 -vec resized_back_mid_crop_positives.vec
opencv_createsamples -info resized_back_right_crop_info/info.lst -num 1900 -w 20 -h 20 -vec resized_back_right_crop_positives.vec

opencv_createsamples -info resized_front_inverted_left_crop_info/info.lst -num 1900 -w 20 -h 20 -vec resized_front_inverted_left_crop_positives.vec
opencv_createsamples -info resized_front_inverted_mid_crop_info/info.lst -num 1900 -w 20 -h 20 -vec resized_front_inverted_mid_crop_positives.vec
opencv_createsamples -info resized_front_inverted_right_crop_info/info.lst -num 1900 -w 20 -h 20 -vec resized_front_inverted_right_crop_positives.vec

opencv_createsamples -info resized_front_left_crop_info/info.lst -num 1900 -w 20 -h 20 -vec resized_front_left_crop_positives.vec
opencv_createsamples -info resized_front_mid_crop_info/info.lst -num 1900 -w 20 -h 20 -vec resized_front_mid_crop_positives.vec
opencv_createsamples -info resized_front_right_crop_info/info.lst -num 1900 -w 20 -h 20 -vec resized_front_right_crop_positives.vec

# Train commands here...
opencv_traincascade -data resized_back_inverted_left_crop_data -vec resized_back_inverted_left_crop_positives.vec -bg bg.txt -numPos 1800 -numNeg 900 -numStages 10 -w 20 -h 20
opencv_traincascade -data resized_back_inverted_mid_crop_data -vec resized_back_inverted_mid_crop_positives.vec -bg bg.txt -numPos 1800 -numNeg 900 -numStages 10 -w 20 -h 20
opencv_traincascade -data resized_back_inverted_right_crop_data -vec resized_back_inverted_right_crop_positives.vec -bg bg.txt -numPos 1800 -numNeg 900 -numStages 10 -w 20 -h 20

opencv_traincascade -data resized_back_left_crop_data -vec resized_back_left_crop_positives.vec -bg bg.txt -numPos 1800 -numNeg 900 -numStages 10 -w 20 -h 20
opencv_traincascade -data resized_back_mid_crop_data -vec resized_back_mid_crop_positives.vec -bg bg.txt -numPos 1800 -numNeg 900 -numStages 10 -w 20 -h 20
opencv_traincascade -data resized_back_right_crop_data -vec resized_back_right_crop_positives.vec -bg bg.txt -numPos 1800 -numNeg 900 -numStages 10 -w 20 -h 20

opencv_traincascade -data resized_front_inverted_left_crop_data -vec resized_front_inverted_left_crop_positives.vec -bg bg.txt -numPos 1800 -numNeg 900 -numStages 10 -w 20 -h 20
opencv_traincascade -data resized_front_inverted_mid_crop_data -vec resized_front_inverted_mid_crop_positives.vec -bg bg.txt -numPos 1800 -numNeg 900 -numStages 10 -w 20 -h 20
opencv_traincascade -data resized_front_inverted_right_crop_data -vec resized_front_inverted_right_crop_positives.vec -bg bg.txt -numPos 1800 -numNeg 900 -numStages 10 -w 20 -h 20

opencv_traincascade -data resized_front_left_crop_data -vec resized_front_left_crop_positives.vec -bg bg.txt -numPos 1800 -numNeg 900 -numStages 10 -w 20 -h 20
opencv_traincascade -data resized_front_mid_crop_data -vec resized_front_mid_crop_positives.vec -bg bg.txt -numPos 1800 -numNeg 900 -numStages 10 -w 20 -h 20
opencv_traincascade -data resized_front_right_crop_data -vec resized_front_right_crop_positives.vec -bg bg.txt -numPos 1800 -numNeg 900 -numStages 10 -w 20 -h 20
