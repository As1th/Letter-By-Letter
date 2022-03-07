"""
@author: Asith
"""
import numpy as np
import pandas as pd
import cv2
import matplotlib.pyplot as plt
from sklearn.model_selection import train_test_split
import tensorflow as tf
from keras.models import Sequential, load_model
from keras.callbacks import EarlyStopping, ModelCheckpoint
from keras import layers
from keras.layers import *
from keras.utils import np_utils
from tqdm import tqdm
import os

W = 28
H = 28

#edits test CSV images into usable form (see visualise_dataset.py for more info)
def reshape_and_rotate(image):
    image = image.reshape(W, H)
    image = np.fliplr(image)
    image = np.rot90(image)
    return image

#model test:
model = load_model('./ImageModel/balanced_recognition_model.h5')
model.summary()
test_data = pd.read_csv('./dataset/emnist-balanced-test.csv', header=None)
X_test = test_data.loc[:, 1:]
y_test = test_data.loc[:, 0]
X_test = np.apply_along_axis(reshape_and_rotate, 1, X_test.values)
y_test = np_utils.to_categorical(y_test, y_test.nunique())
X_test = X_test.astype('float32') / 255
X_test = X_test.reshape(-1,W, H, 1)
model.evaluate(X_test, y_test)