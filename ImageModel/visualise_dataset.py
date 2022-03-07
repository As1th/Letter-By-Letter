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

#data to visualise
train_data = pd.read_csv('./dataset/emnist-balanced-test.csv', header=None)

X_train = train_data.loc[:, 1:]
y_train = train_data.loc[:, 0]

character_map = pd.read_csv("./dataset/emnist-balanced-mapping.txt", 
                        delimiter = ' ', 
                        index_col=0, 
                        header=None, 
                        squeeze=True)

#maps predictions to character labels using a table of unicode values in emnist-balanced-mapping.txt
character_dictionary = {}
for index, label in enumerate(character_map):
    character_dictionary[index] = chr(label)

#visualising random dataset images
sample_image = X_train.iloc[41]
sample_label = y_train.iloc[41]

W = 28
H = 28

print("Label entry 41:", character_dictionary[sample_label])
plt.imshow(sample_image.values.reshape(W, H), cmap=plt.cm.gray)
plt.show()

#images in the dataset are rotated and flipped by default, so must be adjusted at runtime
def reshape_and_rotate(image):
    W = 28
    H = 28
    image = image.reshape(W, H)
    image = np.fliplr(image)
    image = np.rot90(image)
    return image

print("Label entry 41:", character_dictionary[sample_label])
plt.imshow(reshape_and_rotate(sample_image.values), cmap=plt.cm.gray)
plt.show()

X_train = np.apply_along_axis(reshape_and_rotate, 1, X_train.values)

sample_image = X_train[41]
sample_label = y_train.iloc[41]
print("Label entry 42:", character_dictionary[sample_label])
plt.imshow(sample_image.reshape(W, H), cmap=plt.cm.gray)
plt.show()

for i in range(100, 104):
    plt.subplot(390 + (i+1))
    plt.imshow(X_train[i], cmap=plt.cm.gray)
    plt.title(character_dictionary[y_train[i]])