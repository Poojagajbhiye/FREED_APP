import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart' hide Colors;
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:freed/screen/SignIn/SignIn.dart';
import 'package:freed/services/ApiClient.dart';
import 'package:freed/services/SocketServer.dart';
import 'package:freed/storage/TempStorage.dart';
import 'package:freed/utils/DioExceptions.dart';
import 'package:freed/utils/Colors.dart';

class StudentProfile extends StatefulWidget {
  final isLogoutVisible;
  StudentProfile({Key? key, @required this.isLogoutVisible}) : super(key: key);
  @override
  State<StatefulWidget> createState() {
    return _StudentProfile(isLogoutVisible);
  }
}

class _StudentProfile extends State<StudentProfile> {
  bool? isLogoutVisible;
  _StudentProfile(this.isLogoutVisible);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.yellow,
      body: Column(
        children: [
          AppBar(
            backgroundColor: Colors.yellow,
            automaticallyImplyLeading: false,
            shadowColor: Colors.transparent,
            actions: [
              isLogoutVisible!
                  ? Padding(
                      padding: EdgeInsets.only(right: 8.w),
                      child: TextButton(
                          onPressed: () {
                            TempStorage.removePreferences();
                            SocketServer.socketConnectionClose();
                            Navigator.pushAndRemoveUntil(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => SignIn()),
                                (route) => false);
                          },
                          child: Row(children: [
                            Text(
                              "Logout",
                              style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 14.sp,
                                  fontFamily: 'roboto',
                                  fontWeight: FontWeight.w700),
                            ),
                            SizedBox(width: 5.w),
                            Icon(
                              Icons.logout,
                              color: Colors.black,
                              size: 17.r,
                            )
                          ])),
                    )
                  : SizedBox()
            ],
            leading: !isLogoutVisible!
                ? IconButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    icon: Icon(
                      Icons.chevron_left,
                      size: 30,
                      color: Colors.black,
                    ),
                  )
                : SizedBox(),
          ),
          SizedBox(height: 20.h),
          Expanded(
              child: Container(
            width: 1.sw,
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(45.r),
                    topRight: Radius.circular(45.r))),
            child: ProfileForm(isLogoutVisible: isLogoutVisible),
          ))
        ],
      ),
    );
  }
}

class ProfileForm extends StatefulWidget {
  final isLogoutVisible;
  ProfileForm({Key? key, @required this.isLogoutVisible}) : super(key: key);
  @override
  State<StatefulWidget> createState() {
    return _ProfileForm(isLogoutVisible);
  }
}

class _ProfileForm extends State<ProfileForm> {
  bool? isLogoutVisible;

  _ProfileForm(this.isLogoutVisible);

  var defCourse;
  var defSemester;
  var defBranch;
  var defGender;

  final profileKey = GlobalKey<FormState>();

  //student information variables
  String sid = "";
  String firstname = "";
  String lastname = "";
  String email = "";
  String personal_phoneNo = "";
  String parents_phoneNo = "";
  String roomNo = "";

  //dropdown lists
  var courseList = ["Diploma", "M.tech", "B.tech"];
  var semesterList = ["1", "2", "3", "4", "5", "6", "7", "8"];
  var branchList = ["CIVIL", "CSE", "EEE", "MECH", "META"];
  var genderList = ["Male", "Female"];

  bool isProgress = false;

  @override
  void initState() {
    _getStudentData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: profileKey,
      child: Column(
        children: [
          Padding(
            padding: EdgeInsets.only(
                left: 16.w, right: 16.w, bottom: 10.h, top: 30.h),
            child: Text(
              "Profile",
              style: TextStyle(
                  fontFamily: 'roboto',
                  fontSize: 20.sp,
                  fontWeight: FontWeight.w700,
                  color: Colors.black,
                  decoration: TextDecoration.none),
            ),
          ),
          Expanded(
            child: ListView(
              padding: EdgeInsets.only(
                  top: 10.h, left: 25.w, right: 25.w, bottom: 50.h),
              children: [
                //first name field
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: EdgeInsets.only(left: 7.w, bottom: 5.h),
                      child: Text(
                        "First Name",
                        style: TextStyle(
                            fontFamily: 'roboto',
                            fontWeight: FontWeight.w400,
                            fontSize: 16.sp,
                            color: Colors.default_color),
                      ),
                    ),
                    TextFormField(
                      style: TextStyle(fontSize: 16.sp, color: Colors.black),
                      keyboardType: TextInputType.text,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return "*required";
                        }
                        return null;
                      },
                      controller: TextEditingController(text: firstname),
                      onChanged: (value) {
                        firstname = value;
                      },
                      decoration: InputDecoration(
                        hintText: "eg- Andy",
                        isDense: true,
                        filled: true,
                        fillColor: Colors.gray,
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(7.0),
                            borderSide: BorderSide(
                                width: 0.0, style: BorderStyle.none)),
                        contentPadding: EdgeInsets.symmetric(
                            horizontal: 15.w, vertical: 20.h),
                      ),
                    )
                  ],
                ),

                SizedBox(height: 20.h),

                //last name field
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: EdgeInsets.only(left: 7.w, bottom: 5.h),
                      child: Text(
                        "Last Name",
                        style: TextStyle(
                            fontFamily: 'roboto',
                            fontWeight: FontWeight.w400,
                            fontSize: 16.sp,
                            color: Colors.default_color),
                      ),
                    ),
                    TextFormField(
                      style: TextStyle(fontSize: 16.sp, color: Colors.black),
                      keyboardType: TextInputType.text,
                      controller: TextEditingController(text: lastname),
                      onChanged: (value) {
                        lastname = value;
                      },
                      decoration: InputDecoration(
                        hintText: "eg- Rubin",
                        isDense: true,
                        filled: true,
                        fillColor: Colors.gray,
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(7.0),
                            borderSide: BorderSide(
                                width: 0.0, style: BorderStyle.none)),
                        contentPadding: EdgeInsets.symmetric(
                            horizontal: 15.w, vertical: 20.h),
                      ),
                    )
                  ],
                ),

                SizedBox(height: 20.h),

                //email field
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: EdgeInsets.only(left: 7.w, bottom: 5.h),
                      child: Text(
                        "Email",
                        style: TextStyle(
                            fontFamily: 'roboto',
                            fontWeight: FontWeight.w400,
                            fontSize: 16.sp,
                            color: Colors.default_color),
                      ),
                    ),
                    TextFormField(
                      style: TextStyle(fontSize: 16.sp, color: Colors.black),
                      keyboardType: TextInputType.emailAddress,
                      controller: TextEditingController(text: email),
                      onChanged: (value) {
                        email = value;
                      },
                      validator: (value) {
                        if (value!.isEmpty) {
                          return "*required";
                        } else if (!value.contains("@")) {
                          return "Enter valid email";
                        }
                        return null;
                      },
                      decoration: InputDecoration(
                        hintText: "eg- abc@gmail.com",
                        isDense: true,
                        filled: true,
                        fillColor: Colors.gray,
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(7.0),
                            borderSide: BorderSide(
                                width: 0.0, style: BorderStyle.none)),
                        contentPadding: EdgeInsets.symmetric(
                            horizontal: 15.w, vertical: 20.h),
                      ),
                    )
                  ],
                ),

                SizedBox(height: 20.h),

                //personal contact field
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: EdgeInsets.only(left: 7.w, bottom: 5.h),
                      child: Text(
                        "Personal Contact",
                        style: TextStyle(
                            fontFamily: 'roboto',
                            fontWeight: FontWeight.w400,
                            fontSize: 16.sp,
                            color: Colors.default_color),
                      ),
                    ),
                    TextFormField(
                      style: TextStyle(fontSize: 16.sp, color: Colors.black),
                      keyboardType: TextInputType.phone,
                      controller: TextEditingController(text: personal_phoneNo),
                      onChanged: (value) {
                        personal_phoneNo = value;
                      },
                      maxLength: 10,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return "*required";
                        } else if (value.length < 10 || value.length > 10) {
                          return "Enter valid phone number";
                        }
                        return null;
                      },
                      decoration: InputDecoration(
                        hintText: "1234567890",
                        isDense: true,
                        filled: true,
                        fillColor: Colors.gray,
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(7.0),
                            borderSide: BorderSide(
                                width: 0.0, style: BorderStyle.none)),
                        contentPadding: EdgeInsets.symmetric(
                            horizontal: 15.w, vertical: 20.h),
                      ),
                    )
                  ],
                ),

                SizedBox(height: 20.h),

                //parents contact field
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: EdgeInsets.only(left: 7.w, bottom: 5.h),
                      child: Text(
                        "Parents Contact",
                        style: TextStyle(
                            fontFamily: 'roboto',
                            fontWeight: FontWeight.w400,
                            fontSize: 16.sp,
                            color: Colors.default_color),
                      ),
                    ),
                    TextFormField(
                      style: TextStyle(fontSize: 16.sp, color: Colors.black),
                      keyboardType: TextInputType.phone,
                      controller: TextEditingController(text: parents_phoneNo),
                      onChanged: (value) {
                        parents_phoneNo = value;
                      },
                      validator: (value) {
                        if (value!.isEmpty) {
                          return "*required";
                        } else if (value.length < 10 || value.length > 10) {
                          return "Enter valid phone number";
                        } else if (personal_phoneNo == value) {
                          return "Parent and student contact can't be same";
                        }
                        return null;
                      },
                      maxLength: 10,
                      decoration: InputDecoration(
                        hintText: "1234567890",
                        isDense: true,
                        filled: true,
                        fillColor: Colors.gray,
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(7.0),
                            borderSide: BorderSide(
                                width: 0.0, style: BorderStyle.none)),
                        contentPadding: EdgeInsets.symmetric(
                            horizontal: 15.w, vertical: 20.h),
                      ),
                    )
                  ],
                ),

                SizedBox(height: 20.h),
                Row(
                  children: [
                    //room number
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: EdgeInsets.only(left: 7.w, bottom: 5.h),
                            child: Text(
                              "Room No",
                              style: TextStyle(
                                  fontFamily: 'roboto',
                                  fontWeight: FontWeight.w400,
                                  fontSize: 16.sp,
                                  color: Colors.default_color),
                            ),
                          ),
                          TextFormField(
                            style:
                                TextStyle(fontSize: 16.sp, color: Colors.black),
                            keyboardType: TextInputType.text,
                            controller: TextEditingController(text: roomNo),
                            onChanged: (value) {
                              roomNo = value;
                            },
                            validator: (value) {
                              if (value!.isEmpty) {
                                return "*required";
                              }
                              return null;
                            },
                            decoration: InputDecoration(
                              hintText: "A123",
                              isDense: true,
                              filled: true,
                              fillColor: Colors.gray,
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(7.0),
                                  borderSide: BorderSide(
                                      width: 0.0, style: BorderStyle.none)),
                              contentPadding: EdgeInsets.symmetric(
                                  horizontal: 15.w, vertical: 20.h),
                            ),
                          )
                        ],
                      ),
                    ),

                    SizedBox(width: 20.w),

                    //Gender
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: EdgeInsets.only(left: 7.w, bottom: 5.h),
                            child: Text(
                              "Gender",
                              style: TextStyle(
                                  fontFamily: 'roboto',
                                  fontWeight: FontWeight.w400,
                                  fontSize: 16.sp,
                                  color: Colors.default_color),
                            ),
                          ),
                          DropdownButtonFormField<String>(
                            isExpanded: true,
                            hint: Text(
                              "choose",
                              style: TextStyle(fontSize: 16.sp),
                            ),
                            validator: (value) {
                              if (value == null) {
                                return "*required";
                              }
                              return null;
                            },
                            style:
                                TextStyle(fontSize: 16.sp, color: Colors.black),
                            decoration: InputDecoration(
                                isDense: true,
                                fillColor: Colors.gray,
                                filled: true,
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(7.0),
                                    borderSide: BorderSide(
                                        width: 0.0, style: BorderStyle.none))),
                            items: genderList.map((String currentValue) {
                              return DropdownMenuItem(
                                child: Text(currentValue),
                                value: currentValue,
                              );
                            }).toList(),
                            value: defGender,
                            onChanged: (value) {
                              setState(() {
                                defGender = value;
                              });
                            },
                          )
                        ],
                      ),
                    ),
                  ],
                ),

                SizedBox(height: 20.h),

                //course and semester dropdown
                Row(
                  children: [
                    //course
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: EdgeInsets.only(left: 7.w, bottom: 5.h),
                            child: Text(
                              "Course",
                              style: TextStyle(
                                  fontFamily: 'roboto',
                                  fontWeight: FontWeight.w400,
                                  fontSize: 16.sp,
                                  color: Colors.default_color),
                            ),
                          ),
                          DropdownButtonFormField<String>(
                            isExpanded: true,
                            hint: Text(
                              "choose",
                              style: TextStyle(fontSize: 16.sp),
                            ),
                            validator: (value) {
                              if (value == null) {
                                return "*required";
                              }
                              return null;
                            },
                            style:
                                TextStyle(fontSize: 16.sp, color: Colors.black),
                            decoration: InputDecoration(
                                isDense: true,
                                fillColor: Colors.gray,
                                filled: true,
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(7.0),
                                    borderSide: BorderSide(
                                        width: 0.0, style: BorderStyle.none))),
                            items: courseList.map((String currentValue) {
                              return DropdownMenuItem(
                                child: Text(currentValue),
                                value: currentValue,
                              );
                            }).toList(),
                            value: defCourse,
                            onChanged: (value) {
                              setState(() {
                                defCourse = value;
                              });
                            },
                          )
                        ],
                      ),
                    ),

                    SizedBox(width: 20.w),

                    //semester
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: EdgeInsets.only(left: 7.w, bottom: 5.h),
                            child: Text(
                              "Semester",
                              style: TextStyle(
                                  fontFamily: 'roboto',
                                  fontWeight: FontWeight.w400,
                                  fontSize: 16.sp,
                                  color: Colors.default_color),
                            ),
                          ),
                          DropdownButtonFormField<String>(
                            isExpanded: true,
                            hint: Text(
                              "choose",
                              style: TextStyle(fontSize: 16.sp),
                            ),
                            validator: (value) {
                              if (value == null) {
                                return "*required";
                              }
                              return null;
                            },
                            style:
                                TextStyle(fontSize: 16.sp, color: Colors.black),
                            decoration: InputDecoration(
                                isDense: true,
                                fillColor: Colors.gray,
                                filled: true,
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(7.0),
                                    borderSide: BorderSide(
                                        width: 0.0, style: BorderStyle.none))),
                            items: semesterList.map((String currentValue) {
                              return DropdownMenuItem(
                                child: Text(currentValue),
                                value: currentValue,
                              );
                            }).toList(),
                            value: defSemester,
                            onChanged: (value) {
                              setState(() {
                                defSemester = value;
                              });
                            },
                          )
                        ],
                      ),
                    ),
                  ],
                ),

                SizedBox(height: 20.h),

                //Branch dropdown
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: EdgeInsets.only(left: 7.w, bottom: 5.h),
                      child: Text(
                        "Branch",
                        style: TextStyle(
                            fontFamily: 'roboto',
                            fontWeight: FontWeight.w400,
                            fontSize: 16.sp,
                            color: Colors.default_color),
                      ),
                    ),
                    DropdownButtonFormField<String>(
                      isExpanded: true,
                      hint: Text(
                        "choose",
                        style: TextStyle(fontSize: 16.sp),
                      ),
                      validator: (value) {
                        if (value == null) {
                          return "*required";
                        }
                        return null;
                      },
                      style: TextStyle(fontSize: 16.sp, color: Colors.black),
                      decoration: InputDecoration(
                          isDense: true,
                          fillColor: Colors.gray,
                          filled: true,
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(7.0),
                              borderSide: BorderSide(
                                  width: 0.0, style: BorderStyle.none))),
                      items: branchList.map((String currentValue) {
                        return DropdownMenuItem(
                          child: Text(currentValue),
                          value: currentValue,
                        );
                      }).toList(),
                      value: defBranch,
                      onChanged: (value) {
                        setState(() {
                          defBranch = value;
                        });
                      },
                    )
                  ],
                ),

                SizedBox(height: 40.h),

                //save profile button
                Container(
                  height: 45.h,
                  width: double.infinity,
                  margin: EdgeInsets.symmetric(horizontal: 40.w),
                  child: ElevatedButton(
                    onPressed: () {
                      if (profileKey.currentState!.validate()) {
                        //hide on screen keyboard
                        FocusScope.of(context).unfocus();

                        setState(() {
                          isProgress = true;
                        });
                        _saveChanges(
                          sid,
                          firstname,
                          lastname,
                          email,
                          defCourse,
                          defBranch,
                          defSemester,
                          personal_phoneNo,
                          parents_phoneNo,
                          defGender,
                          roomNo,
                        );
                      }
                    },
                    child: isProgress
                        ? SizedBox(
                            height: 25.r,
                            width: 25.r,
                            child: CircularProgressIndicator(
                              color: Colors.white,
                              strokeWidth: 2.0,
                            ))
                        : Text(
                            "Save Changes",
                            style: TextStyle(
                                fontFamily: 'roboto',
                                fontWeight: FontWeight.w700,
                                fontSize: 18.sp),
                          ),
                    style: ButtonStyle(
                        shape: MaterialStateProperty.all(RoundedRectangleBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(30.0)))),
                        backgroundColor:
                            MaterialStateProperty.all(Colors.black)),
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }

//api call for save changes
  _saveChanges(
      String _sid,
      String _firstname,
      String _lastname,
      String _email,
      String _course,
      String _branch,
      String _semester,
      String _personalNo,
      String _parentsNo,
      String _gender,
      String _roomNo) async {
    Map<String, dynamic> changedData = {
      "_id": _sid,
      "firstName": _firstname,
      "lastName": _lastname,
      "email": _email,
      "course": _course,
      "semester": _semester,
      "branch": _branch,
      "contact": {"personal": _personalNo, "guardian": _parentsNo},
      "gender": _gender.contains("Male") ? "M" : "F",
      "room_no": _roomNo
    };
    try {
      var rawResponse =
          await ApiClient.getServices().updateProfile(changedData);

      if (rawResponse.isNotEmpty) {
        Map<String, dynamic> response = jsonDecode(rawResponse);
        bool? success = response["success"];
        String? msg = response["msg"];

        if (success!) {
          //set changed data in temp storage
          TempStorage.setFirstName(_firstname);
          TempStorage.setLastName(_lastname);
          TempStorage.setEmail(_email);
          TempStorage.setCourse(_course);
          TempStorage.setBranch(_branch);
          TempStorage.setSemester(_semester);
          TempStorage.setPersonalNo(_personalNo);
          TempStorage.setParentsNo(_parentsNo);
          TempStorage.setGender(_gender);
          TempStorage.setRoomNo(_roomNo);

          setState(() {
            isProgress = false;
          });
          isLogoutVisible!
              ? _snackBar(msg!)
              : {_snackBar(msg!), Navigator.pop(context, 1)};
        }
      }
    } catch (e) {
      print(e);
      setState(() {
        isProgress = false;
      });
      var dioError = e as DioError;
      var error = DioExceptions.fromDioError(dioError).toString();
      _snackBar(error);
    }
  }

  _snackBar(String msg) {
    var snackbar = SnackBar(
      content: Text(msg),
      behavior: SnackBarBehavior.floating,
    );
    ScaffoldMessenger.of(context).showSnackBar(snackbar);
  }

  _getStudentData() async {
    String _sid = await TempStorage.getUserId();
    String _firstname = await TempStorage.getFirstName();
    String _lastname = await TempStorage.getLastName();
    String _email = await TempStorage.getEmail();
    String _course = await TempStorage.getCourse();
    String _branch = await TempStorage.getBranch();
    String _semester = await TempStorage.getSemester();
    String _personalNo = await TempStorage.getPersonalNo();
    String _parentsNo = await TempStorage.getParentsNo();

    String _genderChar = await TempStorage.getGender();
    String _gender = _genderChar.isEmpty ? "default" : _genderChar.contains("M") ? "Male" : "Female";
    String _roomno = await TempStorage.getRoomNo();

    setState(() {
      sid = _sid;
      firstname = _firstname;
      lastname = _lastname;
      email = _email;
      personal_phoneNo = _personalNo;
      parents_phoneNo = _parentsNo;
      roomNo = _roomno;

      if (_course.isNotEmpty)
        defCourse = courseList.indexOf(_course) < 0
            ? null
            : courseList[courseList.indexOf(_course)];

      if (_branch.isNotEmpty)
        defBranch = branchList.indexOf(_branch) < 0
            ? null
            : branchList[branchList.indexOf(_branch)];

      if (_semester.isNotEmpty)
        defSemester = semesterList.indexOf(_semester) < 0
            ? null
            : semesterList[semesterList.indexOf(_semester)];

      if (_gender.isNotEmpty)
        defGender = genderList.indexOf(_gender) < 0
            ? null
            : genderList[genderList.indexOf(_gender)];
    });
  }
}
