"""
@author: Asith
"""
import cv2
import tensorflow as tf
import numpy as np # linear algebra
import pandas as pd # data processing, CSV file I/O (e.g. pd.read_csv)
character_mapping = pd.read_csv("./dataset/emnist-balanced-mapping.txt", 
                        delimiter = ' ', 
                        index_col=0, 
                        header=None, 
                        squeeze=True)

#maps predictions to character labels using a table of unicode values in emnist-balanced-mapping.txt
character_dictionary = {}
for index, label in enumerate(character_mapping):
    character_dictionary[index] = chr(label)

#edits dataset image to usable form (see visualise_dataset.py for more info)
def reshape_and_rotate(image):
    W = 28
    H = 28
    image = image.reshape(W, H)
    image = np.fliplr(image)
    image = np.rot90(image)
    return image

#prepares input image by adjusting colours, b/w filter, and resizing
def prepare(file, BWsensitivity):
    IMG_SIZE = 28
    img_array = cv2.imread(file, cv2.IMREAD_ANYCOLOR)
    grayImage = cv2.cvtColor(img_array, cv2.COLOR_BGR2GRAY)
    (thresh, blackAndWhiteImage) = cv2.threshold(grayImage, BWsensitivity, 255, cv2.THRESH_BINARY)
    cv2.imshow('Original image',img_array)
    cv2.imshow('Black white image', blackAndWhiteImage)
    cv2.waitKey(0)
    cv2.destroyAllWindows()
    img_array = cv2.bitwise_not(blackAndWhiteImage)
    new_array = cv2.resize(img_array, (IMG_SIZE, IMG_SIZE))
    cv2.imshow('Original image', img_array)
    cv2.imshow('Resized image', new_array)
    cv2.waitKey(0)
    cv2.destroyAllWindows()
    return new_array.reshape(-1, IMG_SIZE, IMG_SIZE, 1)

#image recognition test runtime:

image = "./ImageModel/test.png" #input image path
model = tf.keras.models.load_model('./ImageModel/balanced_recognition_model.h5') #trained model path
BWsensitivity = 130 #sensitivity of black/white filter. This could be user-adjusted
image = prepare(image, BWsensitivity)

prediction = model.predict([image])
#predictionlist = list(prediction[0])
print(prediction)
#print(prediction[0][10])
print(prediction.nonzero())
print(prediction.argmax())
print(character_dictionary[prediction.argmax()])







