import 'package:flutter/material.dart' hide Colors;
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:freed/value/Colors.dart';
import 'package:qr_flutter/qr_flutter.dart';

class QrCode extends StatefulWidget {
  final sid;
  final rid;
  final firstname;
  final lastname;

  QrCode(this.sid, {Key? key, this.rid, this.firstname, this.lastname})
      : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _QrCode(sid, rid, firstname, lastname);
  }
}

class _QrCode extends State<QrCode> {
  String _sid;
  String _rid;
  String _firstname;
  String _lastname;

  _QrCode(this._sid, this._rid, this._firstname, this._lastname);

  @override
  Widget build(BuildContext context) {
    print("$_sid $_rid $_firstname $_lastname");
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
            Icons.chevron_left,
            color: Colors.black,
            size: 30.0,
          ),
        ),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16.0),
        child: Center(
          child: Container(
            width: 1.sw,
            padding: EdgeInsets.symmetric(horizontal: 10, vertical: 15),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  "$_firstname $_lastname",
                  style: TextStyle(
                      fontFamily: "roboto",
                      fontWeight: FontWeight.w700,
                      fontSize: 20.0,
                      color: Colors.black),
                ),
                SizedBox(height: 5),
                Text(
                  "$_rid",
                  style: TextStyle(
                      fontFamily: "roboto",
                      fontWeight: FontWeight.w700,
                      fontSize: 20.0,
                      color: Colors.default_color),
                ),
                SizedBox(height: 10),
                QrImage(
                  data: _sid,
                  size: 250,
                ),
                Text(
                  "QR Code",
                  style: TextStyle(
                      fontFamily: "roboto",
                      fontWeight: FontWeight.w300,
                      fontSize: 12.0,
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
