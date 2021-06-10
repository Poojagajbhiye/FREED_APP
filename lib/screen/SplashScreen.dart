import 'package:flutter/material.dart' hide Colors;
import 'package:freed/screen/onBoarding.dart';
import 'package:freed/value/Colors.dart';
import 'package:freed/value/SizeConfig.dart';

import 'Background.dart';

class SplashScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SizeConfig.init(context);

    return Background(
        child: Align(
      alignment: Alignment(0.0, -0.4),
      child: Container(
          height: SizeConfig.safeBlockVertical * 30,
          child: Column(
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
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => onBoarding()));
                  },
                  child: Text(
                    "Let's Go",
                    style: TextStyle(
                        fontFamily: 'roboto',
                        fontWeight: FontWeight.w400,
                        fontSize: 16.0),
                  ),
                  style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all(Colors.black),
                      shape: MaterialStateProperty.all(RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30.0))),
                      foregroundColor: MaterialStateProperty.all(Colors.white),
                      shadowColor: MaterialStateProperty.all(Colors.black)),
                ),
              )
            ],
          )),
    ));
  }
}
