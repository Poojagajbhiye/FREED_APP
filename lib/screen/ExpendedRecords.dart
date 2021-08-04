import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart' hide Colors;
import 'package:flutter/painting.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
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
  bool clickProcess = true;
  bool clickAccept = false;
  bool clickDecline = false;

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
            Container(
                padding: EdgeInsets.only(right: 16.w, left: 16.w, bottom: 16.h),
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
                          fontSize: 20.sp),
                    ),
                    SizedBox(height: 25.h),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        GestureDetector(
                          onTap: () {
                            if (mounted)
                              setState(() {
                                clickAccept = false;
                                clickDecline = false;
                                clickProcess = true;

                                _filtered("PROCESS");
                              });
                          },
                          child: Container(
                            width: 90.w,
                            height: 30.w,
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
                                    fontSize: 14.sp,
                                    color: clickProcess
                                        ? Colors.white
                                        : Colors.black),
                              ),
                            ),
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            if (mounted)
                              setState(() {
                                clickAccept = true;
                                clickDecline = false;
                                clickProcess = false;

                                _filtered("ACCEPTED");
                              });
                          },
                          child: Container(
                            width: 90.w,
                            height: 30.w,
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
                                    fontSize: 14.sp,
                                    color: clickAccept
                                        ? Colors.white
                                        : Colors.black),
                              ),
                            ),
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            if (mounted)
                              setState(() {
                                clickAccept = false;
                                clickDecline = true;
                                clickProcess = false;

                                _filtered("DECLINED");
                              });
                          },
                          child: Container(
                            width: 90.w,
                            height: 30.w,
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
                                    fontSize: 14.sp,
                                    color: clickDecline
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
              child: RefreshIndicator(
                onRefresh: _getRecordList,
                child: isLoading
                    ? _loadingEffect()
                    : filteredRecordList == null ||
                            filteredRecordList?.length == 0
                        ? ListView(
                            padding: EdgeInsets.only(top: 250.h),
                            children: [
                              Text(
                                "No Records Found",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    decoration: TextDecoration.none,
                                    fontFamily: 'roboto',
                                    fontWeight: FontWeight.w400,
                                    fontSize: 16.sp,
                                    color: Colors.default_color),
                              ),
                            ],
                          )
                        : ListView.builder(
                            itemCount: filteredRecordList?.length,
                            padding: EdgeInsets.only(
                                left: 20.w,
                                right: 20.w,
                                top: 10.h,
                                bottom: 10.h),
                            itemBuilder: (context, index) {
                              Record record = filteredRecordList![index];
                              DateTime? date = record.from;
                              String formatedDate =
                                  DateFormat("dd MMM yyyy").format(date!);
                              String? _recordId = record.id;
                              return Card(
                                elevation: 0.0,
                                child: Container(
                                  height: 65.h,
                                  width: 1.sw,
                                  padding:
                                      EdgeInsets.symmetric(horizontal: 25.w),
                                  decoration: BoxDecoration(
                                      color: _cardColorPicker(),
                                      borderRadius:
                                          BorderRadius.circular(10.0)),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Row(children: [
                                        Opacity(
                                          opacity: 0.7,
                                          child: Icon(
                                            _cardIconPicker(),
                                            size: 20.r,
                                            color: Colors.black,
                                          ),
                                        ),
                                        SizedBox(width: 10.w),
                                        Text(
                                          formatedDate,
                                          style: TextStyle(
                                              fontSize: 14.sp,
                                              fontFamily: 'roboto',
                                              fontWeight: FontWeight.w300,
                                              color: Colors.black),
                                        ),
                                      ]),
                                      TextButton(
                                          onPressed: () {
                                            Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                        builder: (BuildContext
                                                                context) =>
                                                            ViewRequest(
                                                                recordId:
                                                                    _recordId)))
                                                .then((value) =>
                                                    _getRecordList());
                                          },
                                          child: Text(
                                            "View",
                                            style: TextStyle(
                                                fontFamily: 'roboto',
                                                fontSize: 14.sp,
                                                fontWeight: FontWeight.w500,
                                                color: Colors.black),
                                          ))
                                    ],
                                  ),
                                ),
                              );
                            },
                          ),
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

  IconData _cardIconPicker() {
    if (clickAccept) {
      return Icons.check_circle_outline;
    } else if (clickDecline) {
      return Icons.highlight_off_outlined;
    } else {
      return Icons.timer_outlined;
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

  Future<dynamic> _getRecordList() async {
    try {
      var response = await ApiClient.getServices().getStudentRecords(sid!);

      if (response.isNotEmpty) {
        RecordListModel recordListModel = recordListModelFromJson(response);
        bool? isSuccess = recordListModel.success;
        List<Record>? list = recordListModel.records;

        if (isSuccess!) {
          if (mounted)
            setState(() {
              isLoading = false;
              recordList = list?.reversed.toList();

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
      if (mounted)
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
          padding: EdgeInsets.symmetric(horizontal: 25.w),
          itemCount: 8,
          itemBuilder: (context, index) {
            return Card(
              elevation: 0.0,
              child: Container(
                height: 65.h,
                width: 1.sw,
                padding: EdgeInsets.symmetric(horizontal: 25.w),
              ),
            );
          }),
      baseColor: Colors.gray,
      highlightColor: Color(0xFFD0D0D0),
      enabled: isLoading,
    );
  }
}
