import 'package:flutter/material.dart';
import 'package:freed/screen/Dashboard.dart';
import 'package:freed/screen/ExpendedRecords.dart';
import 'package:freed/screen/RequestForm.dart';
import 'package:freed/screen/SignIn.dart';
import 'package:freed/screen/SignUp.dart';
import 'package:freed/screen/SplashScreen.dart';
import 'package:freed/screen/ViewRequest.dart';

void main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    title: "Freed",
    initialRoute: '/',
    routes: {
      '/': (context) => SplashScreen(),
      '/sign in': (context) => SignIn(),
      '/sign up': (context) => SignUp(),
      '/dashboard': (context) => Dashboard(),
      '/request form': (context) => RequestForm(),
      '/view request': (context) => ViewRequest(),
      '/expend records': (context) => ExpendedRecords(),
    },
  ));
}
