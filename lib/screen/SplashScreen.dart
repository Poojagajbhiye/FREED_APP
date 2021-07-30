import 'dart:async';

import 'package:flutter/material.dart' hide Colors;
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:freed/screen/BottomNavigation.dart';
import 'package:freed/screen/SignIn.dart';
import 'package:freed/screen/SignUp.dart';
import 'package:freed/storage/TempStorage.dart';
import 'package:freed/value/Colors.dart';
import 'package:freed/value/SizeConfig.dart';

import 'Background.dart';

class SplashScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _SplashScreen();
  }
}

class _SplashScreen extends State<SplashScreen> with TickerProviderStateMixin {
  AnimationController? controller;
  Animation<Offset>? offset;
  bool _visible = false;

  @override
  void initState() {
    super.initState();

    _checkTokenAavailablity();

    controller =
        AnimationController(vsync: this, duration: Duration(milliseconds: 800));

    offset = Tween<Offset>(begin: Offset.zero, end: Offset(0.0, 5.0))
        .animate(controller!);
    controller?.forward(from: 0.0);
  }

  _checkTokenAavailablity() async {
    String userid = await TempStorage.getUserId();
    if (userid.isNotEmpty) {
      Timer(Duration(milliseconds: 1500), () {
        Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(
                builder: (context) => BottomNavigation(sid: userid)),
            (route) => false);
      });
    } else {
      setState(() {
        _visible = true;
      });
    }
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    controller!.dispose();
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig.init(context);
    // print("screen width: ${1.sw}");
    // print("screen height: ${SizeConfig.screenHeight}");
    // print("block horizontal: ${SizeConfig.blockSizeHorizontal}");
    // print("block vertical: ${SizeConfig.blockSizeVertical}");
    // print("safe horizontal: ${SizeConfig.safeBlockHorizontal}");
    // print("safe vertical: ${SizeConfig.safeBlockVertical}");

    return Background(
        child: Column(
      children: [
        SizedBox(
          height: 112.2.h,
        ),
        Expanded(
          child: Align(
              alignment: Alignment(0.0, 0.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "FREED",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        height: 0.8.h,
                        letterSpacing: 1.5,
                        fontFamily: 'poppins',
                        fontWeight: FontWeight.w200,
                        fontSize: 50.sp,
                        color: Colors.black,
                        decoration: TextDecoration.none),
                  ),
                  SizedBox(height: 5.h),
                  Text(
                    "Let's take a legal escape",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        letterSpacing: 1.2,
                        fontFamily: 'poppins',
                        fontWeight: FontWeight.w200,
                        fontSize: 18.sp,
                        color: Colors.black,
                        decoration: TextDecoration.none),
                  ),
                  SizedBox(height: 30.h),
                  Container(
                      width: 162.w,
                      child: AnimatedOpacity(
                        opacity: _visible ? 1.0 : 0.0,
                        duration: Duration(seconds: 1),
                        child: ElevatedButton(
                          onPressed: () {
                            if (_visible) {
                              if (controller!.isCompleted) {
                                controller?.reverse(from: 1.0);
                              }
                            }

                            setState(() {
                              _visible = !_visible;
                            });
                          },
                          child: Text(
                            "Let's Go",
                            style: TextStyle(
                                fontFamily: 'roboto',
                                fontWeight: FontWeight.w400,
                                fontSize: 16.sp),
                          ),
                          style: ButtonStyle(
                              backgroundColor:
                                  MaterialStateProperty.all(Colors.black),
                              shape: MaterialStateProperty.all(
                                  RoundedRectangleBorder(
                                      borderRadius:
                                          BorderRadius.circular(30.0))),
                              foregroundColor:
                                  MaterialStateProperty.all(Colors.white),
                              shadowColor:
                                  MaterialStateProperty.all(Colors.black)),
                        ),
                      ))
                ],
              )),
        ),
        Align(
            alignment: Alignment.bottomCenter,
            child: SlideTransition(
              position: offset!,
              child: Container(
                height: 375.h,
                width: double.infinity,
                decoration: BoxDecoration(
                    color: Colors.yellow,
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(45.r),
                        topRight: Radius.circular(45.r))),
                child: Padding(
                  padding: EdgeInsets.only(
                      left: 35.w,
                      right: 35.w,
                      top: 62.4.h),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Welcome",
                        style: TextStyle(
                            decoration: TextDecoration.none,
                            color: Colors.black,
                            fontFamily: 'roboto',
                            fontWeight: FontWeight.w700,
                            fontSize: 24.sp),
                      ),
                      SizedBox(
                        height: 30.h
                      ),
                      Text(
                        "Sed ut perspiciatis unde omnis iste natus error sit voluptatem accusantium",
                        style: TextStyle(
                            decoration: TextDecoration.none,
                            color: Colors.black,
                            fontFamily: 'roboto',
                            fontWeight: FontWeight.w700,
                            fontSize: 15.sp),
                      ),
                      SizedBox(
                        height: 35.h
                      ),
                      Row(
                        children: [
                          Expanded(
                              child: Container(
                                  margin: EdgeInsets.only(right: 5.w),
                                  height: 40.h,
                                  child: ElevatedButton(
                                      onPressed: () {
                                        Navigator.pushAndRemoveUntil(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) => SignIn()),
                                            (route) => false);
                                      },
                                      style: ButtonStyle(
                                          backgroundColor:
                                              MaterialStateProperty.all(
                                                  Colors.black),
                                          shape: MaterialStateProperty.all(
                                              RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          30.0))),
                                          shadowColor:
                                              MaterialStateProperty.all(
                                                  Colors.black)),
                                      child: Text(
                                        "Sign In",
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontFamily: 'roboto',
                                            fontWeight: FontWeight.w400,
                                            fontSize: 16.sp),
                                      )))),
                          Expanded(
                              child: Container(
                                  margin: EdgeInsets.only(left: 5.w),
                                  height: 40.h,
                                  child: ElevatedButton(
                                      onPressed: () {
                                        Navigator.pushAndRemoveUntil(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) => SignUp()),
                                            (route) => false);
                                      },
                                      style: ButtonStyle(
                                          backgroundColor:
                                              MaterialStateProperty.all(
                                                  Colors.white),
                                          shape: MaterialStateProperty.all(
                                              RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          30.0))),
                                          shadowColor:
                                              MaterialStateProperty.all(
                                                  Colors.white)),
                                      child: Text(
                                        "Sign Up",
                                        style: TextStyle(
                                            color: Colors.black,
                                            fontFamily: 'roboto',
                                            fontWeight: FontWeight.w400,
                                            fontSize: 16.sp),
                                      ))))
                        ],
                      )
                    ],
                  ),
                ),
              ),
            ))
      ],
    ));
  }
}
