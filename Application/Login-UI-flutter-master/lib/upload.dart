import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'main.dart';






class MyUpload extends StatefulWidget {
  const MyUpload({Key? key}) : super(key: key);

  @override
  _MyUploadState createState() => _MyUploadState();
}

class _MyUploadState extends State<MyUpload> {
  // get image from camera, resize to 28x28, encode to base64
  String imageData = "iVBORw0KGgoAAAANSUhEUgAAABwAAAAcCAIAAAD9b0jDAAABeklEQVRIDa3BoU5yAQCG4e/dHIniBbgRsbCZnI1iZHMkbQ5vgGSyGQ3eABvFQTKYTRQCSaubjZExE94/sXEmB84/eR7UHBpqDg01h4aaQ0NNBYCaalCzD5BkOp1eXFykAtTsA7y/v19eXqqpADU7AXd3d4PBAFBTAWp2AtQkQL/ff35+zj6oKQe8vr52u90kHx8fZ2dnavZBTTlAzRqgZh/UlDg6Orq+vn55eclas9lcrVbf39/ZCTUlADVFgJqdULPN29vb1dWVmqJardZoNL6+vlIONdsAKaemHGq2AdRsMxwOe72emhKo+eX09HSxWPz8/KQEMBwOb29vsw1qfgHU7ASo2QY1Rff3909PT2p2ms1m5+fnan5BTRHw+Pj48PCQfYDPz89Wq5Ui1BQBaipYLpfHx8dqilBTBKipBhiNRjc3N9mAmg31er3T6YzH41QzmUza7baaDajZAKj5H4CaDahZOzk5mc/nav4GNWuAmj9DzaGh5tD+AbfK5smRuZv2AAAAAElFTkSuQmCC";
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
                                  onPressed: () async {
                                    if (loading == false) {
                                      loading = true;

                                      score = 0;
                                      _showMyDialog();

                                      final url = 'https://letter0by0letter-5g370ahsihf594u3.socketxp.com/score';
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
                                        highScores[exerciseNumber] =
                                            score.toString();

                                        if (score > 65) {
                                          gateways[(exerciseNumber + 1)] = 1;
                                          highScores[exerciseNumber + 1] = "0";
                                          Navigator.pushNamed(
                                              context, 'welldone');
                                        } else {
                                          Navigator.pushNamed(context, 'wrong');
                                        }
                                      }
                                      catch (e) {
                                        print(
                                            "Server error. Server is probably offline.");
                                        Navigator.pushNamed(
                                            context, 'servererror');
                                      }
                                    }

                                  },
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
