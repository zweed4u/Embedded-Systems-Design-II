#!/usr/bin/python3

import urllib.request
import cv2
import numpy as np
import os

def save_raw_image():
    neg_images_links = [
        'http://www.image-net.org/api/text/imagenet.synset.geturls?wnid=n00523513',
        'http://www.image-net.org/api/text/imagenet.synset.geturls?wnid=n07942152',
        'http://www.image-net.org/api/text/imagenet.synset.geturls?wnid=n09287968']
    pic_num = 1
    for link in neg_images_links:
        neg_image_urls = urllib.request.urlopen(link).read().decode()
        if not os.path.exists('brick_neg'):
            os.makedirs('brick_neg')

        for url in neg_image_urls.split('\n'):
            try:
                print(url)
                urllib.request.urlretrieve(url,
                                           'brick_neg/{}.jpg'.format(str(pic_num)))

                # Grayscale and resize the downloaded image to 100x100 for negatives
                img = cv2.imread('brick_neg/{}.jpg'.format(str(pic_num)),
                                 cv2.IMREAD_GRAYSCALE)
                resized_img = cv2.resize(img, (100, 100))
                cv2.imwrite('brick_neg/{}.jpg'.format(str(pic_num)), resized_img)
                pic_num += 1
            except Exception as e:
                print(str(e))


save_raw_image()
