import 'package:flutter/material.dart' hide Colors;
import 'package:freed/screen/Background.dart';
import 'package:freed/value/Colors.dart';
import 'package:freed/value/SizeConfig.dart';

class onBoarding extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Background(
        child: Column(
      children: [
        SizedBox(
          height: SizeConfig.safeBlockVertical * 15,
        ),
        Container(
          height: SizeConfig.safeBlockVertical * 20,
          child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
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
          ]),
        ),
        SizedBox(
          height: SizeConfig.safeBlockVertical * 15,
        ),
        Expanded(
            child: Container(
          decoration: BoxDecoration(
              color: Colors.yellow,
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(45), topRight: Radius.circular(45))),
        ))
      ],
    ));
  }
}
