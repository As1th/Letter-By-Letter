// import 'dart:typed_data';
// import 'dart:io'as Io;
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'main.dart';
import 'dart:io';
import 'package:image_cropper/image_cropper.dart';





class MyUpload extends StatefulWidget {
  const MyUpload({Key? key}) : super(key: key);

  @override
  _MyUploadState createState() => _MyUploadState();
}

class _MyUploadState extends State<MyUpload> {
  static File? imageFile;

  void _getFromCamera() async {
    XFile? pickedFile = await ImagePicker().pickImage(
      source: ImageSource.camera,
      maxHeight: 180,
      maxWidth: 180,
    );
    setState((){
      _cropImage(pickedFile!.path);
    });
  }

  void _cropImage(filePath) async {
    File? croppedImage = await ImageCropper().cropImage (
      sourcePath: filePath, maxHeight: 180, maxWidth: 180);
    if (croppedImage != null) {
      setState(() {
        imageFile = croppedImage;
      });
    }
  }

  // get image from camera, resize to 28x28, encode to base64
  String imageData = "";
  bool loading = false;

  @override
  Widget build(BuildContext context) {
    Future<void> _showMyDialog() async {
      return showDialog<void>(
        context: context,
        barrierDismissible: false, //this means the user must tap a button to exit the Alert Dialog
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Loading!'),
            content: SingleChildScrollView(
              child: ListBody(
                children: <Widget>[
                  Text("You wrote a letter!\nWe're trying to calculate your score! 😄"),
                ],
              ),
            ),
            actions: <Widget>[
              TextButton(
                child: Text(''),
                onPressed: () {

                },
              ),
            ],
          );
        },
      );
    }

    return Container(
      decoration: BoxDecoration(
        image: DecorationImage(
            image: AssetImage('assets/img3.jpeg'), fit: BoxFit.cover),
      ),

      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: ListView(
          children: [

            Container(
              padding: EdgeInsets.only(top: 85),



              child: Text(
                'EXERCISE',
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.black87, fontSize: 40,fontWeight:FontWeight.bold ),
              ),


            ),


            SingleChildScrollView(
             child: Container(

                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      margin: EdgeInsets.only(left: 35, right: 35,top:50),
                      child: Column(
                        children: [
                          Text('Click "Submit" to upload the image\nClick "Scan" to retake the image',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 20,
                              color: Colors.pink,
                            ),

                          ),

                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [



                              TextButton(
                                onPressed: () {
                                  _getFromCamera();
                                },
                                child: Text('Scan',
                                  textAlign: TextAlign.left,
                                  style: TextStyle(color: Colors.white),
                                ),
                                style: ButtonStyle(
                                  backgroundColor: MaterialStateProperty.all(Colors.blueAccent),
                                  padding: MaterialStateProperty.all(EdgeInsets.all(12)),
                                  textStyle: MaterialStateProperty.all(TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                                ),
                              ),




                              TextButton(
                                  onPressed: () async {
                                    if (loading == false) {
                                      loading = true;
                                      score = 0;
                                      _showMyDialog();
                                      final bytes = imageFile?.readAsBytesSync();
                                      String imageData = base64Encode(bytes!);


                                      final url = 'https://letterwebservice-3hwu01lugmioao59.socketxp.com/score';
                                      try {
                                        final response = await http.post(
                                            Uri.parse(url), body: json.encode({
                                          'img': imageData,
                                          'target': target
                                        }));
                                        final decoded = json.decode(
                                            response.body) as Map<
                                            String,
                                            dynamic>;
                                        score = decoded['score'];

                                        print(score);
                                        if(int.parse(highScores[exerciseNumber]) < score) {
                                          highScores[exerciseNumber] =
                                              score.toString();
                                        }
                                        loading = false;
                                        if (score > 60) {
                                          gateways[(exerciseNumber + 1)] = 1;
                                          if(highScores[(exerciseNumber + 1)]=="LOCK") {
                                            highScores[(exerciseNumber + 1)] =
                                            "0";
                                          }
                                          Navigator.pushNamed(
                                              context, 'welldone');
                                        } else {
                                          Navigator.pushNamed(context, 'wrong');
                                        }
                                      }
                                      catch (e) {
                                        print(
                                            "Server error. Server is probably offline.");
                                        loading = false;
                                        Navigator.pushNamed(
                                            context, 'servererror');
                                      }
                                    }

                                  },


                                  child: Text('Submit',
                                    style: TextStyle(
                                      color: Colors.white),

                                  ),


                                  style: ButtonStyle(
                                    backgroundColor: MaterialStateProperty.all(Colors.blueAccent),
                                    padding: MaterialStateProperty.all(EdgeInsets.all(12)),
                                    textStyle: MaterialStateProperty.all(TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                                ),
                              ),

                              imageFile != null?
                              Container(
                                margin: EdgeInsets.only(top:50,left:20, right: 20),
                                child: Image.file(imageFile!),
                                alignment: Alignment.topCenter,

                              ) :


                              TextButton(
                                onPressed: () {
                                  Navigator.pushNamed(context, 'exercise');
                                },
                                child: Text('BACK',
                                  textAlign: TextAlign.start,
                                  style: TextStyle(color: Colors.white),
                                ),
                                style: ButtonStyle(
                                  backgroundColor: MaterialStateProperty.all(Colors.blueAccent),
                                  padding: MaterialStateProperty.all(EdgeInsets.all(12)),
                                  textStyle: MaterialStateProperty.all(TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                                ),
                              ),


                            ],
                          )
                        ],

                      ),

                    )

                    ],
                ),

              ),

            ),
          ],
        ),
      ),
    );
  }
}
