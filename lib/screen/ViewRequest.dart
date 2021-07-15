import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart' hide Colors;
import 'package:freed/model/RecordListModel.dart';
import 'package:freed/model/RecordModel.dart';
import 'package:freed/services/ApiClient.dart';
import 'package:freed/utils/DioExceptions.dart';
import 'package:freed/value/Colors.dart';
import 'package:freed/value/Image.dart';
import 'package:intl/intl.dart';

class ViewRequest extends StatefulWidget {
  final recordId;
  ViewRequest({Key? key, @required this.recordId}) : super(key: key);
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
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
  bool isprocess = true;

  bool isCancel = false;

  bool isAcceptedStatus = false;
  bool isDeclinedStatus = false;
  bool isProcessStatus = false;

  _ViewRequest(this.recordId);

  @override
  void initState() {
    _fatchRecordDetails(recordId);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Container(
        color: Colors.white,
        child: Column(
          children: [
            AppBar(
              backgroundColor: Colors.white,
              automaticallyImplyLeading: false,
              shadowColor: Colors.transparent,
              leadingWidth: 70,
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
                child: Container(
              padding: EdgeInsets.only(left: 30, right: 30, top: 0.0),
              color: Colors.white,
              height: double.infinity,
              width: double.infinity,
              child: isprocess
                  ? Center(
                      child: CircularProgressIndicator(
                        color: Colors.black,
                      ),
                    )
                  : ListView(
                      padding: EdgeInsets.only(top: 0.0, bottom: 50.0),
                      children: [
                        _checkStatus(),
                        SizedBox(height: 30),
                        _header(),
                        SizedBox(height: 15),
                        _detailedCard(),
                        SizedBox(height: 20),
                        _reasonExpendedCard(),
                        SizedBox(height: 50),
                        _cancelButton(),
                      ],
                    ),
            ))
          ],
        ),
      ),
    );
  }

  Widget _checkStatus() {
    if (isAcceptedStatus)
      return AcceptedDoodle();
    else if (isDeclinedStatus)
      return DeclinedDoodle();
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

        if (isSuccess!) {
          setState(() {
            isprocess = false;
            if (recordModel.record != null) {
              rid = recordModel.record!.rid!;
              fromDate = DateFormat('dd MMM yyyy').format(_fromdate!);
              toDate = DateFormat('dd MMM yyyy').format(_todate!);
              destination = recordModel.record!.destination!;
              reason = recordModel.record!.reason!;

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
      var dioError = e as DioError;
      setState(() {
        isprocess = false;
      });
      var error = DioExceptions.fromDioError(dioError).toString();
      print(error);
    }
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
                  fontSize: 16.0,
                  color: Colors.black)),
          SizedBox(
            height: 5,
          ),
          //registration id value from api
          Text(rid,
              style: TextStyle(
                  fontFamily: 'roboto',
                  fontWeight: FontWeight.w700,
                  fontSize: 22.0,
                  color: Colors.default_color)),
          SizedBox(
            height: 15,
          ),
          Container(
            width: 85,
            padding: EdgeInsets.symmetric(vertical: 6),
            child: Align(
              child: Text(
                "Regular",
                style: TextStyle(
                    fontFamily: 'roboto',
                    fontSize: 14.0,
                    fontWeight: FontWeight.w400,
                    color: Colors.white),
              ),
            ),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(30.0), color: Colors.black),
          ),
          SizedBox(
            height: 15,
          ),
          Text(
            "Aman Vishwakarma",
            style: TextStyle(
                fontFamily: 'roboto',
                fontSize: 16,
                fontWeight: FontWeight.w500,
                color: Colors.black),
          ),
          Text(
            "B.tech CSE - 6",
            style: TextStyle(
                fontFamily: 'roboto',
                fontSize: 16,
                fontWeight: FontWeight.w500,
                color: Colors.black),
          )
        ],
      ),
    );
  }

  Widget _cancelButton() {
    return Container(
      width: double.infinity,
      height: 45.0,
      margin: EdgeInsets.symmetric(horizontal: 35),
      child: ElevatedButton(
        onPressed: () {
          _deleteRecord(recordId);
          setState(() {
            isCancel = true;
          });
        },
        child: isCancel
            ? SizedBox(
                height: 25.0,
                width: 25.0,
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
                    fontSize: 18.0,
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

  _deleteRecord(String recordId) async {
    try {
      var response = await ApiClient.getServices().deleteRecord(recordId);
      if (response.isNotEmpty) {
        Map<String, dynamic> fromJson = jsonDecode(response);
        String msg = fromJson["msg"];
        bool success = fromJson["success"];

        if (success) {
          Navigator.pop(context);
          setState(() {
            isCancel = false;
          });
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
                  fontSize: 16.0,
                  color: Colors.black),
            ),
            childrenPadding: EdgeInsets.only(left: 15, right: 15, bottom: 15),
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
                      fontSize: 16.0,
                      color: Colors.default_color),
                ),
              )
            ],
          ),
        ));
  }

  Widget _detailedCard() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 18, vertical: 20),
      width: double.infinity,
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
                  fontSize: 16.0,
                  color: Colors.black),
            ),
            Text(
              "To",
              style: TextStyle(
                  fontFamily: 'roboto',
                  fontWeight: FontWeight.w700,
                  fontSize: 16.0,
                  color: Colors.black),
            )
          ]),
          SizedBox(
            height: 5,
          ),
          Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
            //from date value from api
            Text(
              fromDate,
              style: TextStyle(
                  fontFamily: 'roboto',
                  fontWeight: FontWeight.w400,
                  fontSize: 16.0,
                  color: Colors.black),
            ),
            //to date value from api
            Text(
              toDate,
              style: TextStyle(
                  fontFamily: 'roboto',
                  fontWeight: FontWeight.w400,
                  fontSize: 16.0,
                  color: Colors.black),
            )
          ]),
          SizedBox(
            height: 12,
          ),
          Align(
            alignment: Alignment.centerLeft,
            child: Text(
              "Destination",
              style: TextStyle(
                  fontFamily: 'roboto',
                  fontWeight: FontWeight.w700,
                  fontSize: 16.0,
                  color: Colors.black),
            ),
          ),
          SizedBox(
            height: 10,
          ),
          //destination value from api
          Align(
            alignment: Alignment.centerLeft,
            child: Text(
              destination,
              style: TextStyle(
                  fontFamily: 'roboto',
                  fontWeight: FontWeight.w300,
                  fontSize: 16.0,
                  color: Colors.black),
            ),
          )
        ],
      ),
    );
  }

  _snackBar(String msg) {
    var snackbar = SnackBar(content: Text(msg));
    ScaffoldMessenger.of(context).showSnackBar(snackbar);
  }
}

class AcceptedDoodle extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          SizedBox(
              height: 80,
              width: double.infinity,
              child: Image.asset(rollerSkate)),
          SizedBox(
            height: 10.0,
          ),
          Container(
            width: double.infinity,
            padding: EdgeInsets.symmetric(vertical: 13.0, horizontal: 5.0),
            decoration: BoxDecoration(
                color: Colors.light_saffron,
                borderRadius: BorderRadius.circular(10.0)),
            child: Column(
              children: [
                Text(
                  "Hurray!",
                  style: TextStyle(
                      fontFamily: 'roboto',
                      fontWeight: FontWeight.w700,
                      fontSize: 16.0,
                      color: Colors.black),
                ),
                SizedBox(height: 5.0),
                Text(
                  "Your Request Has Been Accepted",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontFamily: 'roboto',
                      fontWeight: FontWeight.w300,
                      fontSize: 16.0,
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

class ProcessDoodle extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          SizedBox(
              height: 80,
              width: double.infinity,
              child: Image.asset(layingDoodle)),
          SizedBox(
            height: 10.0,
          ),
          Container(
            width: double.infinity,
            padding: EdgeInsets.symmetric(vertical: 13.0, horizontal: 5.0),
            decoration: BoxDecoration(
                color: Colors.gray, borderRadius: BorderRadius.circular(10.0)),
            child: Column(
              children: [
                Text(
                  "In Process!",
                  style: TextStyle(
                      fontFamily: 'roboto',
                      fontWeight: FontWeight.w700,
                      fontSize: 16.0,
                      color: Colors.black),
                ),
                SizedBox(height: 5.0),
                Text(
                  "We'll be back to you soon",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontFamily: 'roboto',
                      fontWeight: FontWeight.w300,
                      fontSize: 16.0,
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

class DeclinedDoodle extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          SizedBox(
              height: 80,
              width: double.infinity,
              child: Image.asset(messyDoodle)),
          SizedBox(
            height: 10.0,
          ),
          Container(
            width: double.infinity,
            padding: EdgeInsets.symmetric(vertical: 13.0, horizontal: 5.0),
            decoration: BoxDecoration(
                color: Colors.red, borderRadius: BorderRadius.circular(10.0)),
            child: Column(
              children: [
                Text(
                  "Oops!",
                  style: TextStyle(
                      fontFamily: 'roboto',
                      fontWeight: FontWeight.w700,
                      fontSize: 16.0,
                      color: Colors.white),
                ),
                SizedBox(height: 5.0),
                Text(
                  "Your request was not accepted",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontFamily: 'roboto',
                      fontWeight: FontWeight.w300,
                      fontSize: 16.0,
                      color: Colors.white),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
