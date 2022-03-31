from flask import Flask, jsonify, request
import json
import cv2
import tensorflow as tf
import pandas as pd
import base64
from skimage.metrics import structural_similarity

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
    return blackAndWhiteImage

def prepareArray(new_array):
    IMG_SIZE = 28
    new_array = cv2.bitwise_not(new_array)
    return new_array.reshape(-1, IMG_SIZE, IMG_SIZE, 1)

def matchShape(image, comparison):
    m1 = cv2.matchShapes(image,comparison,cv2.CONTOURS_MATCH_I2,0)
    print("distance : {}".format(m1))
    return m1

character_mapping = pd.read_csv("./dataset/emnist-balanced-mapping.txt", 
                            delimiter = ' ', 
                            index_col=0, 
                            header=None, 
                            squeeze=True)
                            
#maps predictions to character labels using a table of unicode values in emnist-balanced-mapping.txt
character_dictionary = {}
for index, label in enumerate(character_mapping):
    character_dictionary[index] = chr(label)

model = tf.keras.models.load_model('./ImageModel/balanced_recognition_model.h5') #trained model path

#declared an empty variable for reassignment
response = ''

#creating the instance of our flask application
app = Flask(__name__)

#route to entertain our post and get request from flutter app
@app.route('/score', methods = ['POST'])
def nameRoute():

    #fetching the global response variable to manipulate inside the function
    global response

    request_data = request.data #getting the response data
    request_data = json.loads(request_data.decode('utf-8')) #converting it from json to key value pair
    imageData = request_data['img'] #assigning it to img
    target = request_data['target'] #assigning it to target
    imageData = base64.b64decode(imageData)
    with open('./ImageModel/test.png', "wb") as imageFile:
        imageFile.write(imageData)
        imageFile.close
        imageFile = './ImageModel/test.png'
    
    comparison = './ImageModel/CharacterImages/'+target+'.png'
        
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
        score = ssim - shape + 30
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
    highScore = int(round(highScore))
    print(highScore)
    
    response = highScore #re-assigning response 
    return jsonify({'score' : response}) #sending data back to frontend app

if __name__ == "__main__":
    app.run(debug=True)