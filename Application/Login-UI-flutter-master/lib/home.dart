import 'package:flutter/material.dart';

class MyHome extends StatefulWidget {
  const MyHome({Key? key}) : super(key: key);

  @override
  _MyHomeState createState() => _MyHomeState();
}

class _MyHomeState extends State<MyHome> {
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
              padding: EdgeInsets.only(left: 35, top: 60),
              child: Text(
                'HOME PAGE',
                style: TextStyle(color: Colors.black, fontSize: 45,fontWeight:FontWeight.bold),
              ),
            ),
            SingleChildScrollView(
              child: Container(
                padding: EdgeInsets.only(
                    top: MediaQuery.of(context).size.height * 0.20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      margin: EdgeInsets.only(left: 35, right: 35),
                      child: Column(
                        children: [
                          Container(
                            margin: EdgeInsets.all(25),
                            child: TextButton(
                              child: Text('   EXERCISES   ', style: TextStyle(fontSize: 35.0),),
                              style: TextButton.styleFrom(
                                backgroundColor: Colors.green,
                                primary: Colors.white,
                              ),
                              onPressed: () {
                                Navigator.pushNamed(context, 'exercisepage');
                              },
                            ),
                          ),

                          Container(
                            margin: EdgeInsets.all(25),
                            child: TextButton(
                              child: Text('MY ACCOUNT', style: TextStyle(fontSize: 34.0),),
                              style: TextButton.styleFrom(
                                backgroundColor: Colors.orange,
                                primary: Colors.white,
                              ),
                              onPressed: () {
                                Navigator.pushNamed(context, 'account');
                              },
                            ),
                          ),


                          Container(
                            margin: EdgeInsets.all(25),
                            child: TextButton(
                              child: Text('  LOGOUT  ', style: TextStyle(fontSize: 35.0),),
                              style: TextButton.styleFrom(
                                backgroundColor: Colors.red,
                                primary: Colors.white,
                              ),
                              onPressed: () {},
                            ),
                          ),

                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              TextButton(
                                onPressed: () {
                                  Navigator.pushNamed(context, 'login');
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
