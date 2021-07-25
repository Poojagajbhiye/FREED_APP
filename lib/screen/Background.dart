import 'package:flutter/material.dart' hide Colors;
import 'package:freed/value/Colors.dart';
import 'package:freed/value/Image.dart';
import 'package:freed/value/SizeConfig.dart';

class Background extends StatelessWidget {
  final Widget? child;
  const Background({Key? key, @required this.child});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: SizeConfig.screenWidth,
      height: SizeConfig.screenHeight,
      color: Colors.white,
      child: Stack(children: [
        Positioned(
            top: SizeConfig.safeBlockHorizontal! -
                SizeConfig.safeBlockHorizontal! * 25,
            right: SizeConfig.safeBlockHorizontal! -
                SizeConfig.safeBlockHorizontal! * 25,
            child: Container(
              width: SizeConfig.safeBlockHorizontal! * 50,
              height: SizeConfig.safeBlockHorizontal! * 50,
              decoration:
                  BoxDecoration(shape: BoxShape.circle, color: Colors.yellow),
            )),
        Positioned(
            bottom: SizeConfig.safeBlockHorizontal! -
                SizeConfig.safeBlockHorizontal! * 32,
            left: SizeConfig.safeBlockHorizontal! -
                SizeConfig.safeBlockHorizontal! * 30,
            child: Container(
                width: SizeConfig.safeBlockHorizontal! * 80,
                height: SizeConfig.safeBlockHorizontal! * 80,
                decoration: BoxDecoration(
                    shape: BoxShape.circle, color: Colors.yellow))),
        Positioned(
          bottom: -2,
          left: SizeConfig.safeBlockHorizontal! -
              SizeConfig.blockSizeHorizontal! * 27,
          child: Image.asset(rollerSkate),
          width: SizeConfig.rollerSkateDoodleSize(),
        ),
        child!,
      ]),
    );
  }
}