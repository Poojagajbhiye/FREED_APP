import 'package:flutter/material.dart' hide Colors;
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:freed/utils/Colors.dart';
import 'package:freed/utils/Image.dart';

class ProcessDoodle extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          SizedBox(height: 80.r, width: 1.sw, child: Image.asset(layingDoodle)),
          SizedBox(height: 10.h),
          Container(
            width: 1.sw,
            padding: EdgeInsets.symmetric(vertical: 13.h, horizontal: 5.w),
            decoration: BoxDecoration(
                color: Colors.gray, borderRadius: BorderRadius.circular(10.0)),
            child: Column(
              children: [
                Text(
                  "In Process!",
                  style: TextStyle(
                      fontFamily: 'roboto',
                      fontWeight: FontWeight.w700,
                      fontSize: 16.sp,
                      color: Colors.black),
                ),
                SizedBox(height: 5.h),
                Text(
                  "We'll be back to you soon",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontFamily: 'roboto',
                      fontWeight: FontWeight.w300,
                      fontSize: 16.sp,
                      color: Colors.black),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}