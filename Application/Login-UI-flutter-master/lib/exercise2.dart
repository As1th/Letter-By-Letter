import 'package:flutter/material.dart';

class MyExercise2 extends StatefulWidget {
  const MyExercise2({Key? key}) : super(key: key);

  @override
  _MyExercise2State createState() => _MyExercise2State();
}

class _MyExercise2State extends State<MyExercise2> {
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
              padding: EdgeInsets.only(left: 85, top: 134),
              child: Text(
                'EXERCISE 2',
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.black87, fontSize: 40,fontWeight:FontWeight.bold ),
              ),
            ),
            Container(
              padding: EdgeInsets.only(left: 85, top: 100),
              child: Text(
                'B',
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.black87, fontSize: 300,fontWeight:FontWeight.bold ),
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
                                "      Write the display\n     letter on paper.\n  \n       Please write on\n        a white paper.",

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
                                  Navigator.pushNamed(context, 'exercisepage');
                                },
                                child: Text(
                                  'Back',
                                  textAlign: TextAlign.left,
                                  style: TextStyle(
                                    // decoration: TextDecoration.underline,
                                      color: Colors.black,fontWeight: FontWeight.bold,
                                      fontSize: 20),
                                ),
                                style: ButtonStyle(),
                              ),
                              TextButton(
                                onPressed: () {
                                  Navigator.pushNamed(context, 'upload');
                                },
                                child: Text(
                                  'Scan',
                                  textAlign: TextAlign.left,
                                  style: TextStyle(
                                    // decoration: TextDecoration.underline,
                                      color: Colors.red,fontWeight: FontWeight.bold,
                                      fontSize: 25),
                                ),
                                style: ButtonStyle(),
                              ),
                              TextButton(
                                  onPressed: () {
                                    Navigator.pushNamed(context, 'home');
                                  },
                                  child: Text(
                                    'Home',
                                    style: TextStyle(
                                      // decoration: TextDecoration.underline,
                                      color: Colors.black,
                                      fontSize: 20,
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
