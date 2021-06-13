import 'package:flutter/material.dart';
import 'package:freed/screen/SignIn.dart';
import 'package:freed/screen/SignUp.dart';
import 'package:freed/screen/SplashScreen.dart';

void main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    title: "Freed",
    initialRoute: '/',
    routes: {
      '/': (context) => SplashScreen(),
      '/sign in': (context) => SignIn(),
      '/sign up': (context) => SignUp(),
    },
  ));
}
