import 'package:flutter/material.dart';

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
              padding: EdgeInsets.only(left: 35, top: 38),
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
                            child: FlatButton(
                              child: Text('   EXERCISES 1    ', style: TextStyle(fontSize: 28.0),),
                              color: Colors.green,
                              textColor: Colors.white,
                              onPressed: () {
                                Navigator.pushNamed(context, 'exercise');
                              },
                            ),
                          ),

                          Container(
                            margin: EdgeInsets.all(15),
                            child: FlatButton(
                              child: Text('  EXERCISES 2   ', style: TextStyle(fontSize: 28.0),),
                              color: Colors.orange,
                              textColor: Colors.white,
                              onPressed: () {
                                Navigator.pushNamed(context, 'exercise2');
                              },
                            ),
                          ),


                          Container(
                            margin: EdgeInsets.all(15),
                            child: FlatButton(
                              child: Text('   EXERCISES 3  ', style: TextStyle(fontSize: 28.0),),
                              color: Colors.red,
                              textColor: Colors.white,
                              onPressed: () {
                                Navigator.pushNamed(context, 'exercise3');
                              },
                            ),
                          ),


                          Container(
                            margin: EdgeInsets.all(15),
                            child: FlatButton(
                              child: Text('   EXERCISES 4   ', style: TextStyle(fontSize: 28.0),),
                              color: Colors.blue,
                              textColor: Colors.white,
                              onPressed: () {
                                Navigator.pushNamed(context, 'exercise4');
                              },
                            ),
                          ),

                          Container(
                            margin: EdgeInsets.all(15),
                            child: FlatButton(
                              child: Text('   EXERCISES 5  ', style: TextStyle(fontSize: 28.0),),
                              color: Colors.yellowAccent,
                              textColor: Colors.white,
                              onPressed: () {
                                Navigator.pushNamed(context, 'exercise5');
                              },
                            ),
                          ),

                          Container(
                            margin: EdgeInsets.all(15),
                            child: FlatButton(
                              child: Text('   EXERCISES 6   ', style: TextStyle(fontSize: 28.0),),
                              color: Colors.pink,
                              textColor: Colors.white,
                              onPressed: () {
                                Navigator.pushNamed(context, 'exercise6');
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
