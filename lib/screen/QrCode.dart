import 'package:flutter/material.dart' hide Colors;
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:freed/value/Colors.dart';
import 'package:qr_flutter/qr_flutter.dart';

class QrCode extends StatefulWidget {
  final qrData;
  final rid;
  final firstname;
  final lastname;

  QrCode(this.qrData, {Key? key, this.rid, this.firstname, this.lastname})
      : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _QrCode(qrData, rid, firstname, lastname);
  }
}

class _QrCode extends State<QrCode> {
  String _qrData;
  String _rid;
  String _firstname;
  String _lastname;

  _QrCode(this._qrData, this._rid, this._firstname, this._lastname);

  @override
  Widget build(BuildContext context) {
    print("$_qrData $_rid $_firstname $_lastname");
    return Scaffold(
      backgroundColor: Colors.yellow,
      appBar: AppBar(
        backgroundColor: Colors.yellow,
        automaticallyImplyLeading: false,
        shadowColor: Colors.transparent,
        leadingWidth: 70.w,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(
            Icons.close,
            color: Colors.black,
            size: 30.r,
          ),
        ),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16.w),
        child: Center(
          child: Container(
            width: 1.sw,
            padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 15.h),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10.r),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  "$_firstname $_lastname",
                  style: TextStyle(
                      fontFamily: "roboto",
                      fontWeight: FontWeight.w700,
                      fontSize: 20.sp,
                      color: Colors.black),
                ),
                SizedBox(height: 5.h),
                Text(
                  "$_rid",
                  style: TextStyle(
                      fontFamily: "roboto",
                      fontWeight: FontWeight.w700,
                      fontSize: 20.sp,
                      color: Colors.default_color),
                ),
                SizedBox(height: 10.h),
                QrImage(
                  data: _qrData,
                  size: 250.r,
                ),
                Text(
                  "QR Code",
                  style: TextStyle(
                      fontFamily: "roboto",
                      fontWeight: FontWeight.w300,
                      fontSize: 12.sp,
                      color: Colors.black),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
