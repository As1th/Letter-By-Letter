import cv2
import tensorflow as tf
import numpy as np
import pandas as pd
import base64
from skimage.metrics import structural_similarity

#image encoded in base64. Should be from Flutter app
imageData = 'iVBORw0KGgoAAAANSUhEUgAAABwAAAAcCAIAAAD9b0jDAAAFVUlEQVRIDU3BXW9d1RUF0Dnn2vteO7YxoRhQEDyVKhJC9K1q/zWVCsoXNA51k7R9qXhCVapCVYgiY5zEuT3n7LVm7SuBOgYf3P0UJmjSq9VqWuagbLfW7FSoElWIYFX5UhlCiwaAVGsxTXOVudV7T5tf3vtMEoCqighcqUsRUVWSxhiSeu/LsvAnACQBsrMKP+u9VxW/vPcH0gDIuAQgMwFkZu9RJdtVBUBS5tT7OiLGGLwStiUBsA1AUmby8YM7dlbBJmkA6/Xq5cuLvb29i4uL7757evT22//4+uvW2s7OzmZzsbu7a3ualvV6/f777/febWdma40kSNg8Ob5Vy1it1tM0k5b0ySe/z6wPP/xwnudlWfp6/dr+/uHh4f7+vqTVal2VtrEliWRVSQIgyVl8dHw7M1tr0zTF1snJyUcffbyzs9N7H2NAIlljAKiqiAAQEdiS5EukcMV2750nX3zWWquqiFgqSZ6env7n39/9+uOPM1OCxbEMFAoQQBJA7x0om9gqIHilqiTx5PiWDNvYOjs7i9Xqq79/9bvf/qagaGyKygLlKgCkq1A1qAbSVSEBYARtSVXFxw/uACA5xpBk4+nT709Pz27e/FXvHQBpFE0BID3Pc0QnbfOStyKCZFVJqir+9U/3xhgkI2JZkvQ8jydPnty8+Uup2ZZkW5LtZVkkRHQ77QBgZ0SrsiTSAGzx8YM7mcn/s9lcfP/9s3ffvbGzs2M7M5dlWa1WmSnp1atXz5+/bE2r1c7BwYFtiRGqKm4Z4qPj2wBIVhUA21V1dvbD0dHRZjNP0yYzp2lqrb14cb4sZWNvb293d/f69evRmkgpyMo0SaAQwZMvPosISZkJwLbEZ89Onzz559HR0enp6QcffLC/v7+3t3dxcUGytbYsS0S01qqqNWWaTLKbRJUBPjq+ra1lWQCQHGP58cfzvb2D3d3dzGxN0zSRQTIiSNuwERG2JQGwHcSCIsI2//T5p601bY0xqioznz9/LrXXX39dUlXZBsAtoABWubVmGwC3vMUIXnp4/5YJkFVFoMpBbjab09OzGzdu0ICKFEmAAAFXGYCkzIyIqgLQWuPPHt6/BUDSZrNZrVbDxXLm+OGH8zfeeKP3npmtNZKtaZ7nKrTWqgpARIwxSK7X681m03tvq9U0TXx0fJuk7TEGgKqyUJVPnz578xdvrXsHShKvRA4bGRHcAhAR8zxXVWuNZGa21vjo+DZQgDLTZlW1Jpv/+vbbt95889q1a7Zba1UVEbXVex9jRMQ0Ta01krZJSqoqAHx4/5adZFQVUEBUWdL5+dm1a/t9tXINkq0JkE0AJKtK0rIsJG1HBLdsVxUfHd+VUFUASNhalgXA+fl5a+3w8BBkZrYICZJM1CgYZQMgGRH4SVVlJv/8x9urVRtj2M5MMnrvAF69ejVN02uv7WempKAKjghAEZymySYA2+v1Glskq8o2//Ll3Xmee+8AlmUB1FoD8OLFi3mM69ev2+YlWRISpKsKkLcASIoIAJIyUxIfHd+d5/+21mzrSstMksuynJ2dvfPOO0tmRFAmwpmSqkrSGAMAyYiQRNJbAPj4wb2qAhwhm2OMuMJlyWfPnh0dHUkimZmtNWxlZkQAGGOQjAhJ8xittRqj987HD+5VVWstc8nMiCADqEx/88037733nqTVapWZkqoKAMkxBgDbJCXhkgQgyLT58P4dSUCRBoStZVki4vz8xcHBQe/dNgBJYwxJALwFgKQkkqPq5cuXhwcHAPi3k8/HGBFRVbYzs/duA6CkeZ4BtNYkeau1Ns8zycxcr9eMsJ2ZuFQVEVX1PyAUu50Fd7WAAAAAAElFTkSuQmCC'

imageData = base64.b64decode(imageData)
with open('./ImageModel/test.png', "wb") as imageFile:
    imageFile.write(imageData)
    imageFile.close
    imageFile = './ImageModel/test.png'

target = "F_U" #letter for this excercise. Should be from Flutter app
comparison = './ImageModel/CharacterImages/'+target+'.png'
model = tf.keras.models.load_model('./ImageModel/balanced_recognition_model.h5') #trained model path

character_mapping = pd.read_csv("./dataset/emnist-balanced-mapping.txt", 
                        delimiter = ' ', 
                        index_col=0, 
                        header=None, 
                        squeeze=True)

#maps predictions to character labels using a table of unicode values in emnist-balanced-mapping.txt
character_dictionary = {}
for index, label in enumerate(character_mapping):
    character_dictionary[index] = chr(label)

#Needs images to be same dimensions
def structural_sim(img1, img2):

  sim, diff = structural_similarity(img1, img2, full=True)
  return sim

#prepares input image by adjusting colours, b/w filter, and resizing
def prepareBW(file, BWsensitivity):
    IMG_SIZE = 28
    img_array = cv2.imread(file, cv2.IMREAD_ANYCOLOR)
    img_array = cv2.resize(img_array, (IMG_SIZE, IMG_SIZE))
    grayImage = cv2.cvtColor(img_array, cv2.COLOR_BGR2GRAY)
    (thresh, blackAndWhiteImage) = cv2.threshold(grayImage, BWsensitivity, 255, cv2.THRESH_BINARY)
    # cv2.imshow('Original image',img_array)
    # cv2.imshow('Black white image', blackAndWhiteImage)
    # cv2.waitKey(0)
    # cv2.destroyAllWindows()
    return blackAndWhiteImage#.reshape(-1, IMG_SIZE, IMG_SIZE, 1)

def prepareArray(new_array):
    IMG_SIZE = 28
    new_array = cv2.bitwise_not(new_array)
    return new_array.reshape(-1, IMG_SIZE, IMG_SIZE, 1)

def matchShape(image, comparison):
    m1 = cv2.matchShapes(image,comparison,cv2.CONTOURS_MATCH_I2,0)
    print("distance : {}".format(m1))
    return m1
    
if target.endswith("_U"):
   target = target.replace("_U", "")

if target.__eq__("c") or target.__eq__("i") or target.__eq__("j") or target.__eq__("k") or target.__eq__("l") or target.__eq__("m") or target.__eq__("o") or target.__eq__("p") or target.__eq__("s") or target.__eq__("u") or target.__eq__("v") or target.__eq__("w") or target.__eq__("x") or target.__eq__("y") or target.__eq__("z"):
   target=target.capitalize()

comparison = prepareBW(comparison, 127)

BWsensitivity = 90
highScore = 0
for BWsensitivity in range (100, 250, 5):
    image = prepareBW(imageFile, BWsensitivity)
    ssim = structural_sim(image, comparison) #1.0 means identical. Lower = not similar
    print("Similarity using SSIM is: ", ssim)
    errorL2 = cv2.norm(image, comparison, cv2.NORM_L2 )
    similarity = 1-errorL2 / ( 28 * 28 )
    print('Similarity = ',similarity)

    shape = matchShape(image, comparison)
    image = prepareArray(image)
    prediction = model.predict([image])
    print(prediction.argmax())
    print(character_dictionary[prediction.argmax()])

    print(target)
    modelSuccess = False
    if character_dictionary[prediction.argmax()].__eq__(target):
      modelSuccess = True
      print("success")

    ssim = ssim * 100
    shape = shape * 1000
    score = ssim - shape + 26
    if modelSuccess:
        score += 25
        print("success added")
        if (ssim >= 35):
          score += 10
          print("bonus added")

    if score < 0:
      score = 0
    if score > 100:
      score = 100

    print(((cv2.countNonZero(image))))
    detected = ((cv2.countNonZero(image)))
    if detected < 10:
      score = 0

    print("Final score =",score)
    if score > highScore:
      highScore = score

print(highScore)