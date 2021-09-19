import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart' hide Colors;
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:freed/model/RecordModel.dart';
import 'package:freed/screen/ParticularRecord/AcceptedDoodle.dart';
import 'package:freed/screen/ParticularRecord/DeclinedDoodle.dart';
import 'package:freed/screen/ParticularRecord/ProcessDoodle.dart';
import 'package:freed/screen/QrCode/QrCode.dart';
import 'package:freed/services/ApiClient.dart';
import 'package:freed/utils/DioExceptions.dart';
import 'package:freed/utils/Colors.dart';
import 'package:freed/utils/Image.dart';
import 'package:intl/intl.dart';

class ViewRequest extends StatefulWidget {
  final recordId;
  ViewRequest({Key? key, @required this.recordId}) : super(key: key);
  @override
  State<StatefulWidget> createState() {
    return _ViewRequest(recordId);
  }
}

class _ViewRequest extends State<ViewRequest> {
  final recordId;
  String rid = "";
  String fromDate = "";
  String toDate = "";
  String destination = "";
  String reason = "";
  String firstname = "";
  String lastname = "";
  String course = "";
  String branch = "";
  String semester = "";

  bool isprocess = true;
  bool networkerror = false;
  String errorMsg = "";

  bool isCancel = false;

  bool isAcceptedStatus = false;
  bool isDeclinedStatus = false;
  bool isProcessStatus = false;

  //warden remark
  String? remarkMsg;
  String? remarkFirstname;
  String? remarkLastname;
  String? remarkContact;

  _ViewRequest(this.recordId);

  @override
  void initState() {
    _fatchRecordDetails(recordId);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Material(
        child: Container(
          color: Colors.white,
          child: Column(
            children: [
              AppBar(
                backgroundColor: Colors.white,
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
              Expanded(
                  child: networkerror
                      ? _networkErrorui(errorMsg)
                      : isprocess
                          ? Center(
                              child: CircularProgressIndicator(
                                color: Colors.black,
                              ),
                            )
                          : ListView(
                              padding: EdgeInsets.only(
                                  top: 0.0,
                                  bottom: 50.h,
                                  left: 30.w,
                                  right: 30.w),
                              children: [
                                _checkStatus(),
                                SizedBox(height: 30.h),
                                _header(),
                                SizedBox(height: 15.h),
                                _detailedCard(),
                                SizedBox(height: 20.h),
                                _reasonExpendedCard(),
                                SizedBox(height: 50.h),
                                isAcceptedStatus || isDeclinedStatus
                                    ? SizedBox(height: 0.0)
                                    : _cancelButton(),
                                isAcceptedStatus
                                    ? _qrCodeButton()
                                    : SizedBox(height: 0.0),
                              ],
                            ))
            ],
          ),
        ),
      ),
    );
  }

  Widget _qrCodeButton() {
    return Center(
      child: Container(
        width: 170.w,
        height: 45.h,
        child: ElevatedButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => QrCode(
                  recordId,
                  firstname: firstname,
                  lastname: lastname,
                  rid: rid,
                ),
              ),
            );
          },
          child: Text(
            "Show QR Code",
            style: TextStyle(
                fontFamily: 'roboto',
                fontWeight: FontWeight.w400,
                fontSize: 18.sp,
                color: Colors.white),
          ),
          style: ButtonStyle(
            shape: MaterialStateProperty.all(RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(30.0))),
            backgroundColor: MaterialStateProperty.all(
              Colors.black,
            ),
          ),
        ),
      ),
    );
  }

  Widget _checkStatus() {
    if (isAcceptedStatus)
      return AcceptedDoodle();
    else if (isDeclinedStatus)
      return DeclinedDoodle(
        remark_msg: remarkMsg,
        remark_firstname: remarkFirstname,
        remark_contact: remarkContact,
        remark_lastname: remarkLastname,
      );
    else
      return ProcessDoodle();
  }

  _fatchRecordDetails(String recordId) async {
    try {
      var response =
          await ApiClient.getServices().getParticulerRecord(recordId);

      if (response.isNotEmpty) {
        RecordModel recordModel = recordModelFromJson(response);
        bool? isSuccess = recordModel.success;
        DateTime? _fromdate = recordModel.record!.from;
        DateTime? _todate = recordModel.record!.to;
        String? _status = recordModel.record!.status;

        //student detail
        String? _firstname = recordModel.record!.student!.firstName;
        String? _lastname = recordModel.record!.student!.lastName.toString();
        String? _course = recordModel.record!.student!.course;
        String? _branch = recordModel.record!.student!.branch;
        String? _semester = recordModel.record!.student!.semester.toString();

        //remark
        String? _remarkMsg = recordModel.record?.remarkByWarden?.msg;
        String? _remarkFirstname =
            recordModel.record?.remarkByWarden?.by?.firstname;
        String? _remarkLastname =
            recordModel.record?.remarkByWarden?.by?.lastname;
        String? _remarkContact =
            recordModel.record?.remarkByWarden?.by?.contact.toString();

        if (isSuccess!) {
          setState(() {
            isprocess = false;
            networkerror = false;
            if (recordModel.record != null) {
              rid = recordModel.record!.rid!;
              fromDate = DateFormat('dd MMM yyyy').format(_fromdate!);
              toDate = DateFormat('dd MMM yyyy').format(_todate!);
              destination = recordModel.record!.destination!;
              reason = recordModel.record!.reason!;
              firstname = _firstname!;
              lastname = _lastname;
              course = _course!;
              branch = _branch!;
              semester = _semester;

              //remark
              remarkMsg = _remarkMsg;
              remarkFirstname = _remarkFirstname;
              remarkLastname = _remarkLastname;
              remarkContact = _remarkContact;

              if (_status!.contains("ACCEPTED"))
                isAcceptedStatus = true;
              else if (_status.contains("DECLINED"))
                isDeclinedStatus = true;
              else
                isProcessStatus = true;
            }
          });
        }
      }
    } catch (e) {
      print(e);
      var dioError = e as DioError;
      setState(() {
        isprocess = false;
        networkerror = true;
        errorMsg = DioExceptions.fromDioError(dioError).toString();
      });
      print(errorMsg);
    }
  }

  Widget _networkErrorui(String errorMsg) {
    return Container(
      width: 1.sw,
      height: 1.sh,
      child: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
                width: 150.r, height: 150.r, child: Image.asset(lightHouse)),
            SizedBox(height: 20.h),
            Text(
              errorMsg,
              style: TextStyle(
                  fontFamily: "roboto",
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w400,
                  color: Colors.black),
            ),
            SizedBox(height: 15.h),
            FittedBox(
              child: Text(
                "Check your connection, then refresh the page",
                style: TextStyle(
                    fontFamily: "roboto",
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w300,
                    color: Colors.black),
              ),
            ),
            SizedBox(height: 20.h),
            Container(
              width: 150.r,
              child: ElevatedButton(
                onPressed: () {
                  if (mounted)
                    setState(() {
                      networkerror = false;
                      isprocess = true;
                    });
                  _fatchRecordDetails(recordId);
                },
                child: Text(
                  "Refresh",
                  style: TextStyle(
                      fontFamily: "roboto",
                      fontWeight: FontWeight.w400,
                      fontSize: 14.sp,
                      color: Colors.black),
                ),
                style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(Colors.white),
                    shadowColor: MaterialStateProperty.all(Colors.transparent),
                    shape: MaterialStateProperty.all(RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(50.r))),
                    side: MaterialStateProperty.all(
                        BorderSide(color: Colors.gray, width: 2.0))),
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget _header() {
    return Container(
      width: double.infinity,
      child: Column(
        children: [
          Text("Leave Application",
              style: TextStyle(
                  fontFamily: 'roboto',
                  fontWeight: FontWeight.w700,
                  fontSize: 16.sp,
                  color: Colors.black)),
          SizedBox(height: 5.h),
          //registration id value from api
          Text(rid,
              style: TextStyle(
                  fontFamily: 'roboto',
                  fontWeight: FontWeight.w700,
                  fontSize: 22.sp,
                  color: Colors.default_color)),
          SizedBox(height: 15.h),
          Container(
            width: 85.w,
            padding: EdgeInsets.symmetric(vertical: 6.w),
            child: Align(
              child: Text(
                "Regular",
                style: TextStyle(
                    fontFamily: 'roboto',
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w400,
                    color: Colors.white),
              ),
            ),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(30.0), color: Colors.black),
          ),
          SizedBox(height: 15.h),
          Text(
            "$firstname $lastname",
            style: TextStyle(
                fontFamily: 'roboto',
                fontSize: 16.sp,
                fontWeight: FontWeight.w500,
                color: Colors.black),
          ),
          Text(
            "$course $branch - $semester",
            style: TextStyle(
                fontFamily: 'roboto',
                fontSize: 16.sp,
                fontWeight: FontWeight.w500,
                color: Colors.black),
          )
        ],
      ),
    );
  }

  Widget _cancelButton() {
    return Container(
      width: 1.sw,
      height: 45.h,
      margin: EdgeInsets.symmetric(horizontal: 35.w),
      child: ElevatedButton(
        onPressed: () {
          _deleteRecord(recordId);
          setState(() {
            isCancel = true;
          });
        },
        child: isCancel
            ? SizedBox(
                height: 25.r,
                width: 25.r,
                child: CircularProgressIndicator(
                  color: Colors.default_color,
                  strokeWidth: 2.0,
                ),
              )
            : Text(
                "Cancel Request",
                style: TextStyle(
                    fontFamily: 'roboto',
                    fontWeight: FontWeight.w400,
                    fontSize: 18.sp,
                    color: Colors.default_color),
              ),
        style: ButtonStyle(
            shape: MaterialStateProperty.all(RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(30.0))),
            side: MaterialStateProperty.all(
                BorderSide(color: Colors.gray, width: 2.0)),
            backgroundColor: MaterialStateProperty.all(Colors.white),
            shadowColor: MaterialStateProperty.all(Colors.transparent)),
      ),
    );
  }

  //api call
  _deleteRecord(String recordId) async {
    try {
      var response = await ApiClient.getServices().deleteRecord(recordId);
      if (response.isNotEmpty) {
        Map<String, dynamic> fromJson = jsonDecode(response);
        String msg = fromJson["msg"];
        bool success = fromJson["success"];

        if (success) {
          setState(() {
            isCancel = false;
          });

          Navigator.pop(context);
          _snackBar(msg);
        }
      }
    } catch (e) {
      print(e);
      setState(() {
        isCancel = false;
      });
      var dioError = e as DioError;
      var error = DioExceptions.fromDioError(dioError).toString();
      _snackBar(error);
    }
  }

  Widget _reasonExpendedCard() {
    return Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10), color: Colors.gray),
        child: Theme(
          data: Theme.of(context).copyWith(dividerColor: Colors.transparent),
          child: ExpansionTile(
            title: Text(
              "Reason for leave",
              style: TextStyle(
                  fontFamily: 'roboto',
                  fontWeight: FontWeight.w700,
                  fontSize: 16.sp,
                  color: Colors.black),
            ),
            childrenPadding:
                EdgeInsets.only(left: 15.w, right: 15.w, bottom: 15.h),
            children: [
              //reason value from api
              Align(
                alignment: Alignment.topLeft,
                child: Text(
                  reason,
                  textAlign: TextAlign.left,
                  style: TextStyle(
                      fontFamily: 'roboto',
                      fontWeight: FontWeight.w300,
                      fontSize: 16.sp,
                      color: Colors.default_color),
                ),
              )
            ],
          ),
        ));
  }

  Widget _detailedCard() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 18.w, vertical: 20.h),
      width: 1.sw,
      decoration: BoxDecoration(
          color: Colors.yellow, borderRadius: BorderRadius.circular(10)),
      child: Column(
        children: [
          Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
            Text(
              "From",
              style: TextStyle(
                  fontFamily: 'roboto',
                  fontWeight: FontWeight.w700,
                  fontSize: 16.sp,
                  color: Colors.black),
            ),
            Text(
              "To",
              style: TextStyle(
                  fontFamily: 'roboto',
                  fontWeight: FontWeight.w700,
                  fontSize: 16.sp,
                  color: Colors.black),
            )
          ]),
          SizedBox(height: 5.h),
          Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
            //from date value from api
            Text(
              fromDate,
              style: TextStyle(
                  fontFamily: 'roboto',
                  fontWeight: FontWeight.w400,
                  fontSize: 16.sp,
                  color: Colors.black),
            ),
            //to date value from api
            Text(
              toDate,
              style: TextStyle(
                  fontFamily: 'roboto',
                  fontWeight: FontWeight.w400,
                  fontSize: 16.sp,
                  color: Colors.black),
            )
          ]),
          SizedBox(height: 12.h),
          Align(
            alignment: Alignment.centerLeft,
            child: Text(
              "Destination",
              style: TextStyle(
                  fontFamily: 'roboto',
                  fontWeight: FontWeight.w700,
                  fontSize: 16.sp,
                  color: Colors.black),
            ),
          ),
          SizedBox(height: 10.h),
          //destination value from api
          Align(
            alignment: Alignment.centerLeft,
            child: Text(
              destination,
              style: TextStyle(
                  fontFamily: 'roboto',
                  fontWeight: FontWeight.w300,
                  fontSize: 16.sp,
                  color: Colors.black),
            ),
          )
        ],
      ),
    );
  }

  _snackBar(String msg) {
    var snackbar = SnackBar(
      content: Text(msg),
      behavior: SnackBarBehavior.floating,
    );
    ScaffoldMessenger.of(context).showSnackBar(snackbar);
  }
}






