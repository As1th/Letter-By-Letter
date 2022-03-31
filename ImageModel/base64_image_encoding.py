import base64

import cv2
image = cv2.imread('./ImageModel/test.png', cv2.IMREAD_ANYCOLOR)

#encoding
image = cv2.resize(image, (28, 28))
cv2.imwrite('./ImageModel/test.png', image)

with open('./ImageModel/test.png', "rb") as image_file:
    string = base64.b64encode(image_file.read())

#decoding
string = string.decode('utf-8')
print(string)

read = base64.b64decode(string)

with open('./ImageModel/test2.png', "wb") as image2:
    image2.write(read)
    image2.close

newImage = cv2.imread('./ImageModel/test2.png', cv2.IMREAD_ANYCOLOR)
