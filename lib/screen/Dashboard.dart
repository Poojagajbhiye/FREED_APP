import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart' hide Colors;
import 'package:flutter/rendering.dart';
import 'package:freed/model/RecordListModel.dart';
import 'package:freed/screen/ExpendedRecords.dart';
import 'package:freed/screen/RequestForm.dart';
import 'package:freed/screen/ViewRequest.dart';
import 'package:freed/services/ApiClient.dart';
import 'package:freed/storage/TempStorage.dart';
import 'package:freed/utils/DioExceptions.dart';
import 'package:freed/value/Colors.dart';
import 'package:freed/value/Image.dart';
import 'package:freed/value/SizeConfig.dart';
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
      body: Container(
        width: SizeConfig.screenWidth,
        height: SizeConfig.screenHeight,
        decoration: BoxDecoration(color: Colors.yellow),
        child: Stack(
          children: [
            Column(
              children: [
                AppBar(
                  backgroundColor: Colors.yellow,
                  automaticallyImplyLeading: false,
                  shadowColor: Colors.transparent,
                  actions: [
                    Padding(
                      padding: const EdgeInsets.only(right: 16),
                      child: Icon(
                        Icons.notifications_none,
                        color: Colors.black,
                        size: 35,
                      ),
                    )
                  ],
                ),
                Container(
                  width: SizeConfig.screenWidth,
                  padding: EdgeInsets.symmetric(horizontal: 14.0),
                  child: Column(
                    children: [
                      Stack(
                        children: [
                          Container(
                            width: SizeConfig.blockSizeVertical! * 11,
                            height: SizeConfig.blockSizeVertical! * 11,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: Colors.white,
                            ),
                          ),
                          Positioned(
                            bottom: -10.0,
                            left: 0.0,
                            right: 0.0,
                            child: Container(
                              width: SizeConfig.blockSizeVertical! * 10,
                              height: SizeConfig.blockSizeVertical! * 10,
                              child: Image.asset(readingDoodle),
                            ),
                          )
                        ],
                      ),
                      SizedBox(height: 10),

                      //student full name
                      Text(
                        firstname.isNotEmpty || lastname.isNotEmpty
                            ? "$firstname $lastname"
                            : "Welcome Student",
                        style: TextStyle(
                            fontFamily: 'roboto',
                            fontWeight: FontWeight.w700,
                            fontSize: 20.0,
                            decoration: TextDecoration.none,
                            color: Colors.black),
                      ),
                      SizedBox(height: 5),

                      //course and branch
                      Text(
                        course.isNotEmpty || branch.isNotEmpty
                            ? "$course $branch"
                            : " ",
                        style: TextStyle(
                            fontFamily: 'roboto',
                            fontWeight: FontWeight.w400,
                            fontSize: 14.0,
                            decoration: TextDecoration.none,
                            color: Colors.black),
                      ),
                      SizedBox(height: 10),
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
                          padding: const EdgeInsets.symmetric(
                              vertical: 5.0, horizontal: 10.0),
                          child: Text(
                            "Request Leave",
                            style: TextStyle(
                                fontFamily: 'roboto',
                                fontWeight: FontWeight.w700,
                                fontSize: 18.0,
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
              top: top,
              child: GestureDetector(
                onVerticalDragUpdate: (details) {
                  setState(() {
                    if (details.globalPosition.dy <
                        SizeConfig.blockSizeVertical! * 40) {
                      top = details.globalPosition.dy;
                      print(top);
                      if (top < 300) {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => ExpendedRecords(sid: _sid),
                            )).then((value) {
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
                    width: SizeConfig.screenWidth,
                    height: SizeConfig.dragViewSize(),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(45),
                          topRight: Radius.circular(45)),
                    ),
                    child: draggableSheetInnerContent(),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget draggableSheetInnerContent() {
    return Column(
      children: [
        Container(
          width: double.infinity,
          height: SizeConfig.blockSizeVertical! * 4.5,
          child: Opacity(
            opacity: 0.1,
            child: Icon(
              Icons.drag_handle,
              size: 25.0,
              color: Colors.black,
            ),
          ),
        ),
        Padding(
          padding: EdgeInsets.only(bottom: 15.0, top: 5.0),
          child: Text(
            "Escape Records",
            style: TextStyle(
                fontFamily: 'roboto',
                fontWeight: FontWeight.w700,
                fontSize: 20.0,
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
                            fontSize: 14.0,
                            fontWeight: FontWeight.w400,
                            decoration: TextDecoration.none,
                            color: Colors.default_color),
                      ),
                    )
                  : ListView.builder(
                      itemCount: recordList == null ? 0 : recordList?.length,
                      padding: EdgeInsets.only(
                          left: 20.0, right: 20.0, top: 5.0, bottom: 10.0),
                      itemBuilder: (context, index) {
                        Record record = recordList![index];
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
                                color: Colors.gray,
                                borderRadius: BorderRadius.circular(10.0)),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
          setState(() {
            _isLoading = false;
            recordList = list;
          });
        }
      }
    } catch (e) {
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
              EdgeInsets.only(left: 20.0, right: 20.0, top: 5.0, bottom: 10.0),
          itemCount: 6,
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
      enabled: _isLoading,
    );
  }

  _getStudentData() async {
    firstname = await TempStorage.getFirstName();

    lastname = await TempStorage.getLastName();

    course = await TempStorage.getCourse();

    branch = await TempStorage.getBranch();
  }
}
