"""
@author: Asith
"""
import numpy as np
import pandas as pd
import matplotlib.pyplot as plt
from sklearn.model_selection import train_test_split
from keras import backend as K
from keras.models import Sequential, load_model
from keras.callbacks import EarlyStopping, ModelCheckpoint
from keras import layers
from keras import metrics
from keras.layers import *
from keras.utils import np_utils

def recall(y_true, y_pred):
    y_true = K.ones_like(y_true) 
    true_positives = K.sum(K.round(K.clip(y_true * y_pred, 0, 1)))
    all_positives = K.sum(K.round(K.clip(y_true, 0, 1)))
    
    recall = true_positives / (all_positives + K.epsilon())
    return recall

def precision(y_true, y_pred):
    y_true = K.ones_like(y_true) 
    true_positives = K.sum(K.round(K.clip(y_true * y_pred, 0, 1)))
    
    predicted_positives = K.sum(K.round(K.clip(y_pred, 0, 1)))
    precision = true_positives / (predicted_positives + K.epsilon())
    return precision

def f1_score(y_true, y_pred):
    precision1 = precision(y_true, y_pred)
    recall1 = recall(y_true, y_pred)
    return 2*((precision1*recall1)/(precision1+recall1+K.epsilon()))


#load training data
train_data = pd.read_csv('./dataset/emnist-balanced-train.csv', header=None) #needs to be unzipped first

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

#edits dataset image to readable form (see visualise_dataset.py for more info)
W = 28
H = 28
def reshape_and_rotate(image):
    image = image.reshape(W, H)
    image = np.fliplr(image)
    image = np.rot90(image)
    return image

X_train = np.apply_along_axis(reshape_and_rotate, 1, X_train.values)
X_train = X_train.astype('float32') / 255

classes = y_train.nunique()
y_train = np_utils.to_categorical(y_train, classes)

#reshape to fit model input shape
X_train = X_train.reshape(-1, W, H, 1)

#split 10% validation 
X_train, X_val, y_train, y_val = train_test_split(X_train, 
                                                  y_train, 
                                                  test_size= 0.1, 
                                                  random_state=88)

#build model                                                  
model = Sequential()
model.add(layers.Conv2D(filters=32, kernel_size=(5,5), padding='same', activation='relu', input_shape=(W, H, 1)))
model.add(layers.MaxPool2D(strides=2))
model.add(layers.Conv2D(filters=48, kernel_size=(5,5), padding='valid', activation='relu'))
model.add(layers.MaxPool2D(strides=2))
model.add(layers.Flatten())
model.add(layers.Dense(256, activation='relu'))
model.add(layers.Dense(84, activation='relu'))
model.add(layers.Dense(classes, activation='softmax'))
model.summary()

#train model
optimizer_name = 'adam'
model.compile(loss='categorical_crossentropy', optimizer=optimizer_name, metrics=['accuracy',
                                                                                f1_score, precision, recall,
                                                                                tf.keras.metrics.AUC(),
                                                                                metrics.categorical_accuracy])

early_stopping = EarlyStopping(monitor='val_loss', patience=4, verbose=1, mode='min')
mcp_save = ModelCheckpoint('balanced_recognition_model.h5', save_best_only=True, monitor='val_loss', verbose=1, mode='auto')
history = model.fit(X_train,
                    y_train, 
                    epochs=30, 
                    batch_size=32, 
                    verbose=1, 
                    validation_split=0.1,
                    callbacks=[early_stopping, mcp_save])