import 'package:flutter/material.dart';
import 'package:freed/screen/SplashScreen.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

void main() {
  runApp(
    ScreenUtilInit(
      designSize: Size(360, 780),
      builder: () => MaterialApp(
        debugShowCheckedModeBanner: false,
        title: "Freed",
        home: SplashScreen(),
      ),
    ),
  );
}
