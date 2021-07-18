import 'package:dio/dio.dart';
import 'package:flutter/material.dart' hide Colors;
import 'package:freed/model/NewleaveResponse.dart';
import 'package:freed/services/ApiClient.dart';
import 'package:freed/storage/TempStorage.dart';
import 'package:freed/utils/DioExceptions.dart';
import 'package:freed/value/Colors.dart';
import 'package:freed/value/Image.dart';
import 'package:freed/value/SizeConfig.dart';
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

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    controller =
        AnimationController(vsync: this, duration: Duration(milliseconds: 500));
    offset = Tween<Offset>(begin: Offset.zero, end: Offset(0.0, 2.5))
        .animate(controller!);
  }

  Widget leaveRequestForm() {
    return Form(
      key: _leaveFormKey,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      child: ListView(
        padding: EdgeInsets.all(0.0),
        children: [
          Padding(
            padding: EdgeInsets.only(left: 35, right: 35, top: 30),
            child: Column(
              children: [
                Text(
                  "Escape Request Form",
                  style: TextStyle(
                      fontFamily: 'roboto',
                      fontWeight: FontWeight.w700,
                      fontSize: 20),
                ),
                SizedBox(
                  height: 40,
                ),
                Row(
                  children: [
                    Expanded(
                        child: Container(
                      width: double.infinity,
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
                          style: TextStyle(fontSize: 16.0),
                          decoration: InputDecoration(
                              hintText: "From",
                              isDense: true,
                              contentPadding: EdgeInsets.symmetric(
                                  vertical: 10.0, horizontal: 10.0),
                              hintMaxLines: 1,
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(4.0)),
                              focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                      color: Colors.black, width: 1.5),
                                  borderRadius: BorderRadius.circular(4.0)))),
                    )),
                    SizedBox(
                      width: 25,
                    ),
                    Expanded(
                        child: Container(
                      width: double.infinity,
                      child: TextFormField(
                          validator: (String? value) {
                            if (value!.isEmpty) {
                              return "*required";
                            }
                            return null;
                          },
                          onTap: () async {
                            DateTime? pickedDate = await _toDatePicker();

                            if (pickedDate != null) {
                              formatToDate =
                                  DateFormat('dd MMM').format(pickedDate);
                              setState(() {
                                pickedToDate = pickedDate;
                              });
                            }
                          },
                          controller: TextEditingController(
                              text: formatToDate != null ? formatToDate : null),
                          textAlign: TextAlign.center,
                          readOnly: true,
                          keyboardType: TextInputType.text,
                          maxLines: 1,
                          style: TextStyle(fontSize: 16.0),
                          decoration: InputDecoration(
                              hintText: "To",
                              isDense: true,
                              contentPadding: EdgeInsets.symmetric(
                                  vertical: 10.0, horizontal: 10.0),
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
                SizedBox(
                  height: 10,
                ),
                Container(
                  width: double.infinity,
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
                      style: TextStyle(fontSize: 16.0),
                      decoration: InputDecoration(
                          hintText: "Destination",
                          isDense: true,
                          contentPadding: EdgeInsets.symmetric(
                              vertical: 10.0, horizontal: 10.0),
                          hintMaxLines: 1,
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(4.0)),
                          focusedBorder: OutlineInputBorder(
                              borderSide:
                                  BorderSide(color: Colors.black, width: 1.5),
                              borderRadius: BorderRadius.circular(4.0)))),
                ),
                SizedBox(
                  height: 30,
                ),
                Container(
                  width: double.infinity,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        "Reason for escape",
                        style: TextStyle(
                            fontFamily: 'roboto',
                            fontWeight: FontWeight.w400,
                            fontSize: 16.0,
                            color: Colors.black),
                      ),
                      SizedBox(
                        height: 15,
                      ),
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
                          style: TextStyle(fontSize: 16.0),
                          decoration: InputDecoration(
                              isDense: true,
                              contentPadding: EdgeInsets.symmetric(
                                  vertical: 10.0, horizontal: 10.0),
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
                  height: 45,
                  margin:
                      EdgeInsets.only(top: 30, bottom: 15, right: 15, left: 15),
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () async {
                      if (_leaveFormKey.currentState!.validate()) {
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
                            height: 25.0,
                            width: 25.0,
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
                                fontSize: 18.0),
                          ),
                    style: ButtonStyle(
                        shape: MaterialStateProperty.all(RoundedRectangleBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(30.0)))),
                        backgroundColor:
                            MaterialStateProperty.all(Colors.black)),
                  ),
                ),
                TextButton(
                  onPressed: () {
                    // Navigator.pushNamed(context, '/view request');
                  },
                  child: Text(
                    "Cancel",
                    style: TextStyle(
                        fontFamily: 'robot',
                        fontSize: 16.0,
                        fontWeight: FontWeight.w400,
                        color: Colors.default_color),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  _leaveRequestCall(String rid, String sid, String fromDate, String toDate,
      String destination, String reason) async {
    Map<String, dynamic> reqdata = {
      "RID": rid,
      "studentId": sid,
      "from": fromDate,
      "to": toDate,
      "destination": destination,
      "reason": reason
    };

    try {
      var response = await ApiClient.getServices().newLeaveRequest(reqdata);

      if (response.isNotEmpty) {
        NewleaveResponse newleaveResponse = newleaveResponseFromJson(response);
        bool? isSuccess = newleaveResponse.success;
        String? msg = newleaveResponse.msg;

        if (isSuccess!) {
          //request status animation
          if (controller!.isDismissed) {
            controller!.forward();
          }
          setState(() {
            isProgress = false;
            successMsg = msg!;
            _visible = !_visible;
          });
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
        lastDate: DateTime(DateTime.now().year + 2));
    if (dateTime != null) {
      return dateTime;
    }
  }

  _toDatePicker() async {
    final DateTime? dateTime = await showDatePicker(
        context: context,
        initialDate: pickedFromDate ?? DateTime.now(),
        firstDate: pickedFromDate ?? DateTime.now(),
        lastDate: DateTime(DateTime.now().year + 2));
    if (dateTime != null) {
      return dateTime;
    }
  }

  Widget _reqStatusContainer() {
    return Padding(
      padding: EdgeInsets.only(top: 50, right: 15, bottom: 15, left: 15),
      child: Column(
        children: [
          Container(
            margin: EdgeInsets.only(top: 10),
            width: 50,
            height: 50,
            decoration:
                BoxDecoration(shape: BoxShape.circle, color: Colors.black),
            child: Icon(
              Icons.done_rounded,
              color: Colors.white,
              size: 40,
            ),
          ),
          SizedBox(height: 10),
          Text(
            "Get Ready, with the plan!",
            style: TextStyle(
                fontFamily: 'roboto',
                fontWeight: FontWeight.w700,
                fontSize: 20,
                color: Colors.black),
          ),
          SizedBox(height: 10),
          Text(
            successMsg,
            style: TextStyle(
                fontFamily: 'roboto',
                fontWeight: FontWeight.w400,
                fontSize: 14,
                color: Colors.default_color),
          ),
          SizedBox(height: 30),
          Container(
              height: 40.0,
              width: 110,
              child: ElevatedButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all(Colors.black),
                      shape: MaterialStateProperty.all(RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30.0))),
                      shadowColor: MaterialStateProperty.all(Colors.black)),
                  child: Text(
                    "Done",
                    style: TextStyle(
                        color: Colors.white,
                        fontFamily: 'roboto',
                        fontWeight: FontWeight.w700,
                        fontSize: 16.0),
                  ))),
          SizedBox(height: 7),
          TextButton(
              onPressed: () {},
              child: Text(
                "Track Request Status",
                style: TextStyle(
                    fontFamily: 'roboto',
                    fontWeight: FontWeight.w400,
                    fontSize: 14.0,
                    color: Colors.default_color),
              ))
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
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
                height: double.infinity,
                width: double.infinity,
                child: Stack(children: [
                  Positioned(
                    bottom: 0,
                    child: Container(
                      child: _reqStatusContainer(),
                      width: SizeConfig.screenWidth,
                      height: SizeConfig.safeBlockVertical! * 50,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(45),
                            topRight: Radius.circular(45)),
                      ),
                    ),
                  ),
                  Align(
                      alignment: Alignment(1.0, -0.3),
                      child: Container(
                        width: SizeConfig.safeBlockHorizontal! * 60,
                        height: SizeConfig.safeBlockHorizontal! * 50,
                        child: Image.asset(sitReadingDoodle),
                      )),
                  Column(
                    children: [
                      AnimatedOpacity(
                        opacity: _visible ? 1.0 : 0.0,
                        duration: Duration(milliseconds: 500),
                        child: Container(
                          margin: EdgeInsets.only(
                              left: 40, right: 40, top: 20, bottom: 40),
                          child: Text(
                            "Sed ut perspiciatis unde omnis iste natus error sit voluptatem accusantium",
                            textAlign: TextAlign.center,
                            maxLines: 2,
                            style: TextStyle(
                                fontSize: 14.0,
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
                              width: double.infinity,
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(45),
                                    topRight: Radius.circular(45)),
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
}
