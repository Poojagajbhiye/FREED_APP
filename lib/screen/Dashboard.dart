import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart' hide Colors;
import 'package:flutter/rendering.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:freed/model/RecordListModel.dart';
import 'package:freed/screen/ExpendedRecords.dart';
import 'package:freed/screen/QrCode.dart';
import 'package:freed/screen/RequestForm.dart';
import 'package:freed/screen/ViewRequest.dart';
import 'package:freed/services/ApiClient.dart';
import 'package:freed/storage/TempStorage.dart';
import 'package:freed/utils/DioExceptions.dart';
import 'package:freed/value/Colors.dart';
import 'package:freed/value/Image.dart';
import 'package:intl/intl.dart';
import 'package:shimmer/shimmer.dart';

class Dashboard extends StatefulWidget {
  final sid;
  Dashboard({Key? key, @required this.sid}) : super(key: key);
  @override
  State<StatefulWidget> createState() {
    return _Dashboard(sid);
  }
}

class _Dashboard extends State<Dashboard> {
  var top;
  List<Record>? recordList;
  String? _sid;
  bool _isLoading = true;

  //student info
  String registerId = "";
  String firstname = "";
  String lastname = "";
  String course = "";
  String branch = "";

  _Dashboard(this._sid);

  @override
  void initState() {
    super.initState();

    //get student information from temp storage
    this._getStudentData();

    //fatch student records from api
    this._getRecordList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.yellow,
      body: Stack(
        children: [
          Column(
            children: [
              AppBar(
                backgroundColor: Colors.yellow,
                automaticallyImplyLeading: false,
                shadowColor: Colors.transparent,
                actions: [
                  Padding(
                    padding: EdgeInsets.only(right: 10.w),
                    child: IconButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => QrCode(
                              _sid,
                              rid: registerId,
                              firstname: firstname,
                              lastname: lastname,
                            ),
                          ),
                        );
                      },
                      icon: Icon(Icons.qr_code_2_outlined),
                      color: Colors.black,
                      iconSize: 30.r,
                    ),
                  )
                ],
              ),
              Container(
                width: 1.sw,
                padding: EdgeInsets.symmetric(horizontal: 14.w),
                child: Column(
                  children: [
                    Stack(
                      children: [
                        Container(
                          width: 80.r,
                          height: 80.r,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: Colors.white,
                          ),
                        ),
                        Positioned(
                          bottom: -10.h,
                          left: 0.0,
                          right: 0.0,
                          child: Container(
                            width: 75.r,
                            height: 75.r,
                            child: Image.asset(readingDoodle),
                          ),
                        )
                      ],
                    ),
                    SizedBox(height: 10.h),

                    //student full name
                    Text(
                      firstname.isNotEmpty || lastname.isNotEmpty
                          ? "$firstname $lastname"
                          : "Welcome Student",
                      style: TextStyle(
                          fontFamily: 'roboto',
                          fontWeight: FontWeight.w700,
                          fontSize: 20.sp,
                          decoration: TextDecoration.none,
                          color: Colors.black),
                    ),
                    SizedBox(height: 5.h),

                    //course and branch
                    course.isNotEmpty || branch.isNotEmpty
                        ? Text(
                            "$course $branch",
                            style: TextStyle(
                                fontFamily: 'roboto',
                                fontWeight: FontWeight.w400,
                                fontSize: 14.sp,
                                decoration: TextDecoration.none,
                                color: Colors.black),
                          )
                        : SizedBox(),
                    SizedBox(height: 10.h),
                    ElevatedButton(
                      onPressed: () {
                        // Navigator.pushNamed(context, '/request form');
                        Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => RequestForm()))
                            .then((value) => _getRecordList());
                      },
                      child: Padding(
                        padding: EdgeInsets.symmetric(
                            vertical: 5.r, horizontal: 10.r),
                        child: Text(
                          "Request Leave",
                          style: TextStyle(
                              fontFamily: 'roboto',
                              fontWeight: FontWeight.w700,
                              fontSize: 18.sp,
                              color: Colors.white),
                        ),
                      ),
                      style: ButtonStyle(
                          shape: MaterialStateProperty.all(
                              RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(30.0))),
                          backgroundColor:
                              MaterialStateProperty.all(Colors.black)),
                    )
                  ],
                ),
              )
            ],
          ),
          Positioned(
            bottom: 0.0,
            top: top == null ? 1.sh - 470.h : top,
            child: GestureDetector(
              onVerticalDragUpdate: (details) {
                setState(() {
                  if (details.globalPosition.dy < 312.h) {
                    top = details.globalPosition.dy.h;
                    print(top);
                    if (top < 300.h) {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => ExpendedRecords(sid: _sid),
                          )).then((value) {
                        if (mounted)
                          setState(() {
                            top = null;
                          });
                        _getRecordList();
                      });
                    }
                  }
                });
              },
              child: Hero(
                tag: 'expend',
                child: Container(
                  width: 1.sw,
                  // height: 1.sh - 360.h, //414.h
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(45.r),
                        topRight: Radius.circular(45.r)),
                  ),
                  child: draggableSheetInnerContent(),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget draggableSheetInnerContent() {
    return Column(
      children: [
        Container(
          width: 1.sw,
          height: 35.h,
          child: Opacity(
            opacity: 0.1,
            child: Icon(
              Icons.drag_handle,
              size: 25.r,
              color: Colors.black,
            ),
          ),
        ),
        Padding(
          padding: EdgeInsets.only(bottom: 15.h, top: 5.h),
          child: Text(
            "Escape Records",
            style: TextStyle(
                fontFamily: 'roboto',
                fontWeight: FontWeight.w700,
                fontSize: 20.sp,
                decoration: TextDecoration.none,
                color: Colors.black),
          ),
        ),
        Expanded(
          child: _isLoading
              ? _loadingEffect()
              : recordList == null || recordList?.length == 0
                  ? Center(
                      child: Text(
                        "No Records Found",
                        style: TextStyle(
                            fontFamily: 'roboto',
                            fontSize: 14.sp,
                            fontWeight: FontWeight.w400,
                            decoration: TextDecoration.none,
                            color: Colors.default_color),
                      ),
                    )
                  : ListView.builder(
                      shrinkWrap: true,
                      itemCount: recordList == null ? 0 : recordList?.length,
                      padding: EdgeInsets.only(
                          left: 20.w, right: 20.w, top: 5.h, bottom: 10.h),
                      itemBuilder: (context, index) {
                        Record record = recordList![index];
                        DateTime? date = record.from;
                        String formatedDate =
                            DateFormat("dd MMM yyyy").format(date!);
                        String? _recordId = record.id;
                        return Card(
                          elevation: 0.0,
                          child: Container(
                            height: 65.h,
                            width: 0.sw,
                            padding: EdgeInsets.symmetric(horizontal: 25.w),
                            decoration: BoxDecoration(
                                color: Colors.gray,
                                borderRadius: BorderRadius.circular(10.0)),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(children: [
                                  Opacity(
                                    opacity: 0.7,
                                    child: Icon(
                                      Icons.timer_outlined,
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
                                                  builder:
                                                      (BuildContext context) =>
                                                          ViewRequest(
                                                              recordId:
                                                                  _recordId)))
                                          .then((value) => _getRecordList());
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
      ],
    );
  }

  _getRecordList() async {
    try {
      var response = await ApiClient.getServices().getStudentRecords(_sid!);

      if (response.isNotEmpty) {
        RecordListModel recordListModel = recordListModelFromJson(response);
        bool? isSuccess = recordListModel.success;
        List<Record>? list = recordListModel.records;

        if (isSuccess!) {
          if (mounted)
            setState(() {
              _isLoading = false;
              if (list != null) {
                recordList = list.reversed
                    .where(
                        (record) => (record.status == "PROCESS".toUpperCase()))
                    .toList();
              }
            });
        }
      }
    } catch (e) {
      if (mounted)
        setState(() {
          _isLoading = false;
        });
      recordList?.clear();

      var err = e as DioError;
      var error = DioExceptions.fromDioError(err).toString();
      print(error);
    }
  }

  Widget _loadingEffect() {
    return Shimmer.fromColors(
      child: ListView.builder(
          padding:
              EdgeInsets.only(left: 20.w, right: 20.w, top: 5.h, bottom: 10.h),
          itemCount: 6,
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
      enabled: _isLoading,
    );
  }

  _getStudentData() async {
    firstname = await TempStorage.getFirstName();

    lastname = await TempStorage.getLastName();

    course = await TempStorage.getCourse();

    branch = await TempStorage.getBranch();

    registerId = await TempStorage.getRid();
  }
}
