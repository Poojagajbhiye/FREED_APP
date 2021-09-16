import 'package:flutter/material.dart' hide Colors;
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:freed/utils/Colors.dart';
import 'package:freed/utils/Image.dart';
import 'package:url_launcher/url_launcher.dart';

class DeclinedDoodle extends StatelessWidget {
  final remark_msg;
  final remark_firstname;
  final remark_lastname;
  final remark_contact;
  DeclinedDoodle(
      {@required this.remark_msg,
      @required this.remark_firstname,
      @required this.remark_contact,
      this.remark_lastname});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          SizedBox(height: 80.r, width: 1.sw, child: Image.asset(messyDoodle)),
          SizedBox(height: 10.h),
          Container(
            width: 1.sw,
            padding: EdgeInsets.symmetric(vertical: 13.h, horizontal: 5.w),
            decoration: BoxDecoration(
                color: Colors.white, borderRadius: BorderRadius.circular(10.0)),
            child: Column(
              children: [
                Text(
                  "Oops!",
                  style: TextStyle(
                      fontFamily: 'roboto',
                      fontWeight: FontWeight.w700,
                      fontSize: 16.sp,
                      color: Colors.red),
                ),
                SizedBox(height: 5.h),
                Text(
                  "Your request was not accepted",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontFamily: 'roboto',
                      fontWeight: FontWeight.w300,
                      fontSize: 16.sp,
                      color: Colors.black),
                )
              ],
            ),
          ),
          SizedBox(height: 10.h),

          //remark expanded card
          Container(
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Colors.red_50),
              child: Theme(
                data: Theme.of(context)
                    .copyWith(dividerColor: Colors.transparent),
                child: ExpansionTile(
                  title: Text(
                    "Info",
                    style: TextStyle(
                        fontFamily: 'roboto',
                        fontWeight: FontWeight.w700,
                        fontSize: 14.sp,
                        color: Colors.black),
                  ),
                  childrenPadding:
                      EdgeInsets.only(left: 15.w, right: 15.w, bottom: 15.h),
                  children: [
                    Align(
                      alignment: Alignment.topLeft,
                      child: Text(
                        "$remark_msg. declined by $remark_firstname $remark_lastname",
                        textAlign: TextAlign.left,
                        style: TextStyle(
                            fontFamily: 'roboto',
                            fontWeight: FontWeight.w300,
                            fontSize: 14.sp,
                            color: Colors.black),
                      ),
                    ),
                    SizedBox(height: 5.h),
                    Align(
                      alignment: Alignment.topLeft,
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            "Contact:",
                            textAlign: TextAlign.left,
                            style: TextStyle(
                                fontFamily: 'roboto',
                                fontWeight: FontWeight.w300,
                                fontSize: 14.sp,
                                color: Colors.black),
                          ),
                          TextButton(
                              onPressed: () {
                                launch("tel://$remark_contact");
                              },
                              child: Text(
                                "$remark_contact",
                                style: TextStyle(
                                    fontFamily: 'roboto',
                                    fontWeight: FontWeight.w300,
                                    fontSize: 14.sp,
                                    color: Colors.black),
                              ))
                        ],
                      ),
                    ),
                  ],
                ),
              ))
        ],
      ),
    );
  }
}