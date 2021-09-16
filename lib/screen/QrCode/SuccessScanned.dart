import 'package:flutter/material.dart' hide Colors;
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:freed/utils/CustomIcon.dart';
import 'package:freed/utils/Colors.dart';

class SuccessScanned extends StatefulWidget {
  final titleStatus;
  final msg;

  SuccessScanned({Key? key, @required this.titleStatus, @required this.msg})
      : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _SuccessScreen(titleStatus, msg);
  }
}

class _SuccessScreen extends State<SuccessScanned> {
  String? titleStatus;
  String? msg;

  _SuccessScreen(this.titleStatus, this.msg);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.green,
        shadowColor: Colors.transparent,
      ),
      body: Stack(
        children: [
          //background shape
          Positioned(
            left: 0.0,
            right: 0.0,
            top: 0.0,
            child: ClipPath(
              clipper: BackgroundClipper(),
              child: Container(
                height: 450.h,
                decoration: BoxDecoration(
                  color: Colors.green_32,
                ),
              ),
            ),
          ),
          //background shape
          Positioned(
            left: 0.0,
            right: 0.0,
            top: -25.h,
            child: ClipPath(
              clipper: BackgroundClipper(),
              child: Container(
                height: 450.h,
                decoration: BoxDecoration(
                  color: Colors.green_32,
                ),
              ),
            ),
          ),
          Positioned(
            left: 0.0,
            right: 0.0,
            top: -50.h,
            child: ClipPath(
              clipper: BackgroundClipper(),
              child: Container(
                height: 450.h,
                decoration: BoxDecoration(
                  color: Colors.green,
                ),
                child: Center(
                    child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      titleStatus!,
                      style: TextStyle(
                          fontFamily: "roboto",
                          fontWeight: FontWeight.w700,
                          fontSize: 14.sp,
                          color: Colors.white),
                    ),
                    SizedBox(height: 45.h),
                    Container(
                      height: 110.r,
                      width: 110.r,
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(33.r)),
                      child: Icon(
                        CustomIcon.correct__1_,
                        color: Colors.green,
                        size: 60.r,
                      ),
                    ),
                    SizedBox(height: 35.h),
                    FittedBox(
                      child: Text(
                        msg!,
                        style: TextStyle(
                            fontFamily: "roboto",
                            fontWeight: FontWeight.w400,
                            fontSize: 14.sp,
                            color: Colors.white),
                      ),
                    ),
                    SizedBox(height: 60.h)
                  ],
                )),
              ),
            ),
          ),
          Positioned(
            left: 0.0,
            right: 0.0,
            bottom: 60.h,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(
                  CustomIcon.qr_code_scan,
                  size: 30.r,
                  color: Colors.default_color,
                ),
                SizedBox(height: 20.h),
                Container(
                  height: 45.h,
                  width: 1.sw,
                  margin: EdgeInsets.symmetric(horizontal: 80.w),
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: Text(
                      "Done",
                      style: TextStyle(
                          fontFamily: "roboto",
                          fontWeight: FontWeight.w400,
                          fontSize: 16.sp),
                    ),
                    style: ButtonStyle(
                        backgroundColor:
                            MaterialStateProperty.all(Colors.black),
                        shape: MaterialStateProperty.all(RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(50.r))),
                        shadowColor:
                            MaterialStateProperty.all(Colors.transparent)),
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}

class BackgroundClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    var path = Path();
    path.lineTo(0, size.height / 1.3);
    path.quadraticBezierTo(
        size.width / 2, size.height, size.width, size.height / 1.3);
    path.lineTo(size.width, size.height);
    path.lineTo(size.width, 0);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) {
    return true;
  }
}
