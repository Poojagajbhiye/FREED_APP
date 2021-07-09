import 'package:dio/dio.dart';
import 'package:flutter/material.dart' hide Colors;
import 'package:freed/model/RecordListModel.dart';
import 'package:freed/model/RecordModel.dart';
import 'package:freed/services/ApiClient.dart';
import 'package:freed/utils/DioExceptions.dart';
import 'package:freed/value/Colors.dart';
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
              leading: Padding(
                padding: EdgeInsets.only(left: 15.0),
                child: TextButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: Text(
                      "Back",
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 14.0,
                          fontFamily: 'roboto',
                          fontWeight: FontWeight.w700),
                    )),
              ),
            ),
            Expanded(
                child: Container(
              padding: EdgeInsets.only(left: 30, right: 30, top: 15),
              color: Colors.white,
              height: double.infinity,
              width: double.infinity,
              child: isprocess
                  ? Center(
                      child: CircularProgressIndicator(
                        color: Colors.black,
                      ),
                    )
                  : Column(
                      children: [
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

  _fatchRecordDetails(String recordId) async {
    try {
      var response =
          await ApiClient.getServices().getParticulerRecord(recordId);

      if (response.isNotEmpty) {
        RecordModel recordListModel = recordModelFromJson(response);
        bool? isSuccess = recordListModel.success;
        DateTime? _fromdate = recordListModel.record![0].from;
        DateTime? _todate = recordListModel.record![0].to;

        if (isSuccess!) {
          setState(() {
            isprocess = false;
            if (recordListModel.record != null) {
              rid = recordListModel.record![0].rid!;
              fromDate = DateFormat('dd MMM yyyy').format(_fromdate!);
              toDate = DateFormat('dd MMM yyyy').format(_todate!);
              destination = recordListModel.record![0].destination!;
              reason = recordListModel.record![0].reason!;
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
      margin: EdgeInsets.symmetric(horizontal: 35),
      child: ElevatedButton(
        onPressed: () {},
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 10),
          child: Text(
            "Cancel Request",
            style: TextStyle(
                fontFamily: 'roboto',
                fontWeight: FontWeight.w400,
                fontSize: 18.0,
                color: Colors.default_color),
          ),
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
              Text(
                reason,
                style: TextStyle(
                    fontFamily: 'roboto',
                    fontWeight: FontWeight.w300,
                    fontSize: 16.0,
                    color: Colors.default_color),
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
}
