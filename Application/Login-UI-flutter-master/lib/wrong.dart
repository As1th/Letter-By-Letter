import 'package:flutter/material.dart';

import 'main.dart';

class Wrong extends StatefulWidget {
  const Wrong({Key? key}) : super(key: key);

  @override
  _WrongState createState() => _WrongState();
}

class _WrongState extends State<Wrong> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        image: DecorationImage(
            image: AssetImage('assets/img4.jpeg'), fit: BoxFit.cover),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: Stack(
          children: [
            Container(),
            Container(
              padding: EdgeInsets.only(left: 25, top: 88),
              child: Text(
                'Not Quite! 😔 \nYou got '+score.toString()+'% !',
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.red, fontSize: 45,fontWeight:FontWeight.bold ),
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
                                "      Don't worry! 🤗\n It just takes practice!  \n    Sometimes we get \n      it wrong too! \n     Just try again! 🤐",

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
                                  Navigator.pushNamed(context, 'home');
                                },
                                child: Text(
                                  'Home',
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
                                    Navigator.pushNamed(context, 'exercisepage');
                                  },
                                  child: Text(
                                    'Menu',
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
