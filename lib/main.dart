import 'package:flutter/material.dart' hide Colors;
import 'package:freed/screen/SplashScreen/SplashScreen.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:freed/utils/Colors.dart';

void main() {
  runApp(
    ScreenUtilInit(
      designSize: Size(360, 780),
      builder: () => MaterialApp(
        theme: ThemeData.light().copyWith(
            primaryColor: Colors.yellow,
            colorScheme: ColorScheme.light(
                primary: Colors.black, secondary: Colors.default_color)),
        debugShowCheckedModeBanner: false,
        title: "Freed",
        home: SplashScreen(),
      ),
    ),
  );
}
