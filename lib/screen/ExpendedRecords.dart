import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart' hide Colors;
import 'package:flutter/painting.dart';
import 'package:freed/model/RecordListModel.dart';
import 'package:freed/screen/ViewRequest.dart';
import 'package:freed/services/ApiClient.dart';
import 'package:freed/utils/DioExceptions.dart';
import 'package:freed/value/Colors.dart';
import 'package:intl/intl.dart';
import 'package:shimmer/shimmer.dart';

class ExpendedRecords extends StatefulWidget {
  final sid;

  ExpendedRecords({Key? key, @required this.sid}) : super(key: key);
  @override
  State<StatefulWidget> createState() {
    return _ExpendedRecords(sid);
  }
}

class _ExpendedRecords extends State<ExpendedRecords> {
  List<Record>? recordList;
  List<Record>? filteredRecordList;
  String? sid;
  bool isLoading = true;

  //filter buttons
  bool clickAccept = true;
  bool clickDecline = false;
  bool clickProcess = false;

  _ExpendedRecords(this.sid);

  @override
  void initState() {
    this._getRecordList();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Hero(
        tag: 'expend',
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
            Container(
                padding: EdgeInsets.only(right: 16.0, left: 16.0, bottom: 16.0),
                decoration: BoxDecoration(color: Colors.white),
                child: Column(
                  children: [
                    Text(
                      "Escape Records",
                      style: TextStyle(
                          fontFamily: 'roboto',
                          fontWeight: FontWeight.w700,
                          color: Colors.black,
                          decoration: TextDecoration.none,
                          fontSize: 20.0),
                    ),
                    SizedBox(height: 15.0),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        GestureDetector(
                          onTap: () {
                            setState(() {
                              clickAccept = true;
                              clickDecline = false;
                              clickProcess = false;

                              _filtered("ACCEPTED");
                            });
                          },
                          child: Container(
                            width: 90.0,
                            height: 30.0,
                            decoration: BoxDecoration(
                                border: Border.all(color: Colors.black),
                                borderRadius: BorderRadius.circular(50.0),
                                color:
                                    clickAccept ? Colors.black : Colors.white),
                            child: Center(
                              child: Text(
                                "Accepted",
                                style: TextStyle(
                                    decoration: TextDecoration.none,
                                    fontFamily: 'roboto',
                                    fontWeight: FontWeight.w400,
                                    fontSize: 14.0,
                                    color: clickAccept
                                        ? Colors.white
                                        : Colors.black),
                              ),
                            ),
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            setState(() {
                              clickAccept = false;
                              clickDecline = true;
                              clickProcess = false;

                              _filtered("DECLINED");
                            });
                          },
                          child: Container(
                            width: 90.0,
                            height: 30.0,
                            decoration: BoxDecoration(
                                border: Border.all(color: Colors.black),
                                borderRadius: BorderRadius.circular(50.0),
                                color:
                                    clickDecline ? Colors.black : Colors.white),
                            child: Center(
                              child: Text(
                                "Declined",
                                style: TextStyle(
                                    decoration: TextDecoration.none,
                                    fontFamily: 'roboto',
                                    fontWeight: FontWeight.w400,
                                    fontSize: 14.0,
                                    color: clickDecline
                                        ? Colors.white
                                        : Colors.black),
                              ),
                            ),
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            setState(() {
                              clickAccept = false;
                              clickDecline = false;
                              clickProcess = true;

                              _filtered("PROCESS");
                            });
                          },
                          child: Container(
                            width: 90.0,
                            height: 30.0,
                            decoration: BoxDecoration(
                                border: Border.all(color: Colors.black),
                                borderRadius: BorderRadius.circular(50.0),
                                color:
                                    clickProcess ? Colors.black : Colors.white),
                            child: Center(
                              child: Text(
                                "Process",
                                style: TextStyle(
                                    decoration: TextDecoration.none,
                                    fontFamily: 'roboto',
                                    fontWeight: FontWeight.w400,
                                    fontSize: 14.0,
                                    color: clickProcess
                                        ? Colors.white
                                        : Colors.black),
                              ),
                            ),
                          ),
                        ),
                      ],
                    )
                  ],
                )),
            Expanded(
                child: Container(
              decoration: BoxDecoration(color: Colors.white),
              child: isLoading
                  ? _loadingEffect()
                  : filteredRecordList == null ||
                          filteredRecordList?.length == 0
                      ? Center(
                          child: Text(
                            "No Records Found",
                            style: TextStyle(
                                decoration: TextDecoration.none,
                                fontFamily: 'roboto',
                                fontWeight: FontWeight.w400,
                                fontSize: 16.0,
                                color: Colors.default_color),
                          ),
                        )
                      : ListView.builder(
                          itemCount: filteredRecordList?.length,
                          padding: EdgeInsets.only(left: 20.0, right: 20.0),
                          itemBuilder: (context, index) {
                            Record record = filteredRecordList![index];
                            DateTime? date = record.from;
                            String formatedDate =
                                DateFormat("dd MMM yyyy").format(date!);
                            String? _recordId = record.id;
                            return Card(
                              elevation: 0.0,
                              child: Container(
                                height: 65.0,
                                width: double.infinity,
                                padding: EdgeInsets.symmetric(horizontal: 25.0),
                                decoration: BoxDecoration(
                                    color: _cardColorPicker(),
                                    borderRadius: BorderRadius.circular(10.0)),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      formatedDate,
                                      style: TextStyle(
                                          fontSize: 14.0,
                                          fontFamily: 'roboto',
                                          fontWeight: FontWeight.w300,
                                          color: Colors.black),
                                    ),
                                    TextButton(
                                        onPressed: () {
                                          Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (BuildContext
                                                          context) =>
                                                      ViewRequest(
                                                          recordId:
                                                              _recordId))).then(
                                              (value) => _getRecordList());
                                        },
                                        child: Text(
                                          "View",
                                          style: TextStyle(
                                              fontFamily: 'roboto',
                                              fontSize: 14.0,
                                              fontWeight: FontWeight.w500,
                                              color: Colors.black),
                                        ))
                                  ],
                                ),
                              ),
                            );
                          },
                        ),
            ))
          ],
        ),
      ),
    );
  }

  Color _cardColorPicker() {
    if (clickAccept) {
      return Colors.blue_50;
    } else if (clickDecline) {
      return Colors.red_50;
    } else {
      return Colors.gray;
    }
  }

  _filtered(String status) {
    filteredRecordList?.clear();
    if (recordList != null) {
      filteredRecordList = recordList!
          .where((record) => (record.status!.contains(status.toUpperCase())))
          .toList();
    }
  }

  _getRecordList() async {
    try {
      var response = await ApiClient.getServices().getStudentRecords(sid!);

      if (response.isNotEmpty) {
        RecordListModel recordListModel = recordListModelFromJson(response);
        bool? isSuccess = recordListModel.success;
        List<Record>? list = recordListModel.records;

        if (isSuccess!) {
          setState(() {
            isLoading = false;
            recordList = list;

            if (clickAccept)
              _filtered("ACCEPTED");
            else if (clickDecline)
              _filtered("DECLINED");
            else
              _filtered("PROCESS");
          });
        }
      }
    } catch (e) {
      setState(() {
        isLoading = false;
      });
      var err = e as DioError;
      recordList?.clear();
      filteredRecordList?.clear();

      var error = DioExceptions.fromDioError(err).toString();
      print(error);
    }
  }

  Widget _loadingEffect() {
    return Shimmer.fromColors(
      child: ListView.builder(
          padding: EdgeInsets.symmetric(horizontal: 25.0),
          itemCount: 8,
          itemBuilder: (context, index) {
            return Card(
              elevation: 0.0,
              child: Container(
                height: 65.0,
                width: double.infinity,
                padding: EdgeInsets.symmetric(horizontal: 25.0),
              ),
            );
          }),
      baseColor: Colors.gray,
      highlightColor: Color(0xFFD0D0D0),
      enabled: isLoading,
    );
  }
}
