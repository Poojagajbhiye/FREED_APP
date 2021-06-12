import 'package:flutter/material.dart' hide Colors;
import 'package:freed/screen/SignIn.dart';
import 'package:freed/screen/onBoarding.dart';
import 'package:freed/value/Colors.dart';
import 'package:freed/value/SizeConfig.dart';
import 'package:simple_animations/simple_animations/controlled_animation.dart';

import 'Background.dart';

class SplashScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _SplashScreen();
  }
}

class _SplashScreen extends State<SplashScreen> with TickerProviderStateMixin {
  AnimationController controller;
  Animation<Offset> offset;
  bool _visible = true;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    controller =
        AnimationController(vsync: this, duration: Duration(milliseconds: 800));

    offset = Tween<Offset>(begin: Offset.zero, end: Offset(0.0, 5.0))
        .animate(controller);
    controller.forward(from: 0.0);
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig.init(context);

    return Background(
        child: Column(
      children: [
        SizedBox(
          height: SizeConfig.safeBlockVertical * 15,
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
                        fontSize: 58.0,
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
                        fontSize: 20.0,
                        color: Colors.black,
                        decoration: TextDecoration.none),
                  ),
                  Padding(padding: EdgeInsets.all(15)),
                  Container(
                      width: SizeConfig.safeBlockHorizontal * 45,
                      child: AnimatedOpacity(
                        opacity: _visible ? 1.0 : 0.0,
                        duration: Duration(seconds: 1),
                        child: ElevatedButton(
                          onPressed: () {
                            if (controller.isCompleted) {
                              controller.reverse(from: 1.0);
                              setState(() {
                                _visible = !_visible;
                              });
                            }
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
              position: offset,
              child: Container(
                height: SizeConfig.safeBlockVertical * 50,
                width: double.infinity,
                decoration: BoxDecoration(
                    color: Colors.yellow,
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(45),
                        topRight: Radius.circular(45))),
                child: Padding(
                  padding: EdgeInsets.only(left: 35, right: 35, top: 60),
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
                            fontSize: 30.0),
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
                            fontSize: 16.0),
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
                                        Navigator.pushNamed(context, '/sign in');
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
                                      onPressed: () {},
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
    )
        //     Column(
        //   children: [
        //     Center(
        //         child: AnimatedOpacity(
        //       opacity: _visible ? 1.0 : 0.0,
        //       duration: Duration(microseconds: 900),
        //       child: RaisedButton(
        //         child: Text('Show / Hide'),
        //         onPressed: () {
        // if (controller.isCompleted) {
        //   controller.reverse(from: 1.0);
        //   setState(() {
        //     _visible = !_visible;
        //   });
        // }
        //         },
        //       ),
        //     )),
        // Expanded(child: Align(
        //   alignment: Alignment.bottomCenter,
        //   child: SlideTransition(
        //     position: offset,
        //     child: Container(
        //       height: 150,
        //       width: double.infinity,
        //       decoration: BoxDecoration(color: Colors.yellow),
        //     ),
        //   ),
        // ),)
        //   ],
        // )
        // Align(
        //   alignment: Alignment(0.0, -0.4),
        //   child: Container(
        //       height: SizeConfig.safeBlockVertical * 30,
        //       child: Column(
        //         mainAxisAlignment: MainAxisAlignment.center,
        //         children: [
        //           Text(
        //             "FREED",
        //             textAlign: TextAlign.center,
        //             style: TextStyle(
        //                 height: 0.8,
        //                 letterSpacing: 1.5,
        //                 fontFamily: 'poppins',
        //                 fontWeight: FontWeight.w200,
        //                 fontSize: 58.0,
        //                 color: Colors.black,
        //                 decoration: TextDecoration.none),
        //           ),
        //           Text(
        //             "Let's take a legal escape",
        //             textAlign: TextAlign.center,
        //             style: TextStyle(
        //                 letterSpacing: 1.2,
        //                 fontFamily: 'poppins',
        //                 fontWeight: FontWeight.w200,
        //                 fontSize: 20.0,
        //                 color: Colors.black,
        //                 decoration: TextDecoration.none),
        //           ),
        //           Padding(padding: EdgeInsets.all(15)),
        //           Container(
        //             width: SizeConfig.safeBlockHorizontal * 45,
        //             child: ElevatedButton(
        //               onPressed: () {
        //                 Navigator.push(context,
        //                     MaterialPageRoute(builder: (context) => onBoarding()));
        //               },
        //               child: Text(
        //                 "Let's Go",
        //                 style: TextStyle(
        //                     fontFamily: 'roboto',
        //                     fontWeight: FontWeight.w400,
        //                     fontSize: 16.0),
        //               ),
        //               style: ButtonStyle(
        //                   backgroundColor: MaterialStateProperty.all(Colors.black),
        //                   shape: MaterialStateProperty.all(RoundedRectangleBorder(
        //                       borderRadius: BorderRadius.circular(30.0))),
        //                   foregroundColor: MaterialStateProperty.all(Colors.white),
        //                   shadowColor: MaterialStateProperty.all(Colors.black)),
        //             ),
        //           )
        //         ],
        //       )),
        // )
        );
  }
}
