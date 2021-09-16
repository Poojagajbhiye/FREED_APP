import 'package:flutter/material.dart' hide Colors;
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:freed/utils/Colors.dart';
import 'package:freed/utils/Image.dart';

class Background extends StatelessWidget {
  final Widget? child;
  const Background({Key? key, @required this.child});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 1.sw,
      height: 1.sh,
      color: Colors.white,
      child: Stack(children: [
        Positioned(
            top: -84.5.h,
            right: -84.5.h,
            child: Container(
              width: 180.r,
              height: 180.r,
              decoration:
                  BoxDecoration(shape: BoxShape.circle, color: Colors.yellow),
            )),
        Positioned(
            bottom: -111.6.h,
            left: -104.4.h,
            child: Container(
                width: 288.r,
                height: 288.r,
                decoration: BoxDecoration(
                    shape: BoxShape.circle, color: Colors.yellow))),
        Positioned(
          bottom: -2,
          left: -93.6.h,
          child: Image.asset(rollerSkate),
          width: 396.r,
        ),
        child!,
      ]),
    );
  }
}