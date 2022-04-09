import cv2
import tensorflow as tf
import pandas as pd
import base64
from skimage.metrics import structural_similarity

#image encoded in base64. Should be from Flutter app
imageData = 'iVBORw0KGgoAAAANSUhEUgAAABwAAAAcCAIAAAD9b0jDAAABeklEQVRIDa3BoU5yAQCG4e/dHIniBbgRsbCZnI1iZHMkbQ5vgGSyGQ3eABvFQTKYTRQCSaubjZExE94/sXEmB84/eR7UHBpqDg01h4aaQ0NNBYCaalCzD5BkOp1eXFykAtTsA7y/v19eXqqpADU7AXd3d4PBAFBTAWp2AtQkQL/ff35+zj6oKQe8vr52u90kHx8fZ2dnavZBTTlAzRqgZh/UlDg6Orq+vn55eclas9lcrVbf39/ZCTUlADVFgJqdULPN29vb1dWVmqJardZoNL6+vlIONdsAKaemHGq2AdRsMxwOe72emhKo+eX09HSxWPz8/KQEMBwOb29vsw1qfgHU7ASo2QY1Rff3909PT2p2ms1m5+fnan5BTRHw+Pj48PCQfYDPz89Wq5Ui1BQBaipYLpfHx8dqilBTBKipBhiNRjc3N9mAmg31er3T6YzH41QzmUza7baaDajZAKj5H4CaDahZOzk5mc/nav4GNWuAmj9DzaGh5tD+AbfK5smRuZv2AAAAAElFTkSuQmCC'

imageData = base64.b64decode(imageData)
with open('./ImageModel/test.png', "wb") as imageFile:
    imageFile.write(imageData)
    imageFile.close
    imageFile = './ImageModel/test.png'

target = "A_U" #letter for this excercise. Should be from Flutter app
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

print(highScore)



print(tf.__version__)
print(cv2.__version__)
print(pd.__version__)
print(Flask.__version__)