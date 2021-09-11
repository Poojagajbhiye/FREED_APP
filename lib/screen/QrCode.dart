import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart' hide Colors;
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_windowmanager/flutter_windowmanager.dart';
import 'package:freed/screen/SuccessScanned.dart';
import 'package:freed/services/SocketServer.dart';
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
  void initState() {
    SocketServer.initListen();
    preventScreenShot();
    super.initState();
  }

  @override
  void dispose() {
    FlutterWindowManager.clearFlags(FlutterWindowManager.FLAG_SECURE);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<dynamic>(
        stream: SocketServer.streamController.stream.asBroadcastStream(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            WidgetsBinding.instance?.addPostFrameCallback((_) {
              String msg = snapshot.data["msg"];
              bool success = snapshot.data["success"];
              if (success) {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) =>
                        SuccessScanned(titleStatus: "Success", msg: msg),
                  ),
                );
              }
            });
          }
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
                  padding:
                      EdgeInsets.symmetric(horizontal: 10.w, vertical: 15.h),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10.r),
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      _firstname.isEmpty && _lastname.isEmpty
                          ? SizedBox()
                          : Text(
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
                        "Freed QR Scan",
                        style: TextStyle(
                            fontFamily: "roboto",
                            fontWeight: FontWeight.w300,
                            fontSize: 12.sp,
                            color: Colors.black),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        });
  }

  void preventScreenShot() async {
    await FlutterWindowManager.addFlags(FlutterWindowManager.FLAG_SECURE);
  }
}
