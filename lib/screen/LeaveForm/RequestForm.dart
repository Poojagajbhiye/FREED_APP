import 'package:dio/dio.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart' hide Colors;
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:freed/model/NewleaveResponse.dart';
import 'package:freed/screen/Profile/StudentProfile.dart';
import 'package:freed/screen/ParticularRecord/ViewRequest.dart';
import 'package:freed/services/ApiClient.dart';
import 'package:freed/storage/TempStorage.dart';
import 'package:freed/utils/DioExceptions.dart';
import 'package:freed/utils/Colors.dart';
import 'package:freed/utils/Image.dart';
import 'package:intl/intl.dart';

class RequestForm extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _RequestForm();
  }
}

class _RequestForm extends State<RequestForm> with TickerProviderStateMixin {
  AnimationController? controller, reqStatusCtrl;
  Animation<Offset>? offset, reqStatusOffset;
  bool _visible = true;
  DateTime? pickedFromDate, pickedToDate;
  String? formatFromDate, formatToDate;
  bool isProgress = false;

  TextEditingController destinationController = TextEditingController();
  TextEditingController reasonController = TextEditingController();

  String successMsg = "Your Request  has been sent successfully";

  final _leaveFormKey = GlobalKey<FormState>();

  bool keyboardVisiblity = false;

  String? recordId;

  @override
  void initState() {
    super.initState();

    controller =
        AnimationController(vsync: this, duration: Duration(milliseconds: 500));
    offset = Tween<Offset>(begin: Offset.zero, end: Offset(0.0, 2.5))
        .animate(controller!);

    Future.delayed(Duration(milliseconds: 300), () => _profileUpdateChecker());
  }

  @override
  void dispose() {
    controller?.dispose();
    destinationController.dispose();
    reasonController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    setState(() {
      keyboardVisiblity = MediaQuery.of(context).viewInsets.bottom != 0;
    });
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Material(
        child: Container(
          color: Colors.yellow,
          child: Column(
            children: [
              AppBar(
                  backgroundColor: Colors.yellow,
                  automaticallyImplyLeading: false,
                  shadowColor: Colors.transparent,
                  leadingWidth: 70,
                  leading: IconButton(
                      onPressed: () => Navigator.pop(context),
                      icon: Icon(
                        Icons.chevron_left,
                        color: Colors.black,
                        size: 30.0,
                      ))),
              Expanded(
                  child: Container(
                height: 1.sh,
                width: 1.sw,
                child: Stack(children: [
                  Positioned(
                    bottom: 0,
                    child: Container(
                      child: _reqStatusContainer(),
                      width: 1.sw,
                      height: 374.h,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(45.r),
                            topRight: Radius.circular(45.r)),
                      ),
                    ),
                  ),
                  Align(
                      alignment: Alignment(1.0, -0.3),
                      child: Container(
                        width: 216.r,
                        height: 180.r,
                        child: Image.asset(sitReadingDoodle),
                      )),
                  Column(
                    children: [
                      AnimatedOpacity(
                        opacity: _visible ? 1.0 : 0.0,
                        duration: Duration(milliseconds: 500),
                        child: keyboardVisiblity
                            ? SizedBox()
                            : Container(
                                margin: EdgeInsets.only(
                                    left: 40.w,
                                    right: 40.w,
                                    top: 20.h,
                                    bottom: 35.h),
                                child: Text(
                                  "Sed ut perspiciatis unde omnis iste natus error sit voluptatem accusantium",
                                  textAlign: TextAlign.center,
                                  maxLines: 2,
                                  style: TextStyle(
                                      fontSize: 14.sp,
                                      fontFamily: 'roboto',
                                      fontWeight: FontWeight.w700),
                                ),
                              ),
                      ),
                      Expanded(
                        child: Align(
                          alignment: Alignment.bottomCenter,
                          child: SlideTransition(
                            position: offset!,
                            child: Container(
                              child: leaveRequestForm(),
                              width: 1.sw,
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(45.r),
                                    topRight: Radius.circular(45.r)),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ]),
              ))
            ],
          ),
        ),
      ),
    );
  }

  Widget leaveRequestForm() {
    return Form(
      key: _leaveFormKey,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      child: ListView(
        padding: EdgeInsets.all(0.0),
        children: [
          SingleChildScrollView(
            reverse: true,
            child: Padding(
              padding: EdgeInsets.only(
                  left: 35.w,
                  right: 35.w,
                  top: 30.h,
                  bottom: MediaQuery.of(context).viewInsets.bottom),
              child: Column(
                children: [
                  Text(
                    "Escape Request Form",
                    style: TextStyle(
                        fontFamily: 'roboto',
                        fontWeight: FontWeight.w700,
                        fontSize: 20.sp),
                  ),
                  SizedBox(height: 40.h),
                  Row(
                    children: [
                      Expanded(
                          child: Container(
                        width: 1.sw,
                        child: TextFormField(
                            validator: (String? value) {
                              if (value!.isEmpty) {
                                return "*required";
                              }
                              return null;
                            },
                            onTap: () async {
                              DateTime? pickedDate = await _fromDatePicker();

                              if (pickedDate != null) {
                                formatFromDate =
                                    DateFormat('dd MMM').format(pickedDate);
                                setState(() {
                                  pickedFromDate = pickedDate;
                                });
                              }
                            },
                            controller: TextEditingController(
                                text: formatFromDate != null
                                    ? formatFromDate
                                    : null),
                            textAlign: TextAlign.center,
                            readOnly: true,
                            keyboardType: TextInputType.text,
                            maxLines: 1,
                            style: TextStyle(fontSize: 16.sp),
                            decoration: InputDecoration(
                                hintText: "From",
                                isDense: true,
                                contentPadding: EdgeInsets.symmetric(
                                    vertical: 10.h, horizontal: 10.w),
                                hintMaxLines: 1,
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(4.0)),
                                focusedBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                        color: Colors.black, width: 1.5),
                                    borderRadius: BorderRadius.circular(4.0)))),
                      )),
                      SizedBox(width: 25.w),
                      Expanded(
                          child: Container(
                        width: 1.sw,
                        child: TextFormField(
                            validator: (String? value) {
                              if (value!.isEmpty) {
                                return "*required";
                              }
                              return null;
                            },
                            onTap: () async {
                              if (pickedFromDate != null) {
                                DateTime? pickedDate = await _toDatePicker();

                                if (pickedDate != null) {
                                  formatToDate =
                                      DateFormat('dd MMM').format(pickedDate);
                                  setState(() {
                                    pickedToDate = pickedDate;
                                  });
                                }
                              } else {
                                return null;
                              }
                            },
                            controller: TextEditingController(
                                text:
                                    formatToDate != null ? formatToDate : null),
                            textAlign: TextAlign.center,
                            readOnly: true,
                            keyboardType: TextInputType.text,
                            maxLines: 1,
                            style: TextStyle(fontSize: 16.sp),
                            decoration: InputDecoration(
                                hintText: "To",
                                isDense: true,
                                contentPadding: EdgeInsets.symmetric(
                                    vertical: 10.h, horizontal: 10.w),
                                hintMaxLines: 1,
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(4.0)),
                                focusedBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                        color: Colors.black, width: 1.5),
                                    borderRadius: BorderRadius.circular(4.0)))),
                      )),
                    ],
                  ),
                  SizedBox(height: 10.h),
                  Container(
                    width: 1.sw,
                    child: TextFormField(
                        validator: (String? value) {
                          if (value!.isEmpty) {
                            return "*required";
                          }
                          return null;
                        },
                        controller: destinationController,
                        textAlign: TextAlign.center,
                        keyboardType: TextInputType.text,
                        maxLines: 1,
                        style: TextStyle(fontSize: 16.sp),
                        decoration: InputDecoration(
                            hintText: "Destination",
                            isDense: true,
                            contentPadding: EdgeInsets.symmetric(
                                vertical: 10.h, horizontal: 10.w),
                            hintMaxLines: 1,
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(4.0)),
                            focusedBorder: OutlineInputBorder(
                                borderSide:
                                    BorderSide(color: Colors.black, width: 1.5),
                                borderRadius: BorderRadius.circular(4.0)))),
                  ),
                  SizedBox(height: 30.h),
                  Container(
                    width: 1.sw,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          "Reason for escape",
                          style: TextStyle(
                              fontFamily: 'roboto',
                              fontWeight: FontWeight.w400,
                              fontSize: 16.sp,
                              color: Colors.black),
                        ),
                        SizedBox(height: 15.h),
                        Container(
                          child: TextFormField(
                            validator: (String? value) {
                              if (value!.isEmpty) {
                                return "*required";
                              }
                              return null;
                            },
                            controller: reasonController,
                            maxLines: 5,
                            maxLength: 250,
                            style: TextStyle(fontSize: 16.sp),
                            decoration: InputDecoration(
                                isDense: true,
                                contentPadding: EdgeInsets.symmetric(
                                    vertical: 10.h, horizontal: 10.w),
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(4.0)),
                                focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(4.0),
                                    borderSide: BorderSide(
                                        color: Colors.black, width: 1.5))),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    height: 45.h,
                    margin: EdgeInsets.only(
                        top: 30.h, bottom: 15.h, right: 15.w, left: 15.w),
                    width: 1.sw,
                    child: ElevatedButton(
                      onPressed: () async {
                        if (_leaveFormKey.currentState!.validate()) {
                          //hide on screen keyboard
                          FocusScope.of(context).unfocus();

                          setState(() {
                            isProgress = true;
                          });
                          String? _rid = await TempStorage.getRid();
                          String? _sid = await TempStorage.getUserId();
                          String? _fromDate = pickedFromDate.toString();
                          String? _toDate = pickedToDate.toString();
                          String? _destination = destinationController.text;
                          String? _reason = reasonController.text;

                          _leaveRequestCall(_rid, _sid, _fromDate, _toDate,
                              _destination, _reason);
                        }
                      },
                      child: isProgress
                          ? SizedBox(
                              height: 25.r,
                              width: 25.r,
                              child: CircularProgressIndicator(
                                color: Colors.white,
                                strokeWidth: 2.0,
                              ),
                            )
                          : Text(
                              "Process Request",
                              style: TextStyle(
                                  fontFamily: 'roboto',
                                  fontWeight: FontWeight.w700,
                                  fontSize: 18.sp),
                            ),
                      style: ButtonStyle(
                          shape: MaterialStateProperty.all(
                              RoundedRectangleBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(30.0)))),
                          backgroundColor:
                              MaterialStateProperty.all(Colors.black)),
                    ),
                  ),
                  TextButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: Text(
                      "Cancel",
                      style: TextStyle(
                          fontFamily: 'robot',
                          fontSize: 16.sp,
                          fontWeight: FontWeight.w400,
                          color: Colors.default_color),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  _leaveRequestCall(String rid, String sid, String fromDate, String toDate,
      String destination, String reason) async {
    String? deviceToken = await FirebaseMessaging.instance.getToken();
    Map<String, dynamic> reqdata = {
      "RID": rid,
      "student": sid,
      "from": fromDate,
      "to": toDate,
      "destination": destination,
      "reason": reason
    };

    try {
      var response =
          await ApiClient.getServices().newLeaveRequest(deviceToken!, reqdata);

      if (response.isNotEmpty) {
        NewleaveResponse newleaveResponse = newleaveResponseFromJson(response);
        bool? isSuccess = newleaveResponse.success;
        String? msg = newleaveResponse.msg;
        String? _recordId = newleaveResponse.result!.id;

        if (isSuccess!) {
          //request status animation
          if (controller!.isDismissed) {
            controller!.forward();
          }

          setState(() {
            isProgress = false;
            successMsg = msg!;
            recordId = _recordId;
            _visible = !_visible;
          });

          //notify to the warden
          _notifyToWarden();
        }
      }
    } catch (e) {
      var err = e as DioError;
      setState(() {
        isProgress = false;
      });
      var error = DioExceptions.fromDioError(err).toString();
      _snackBar(error);
    }
  }

  _snackBar(String msg) {
    var snackbar = SnackBar(content: Text(msg));
    ScaffoldMessenger.of(context).showSnackBar(snackbar);
  }

  _fromDatePicker() async {
    final DateTime? dateTime = await showDatePicker(
        context: context,
        initialDate: pickedFromDate ?? DateTime.now(),
        firstDate: DateTime.now(),
        lastDate: DateTime(
            DateTime.now().year, DateTime.now().month + 2, DateTime.now().day));
    if (dateTime != null) {
      return dateTime;
    }
  }

  _toDatePicker() async {
    final DateTime? dateTime = await showDatePicker(
        context: context,
        initialDate: pickedFromDate!, // ?? DateTime.now()
        firstDate: pickedFromDate!, //  ?? DateTime.now()
        lastDate: DateTime(pickedFromDate!.year, pickedFromDate!.month + 2,
            pickedFromDate!.day));
    if (dateTime != null) {
      return dateTime;
    }
  }

  Widget _reqStatusContainer() {
    return ListView(
      padding:
          EdgeInsets.only(top: 50.h, right: 15.w, bottom: 15.h, left: 15.w),
      children: [
        Column(
          children: [
            Container(
              margin: EdgeInsets.only(top: 10.h),
              width: 50.r,
              height: 50.r,
              decoration:
                  BoxDecoration(shape: BoxShape.circle, color: Colors.black),
              child: Icon(
                Icons.done_rounded,
                color: Colors.white,
                size: 40.r,
              ),
            ),
            SizedBox(height: 10.h),
            Text(
              "Get Ready, with the plan!",
              style: TextStyle(
                  fontFamily: 'roboto',
                  fontWeight: FontWeight.w700,
                  fontSize: 20.sp,
                  color: Colors.black),
            ),
            SizedBox(height: 10.h),
            Text(
              successMsg,
              style: TextStyle(
                  fontFamily: 'roboto',
                  fontWeight: FontWeight.w400,
                  fontSize: 14.sp,
                  color: Colors.default_color),
            ),
            SizedBox(height: 30.h),
            Container(
                height: 40.h,
                width: 110.w,
                child: ElevatedButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    style: ButtonStyle(
                        backgroundColor:
                            MaterialStateProperty.all(Colors.black),
                        shape: MaterialStateProperty.all(RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30.0))),
                        shadowColor: MaterialStateProperty.all(Colors.black)),
                    child: Text(
                      "Done",
                      style: TextStyle(
                          color: Colors.white,
                          fontFamily: 'roboto',
                          fontWeight: FontWeight.w700,
                          fontSize: 16.sp),
                    ))),
            SizedBox(height: 7.h),
            TextButton(
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>
                              ViewRequest(recordId: recordId)));
                },
                child: Text(
                  "Track Request Status",
                  style: TextStyle(
                      fontFamily: 'roboto',
                      fontWeight: FontWeight.w400,
                      fontSize: 14.sp,
                      color: Colors.default_color),
                ))
          ],
        )
      ],
    );
  }

  _profileUpdateChecker() async {
    String first = await TempStorage.getFirstName();
    String branch = await TempStorage.getBranch();
    String semester = await TempStorage.getSemester();
    String course = await TempStorage.getCourse();
    String email = await TempStorage.getEmail();

    if (first.isEmpty ||
        branch.isEmpty ||
        semester.isEmpty ||
        course.isEmpty ||
        email.isEmpty) {
      _showDialog();
    }
  }

  _showDialog() async {
    bool iscancel = false;
    Dialog dialog = Dialog(
      backgroundColor: Colors.white,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(7.0)),
      insetPadding: EdgeInsets.all(20.0),
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 16.h, horizontal: 10.w),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              "Attention!",
              style: TextStyle(
                  color: Colors.black,
                  fontFamily: 'roboto',
                  fontSize: 20.sp,
                  fontWeight: FontWeight.w700),
            ),
            SizedBox(height: 10.h),
            Text(
              "Please update your profile to continue",
              style: TextStyle(
                  color: Colors.black,
                  fontFamily: 'roboto',
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w400),
            ),
            SizedBox(height: 20.h),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>
                                StudentProfile(isLogoutVisible: false)))
                    .then((value) {
                  if (value == 1)
                    Navigator.pop(context);
                  else
                    return;
                });
              },
              child: Text(
                "Update Profile",
                style: TextStyle(
                    color: Colors.white,
                    fontFamily: 'roboto',
                    fontWeight: FontWeight.w700,
                    fontSize: 16.sp),
              ),
              style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(Colors.black),
                  shape: MaterialStateProperty.all(RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(50.0)))),
            ),
            TextButton(
                onPressed: () {
                  setState(() {
                    iscancel = true;
                  });
                  Navigator.pop(context);
                },
                child: Text(
                  "Cancel",
                  style: TextStyle(
                      fontFamily: "roboto",
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w400,
                      color: Colors.default_color),
                ))
          ],
        ),
      ),
    );

    await showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) {
          return WillPopScope(child: dialog, onWillPop: () async => false);
        });
    iscancel ? Navigator.pop(context) : null;
  }

  _notifyToWarden() async {
    String serverKey =
        "key=AAAAbEj7ATs:APA91bH8GhXCY55CQ3DfxZOeTOLxY0aPEZuViUMi5PHD44iK-4KsGBrhjshkB7vKDeFtAlj9Lol19hhPaUXtKBGMF1XsrEXU2nle4xL44uI9XL0EPVIEQ52z0UjMCrHjg5OK7WqgiySP";
    String topic = "warden";
    String msgBody =
        await TempStorage.getFirstName() + " " + await TempStorage.getLastName();
    print(msgBody);
    Map<String, dynamic> body = {
      'notification': <String, dynamic>{
        'body': 'Requested by - $msgBody',
        'title': 'New Leave Application'
      },
      'priority': 'high',
      'data': <String, dynamic>{
        'click_action': 'FLUTTER_NOTIFICATION_CLICK',
        'id': '1',
        'status': 'done'
      },
      'to': '/topics/$topic'
    };
    try {
      await ApiClient.getServices().sendNotificationToWarden(serverKey, body);
      print("sent notification successfully..");
    } catch (e) {
      print("firebase notification exception: $e");
    }
  }
}
