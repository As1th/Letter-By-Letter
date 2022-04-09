import cv2
import tensorflow as tf
import numpy as np
import pandas as pd
from skimage.metrics import structural_similarity

def prepareBW(file, BWsensitivity):
    img_array = cv2.imread(file, cv2.IMREAD_ANYCOLOR)
    grayImage = cv2.cvtColor(img_array, cv2.COLOR_BGR2GRAY)
    (thresh, blackAndWhiteImage) = cv2.threshold(grayImage, BWsensitivity, 255, cv2.THRESH_BINARY)
    return blackAndWhiteImage