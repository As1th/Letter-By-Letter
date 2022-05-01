import 'package:flutter/material.dart';

import 'main.dart';

class ExercisePage extends StatefulWidget {
  const ExercisePage({Key? key}) : super(key: key);

  @override
  _ExercisePageState createState() => _ExercisePageState();
}

class _ExercisePageState extends State<ExercisePage> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        image: DecorationImage(
            image: AssetImage('assets/img6.jpeg'), fit: BoxFit.cover),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
        ),
        body: Stack(
          children: [
            Container(
              padding: EdgeInsets.only(left: 45, top: 38),
              child: Text(
                'Exercise Page',
                style: TextStyle(color: Colors.black, fontSize: 45,fontWeight:FontWeight.bold),
              ),
            ),
            SingleChildScrollView(
              child: Container(
                padding: EdgeInsets.only(
                    top: MediaQuery.of(context).size.height * 0.11),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      margin: EdgeInsets.only(left: 35, right: 35),
                      child: Column(
                        children: [
                          Container(
                            margin: EdgeInsets.all(15),
                            child: TextButton(
                              child: Text('  A - SCORE : '+ highScores[0]+'    ', style: TextStyle(fontSize: 28.0),),
                              style: TextButton.styleFrom(
                                backgroundColor: Colors.green,
                                primary: Colors.white,
                              ),
                              onPressed: () {
                                exerciseNumber = 0;
                                target = "A_U";
                                Navigator.pushNamed(context, 'exercise');
                              },
                            ),
                          ),

                          Container(
                            margin: EdgeInsets.all(15),
                            child: TextButton(
                              child: Text('  B - SCORE : '+ highScores[1]+'    ', style: TextStyle(fontSize: 28.0),),
                              style: TextButton.styleFrom(
                                backgroundColor: Colors.orange,
                                primary: Colors.white,
                              ),
                              onPressed: () {
                                if(gateways[1] == 1) {
                                  exerciseNumber = 1;
                                  target = "B_U";
                                  Navigator.pushNamed(context, 'exercise2');
                                } else {

                                }
                              },
                            ),
                          ),


                          Container(
                            margin: EdgeInsets.all(15),
                            child: TextButton(
                              child: Text('  C - SCORE : '+ highScores[2]+'    ', style: TextStyle(fontSize: 28.0),),
                              style: TextButton.styleFrom(
                                backgroundColor: Colors.red,
                                primary: Colors.white,
                              ),
                              onPressed: () {
                                if(gateways[2] == 1) {
                                  exerciseNumber = 2;
                                  target = "C_U";
                                  Navigator.pushNamed(context, 'exercise3');
                                } else {

                                }
                              },
                            ),
                          ),


                          Container(
                            margin: EdgeInsets.all(15),
                            child:TextButton(
                              child: Text('  D - SCORE : '+ highScores[3]+'    ', style: TextStyle(fontSize: 28.0),),
                              style: TextButton.styleFrom(
                                backgroundColor: Colors.blue,
                                primary: Colors.white,
                              ),
                              onPressed: () {
                                if(gateways[3] == 1) {
                                  exerciseNumber = 3;
                                  target = "D_U";
                                  Navigator.pushNamed(context, 'exercise4');
                                } else {

                                }
                              },
                            ),
                          ),

                          Container(
                            margin: EdgeInsets.all(15),
                            child: TextButton(
                              child: Text('  E - SCORE : '+ highScores[4]+'    ', style: TextStyle(fontSize: 28.0),),
                              style: TextButton.styleFrom(
                                backgroundColor: Colors.yellow,
                                primary: Colors.white,
                              ),

                              onPressed: () {
                                if(gateways[4] == 1) {
                                  exerciseNumber = 4;
                                  target = "E_U";
                                  Navigator.pushNamed(context, 'exercise5');
                                } else {

                                }
                              },
                            ),
                          ),


                          Container(
                            margin: EdgeInsets.all(15),
                            child: TextButton(
                              child: Text('  F - SCORE : '+ highScores[5]+'    ', style: TextStyle(fontSize: 28.0),),
                              style: TextButton.styleFrom(
                                backgroundColor: Colors.pink,
                                primary: Colors.white,
                              ),
                              onPressed: () {
                                if(gateways[5] == 1) {
                                  exerciseNumber = 5;
                                  target = "F_U";
                                  Navigator.pushNamed(context, 'exercise6');
                                } else {

                                }
                              },
                            ),
                          ),

                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              TextButton(
                                onPressed: () {
                                  Navigator.pushNamed(context, 'home');
                                },
                                child: Text(
                                  'Back',
                                  style: TextStyle(
                                      color: Colors.black87,
                                      fontSize: 27,
                                      fontWeight: FontWeight.w700),

                                ),
                                style: ButtonStyle(),
                              ),
                            ],
                          ),


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
