import 'package:flutter/material.dart';

class MyExercise6 extends StatefulWidget {
  const MyExercise6({Key? key}) : super(key: key);

  @override
  State<MyExercise6> createState() => _MyExercise6State();
}

class _MyExercise6State extends State<MyExercise6> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        image: DecorationImage(
            image: AssetImage('assets/img3.jpeg'), fit: BoxFit.cover),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: ListView(


          children: [
            SizedBox(height: 70,),

            Container(
              padding: EdgeInsets.only(top: 59),
              child: Text(
                'EXERCISE 6',
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.black87, fontSize:40,fontWeight:FontWeight.bold ),
              ),
            ),

            Container(
              padding: const EdgeInsets.only(top: 35.0),
              child: Text("Write the displayed letter on a paper!\nPlease write on a blank paper\nwith a dark pencil!",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                  color: Colors.pink,
                ),
              ),

            ),
            Container(


              child: Text(
                'F',
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.black87, fontSize: 250,fontWeight:FontWeight.bold ),
              ),
            ),
            Container(

              child: Text("If you are done click 'Ok'",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                  color: Colors.pink,
                ),
              ),

            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [

                Padding(
                  padding: const EdgeInsets.all(30.0),
                  child: ElevatedButton(
                    child: Text('Back'),
                    onPressed: () {
                      Navigator.pushNamed(context, 'exercisepage');
                    },
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all(Colors.blueAccent),
                      padding: MaterialStateProperty.all(EdgeInsets.all(12)),
                      textStyle: MaterialStateProperty.all(TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(30.0),
                  child: ElevatedButton(
                    child: Text('Ok'),
                    onPressed: () {

                      Navigator.pushNamed(context, 'upload');
                    },
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all(Colors.blueAccent),
                      padding: MaterialStateProperty.all(EdgeInsets.all(12)),
                      textStyle: MaterialStateProperty.all(TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(30.0),
                  child: ElevatedButton(
                    child: Text('Home'),
                    onPressed: () {
                      Navigator.pushNamed(context, 'home');
                    },
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all(Colors.blueAccent),
                      padding: MaterialStateProperty.all(EdgeInsets.all(12)),
                      textStyle: MaterialStateProperty.all(TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                    ),
                  ),
                ),
              ],
            )
          ],
        ),



      ),
    );



  }
}
