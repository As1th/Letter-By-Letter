import 'package:flutter/material.dart';

class MyUpload extends StatefulWidget {
  const MyUpload({Key? key}) : super(key: key);

  @override
  _MyUploadState createState() => _MyUploadState();
}

class _MyUploadState extends State<MyUpload> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        image: DecorationImage(
            image: AssetImage('assets/img3.jpeg'), fit: BoxFit.cover),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: Stack(
          children: [
            Container(),
            Container(
              padding: EdgeInsets.only(left: 85, top: 140),
              child: Text(
                'EXERCISE',
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.black87, fontSize: 40,fontWeight:FontWeight.bold ),
              ),
            ),
            SingleChildScrollView(
              child: Container(
                padding: EdgeInsets.only(
                    top: MediaQuery.of(context).size.height * 0.5),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      margin: EdgeInsets.only(left: 35, right: 35),
                      child: Column(
                        children: [

                          SizedBox(
                            height: 30,
                          ),

                          SizedBox(
                            height: 40,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "Click 'OK' to upload\n  \n Click 'RETAKE' to\n scan new photo",

                                style: TextStyle(
                                    fontSize: 25, fontWeight: FontWeight.bold, color: Colors.pink),
                              ),




                            ],
                          ),
                          SizedBox(
                            height: 40,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              TextButton(
                                onPressed: () {
                                  Navigator.pushNamed(context, 'exercise');
                                },
                                child: Text(
                                  'BACK',
                                  textAlign: TextAlign.left,
                                  style: TextStyle(
                                    // decoration: TextDecoration.underline,
                                      color: Colors.black,fontWeight: FontWeight.bold,
                                      fontSize: 27),
                                ),
                                style: ButtonStyle(),
                              ),

                              TextButton(
                                onPressed: () {
                                  Navigator.pushNamed(context, 'upload');
                                },
                                child: Text(
                                  'RETAKE',
                                  textAlign: TextAlign.left,
                                  style: TextStyle(
                                    // decoration: TextDecoration.underline,
                                      color: Colors.black,fontWeight: FontWeight.bold,
                                      fontSize: 27),
                                ),
                                style: ButtonStyle(),
                              ),
                              TextButton(
                                  onPressed: () {},
                                  child: Text(
                                    'OK',
                                    style: TextStyle(
                                      // decoration: TextDecoration.underline,
                                      color: Colors.black,
                                      fontSize: 27,
                                      fontWeight:FontWeight.bold,
                                    ),
                                  )),
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
