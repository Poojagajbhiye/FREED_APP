import 'dart:async';

import 'package:flutter/material.dart' hide Colors;
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
    // TODO: implement initState
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
      Timer(Duration(seconds: 3), () {
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

    return Background(
        child: Column(
      children: [
        SizedBox(
          height: SizeConfig.safeBlockVertical! * 15,
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
                        height: 0.8,
                        letterSpacing: 1.5,
                        fontFamily: 'poppins',
                        fontWeight: FontWeight.w200,
                        fontSize: SizeConfig.blockSizeHorizontal! * 14,
                        color: Colors.black,
                        decoration: TextDecoration.none),
                  ),
                  Text(
                    "Let's take a legal escape",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        letterSpacing: 1.2,
                        fontFamily: 'poppins',
                        fontWeight: FontWeight.w200,
                        fontSize: SizeConfig.blockSizeHorizontal! * 5,
                        color: Colors.black,
                        decoration: TextDecoration.none),
                  ),
                  Padding(padding: EdgeInsets.all(15)),
                  Container(
                      width: SizeConfig.safeBlockHorizontal! * 45,
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
                                fontSize: 16.0),
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
                height: SizeConfig.safeBlockVertical! * 50,
                width: double.infinity,
                decoration: BoxDecoration(
                    color: Colors.yellow,
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(45),
                        topRight: Radius.circular(45))),
                child: Padding(
                  padding: EdgeInsets.only(left: 35, right: 35, top: SizeConfig.blockSizeVertical! * 8),
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
                            fontSize: SizeConfig.blockSizeHorizontal! * 7),
                      ),
                      SizedBox(
                        height: 30,
                      ),
                      Text(
                        "Sed ut perspiciatis unde omnis iste natus error sit voluptatem accusantium",
                        style: TextStyle(
                            decoration: TextDecoration.none,
                            color: Colors.black,
                            fontFamily: 'roboto',
                            fontWeight: FontWeight.w700,
                            fontSize: SizeConfig.blockSizeHorizontal! * 4.2),
                      ),
                      SizedBox(
                        height: 35,
                      ),
                      Row(
                        children: [
                          Expanded(
                              child: Container(
                                  margin: EdgeInsets.only(right: 5.0),
                                  height: 40.0,
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
                                            fontSize: 16.0),
                                      )))),
                          Expanded(
                              child: Container(
                                  margin: EdgeInsets.only(left: 5.0),
                                  height: 40.0,
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
                                            fontSize: 16.0),
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
