import 'package:flutter/material.dart';
import 'package:loginuicolors/account.dart';
import 'package:loginuicolors/exercise1.dart';
import 'package:loginuicolors/exercise2.dart';
import 'package:loginuicolors/exercise3.dart';
import 'package:loginuicolors/exercisespage.dart';
import 'package:loginuicolors/home.dart';
import 'package:loginuicolors/login.dart';
import 'package:loginuicolors/register.dart';
import 'package:loginuicolors/upload.dart';
import 'package:loginuicolors/welldone.dart';
import 'package:loginuicolors/wrong.dart';
import 'exercise4.dart';
import 'exercise5.dart';
import 'exercise6.dart';
import 'severError.dart';

var score= 0;
var exerciseNumber = 0;
var target = "A_U";
var gateways = [1,0,0,0,0,0];
var highScores = ["0","LOCK","LOCK","LOCK","LOCK","LOCK"];

void main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    home: MyLogin(),
    routes: {
      'register': (context) => MyRegister(),
      'login': (context) => MyLogin(),
      'home': (context) => MyHome(),
      'exercise': (context) => MyExercise(),
      'upload': (context) => MyUpload(),
      'welldone': (context) => WellDone(),
      'wrong': (context) => Wrong(),
      'account': (context) => MyAccount(),
      'exercisepage':(context) => ExercisePage(),
      'exercise2': (context) => MyExercise2(),
      'exercise3': (context) => MyExercise3(),
      'exercise4': (context) => MyExercise4(),
      'exercise5': (context) => MyExercise5(),
      'exercise6': (context) => MyExercise6(),
      'servererror': (context) => MyError(),
    },
  ));
}
