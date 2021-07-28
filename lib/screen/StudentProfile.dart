import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart' hide Colors;
import 'package:freed/screen/SignIn.dart';
import 'package:freed/services/ApiClient.dart';
import 'package:freed/storage/TempStorage.dart';
import 'package:freed/utils/DioExceptions.dart';
import 'package:freed/value/Colors.dart';

class StudentProfile extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _StudentProfile();
  }
}

class _StudentProfile extends State<StudentProfile> {
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
              Padding(
                padding: EdgeInsets.only(right: 8.0),
                child: TextButton(
                    onPressed: () {
                      TempStorage.removePreferences();
                      Navigator.pushAndRemoveUntil(
                          context,
                          MaterialPageRoute(builder: (context) => SignIn()),
                          (route) => false);
                    },
                    child: Row(children: [
                      Text(
                        "Logout",
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 14.0,
                            fontFamily: 'roboto',
                            fontWeight: FontWeight.w700),
                      ),
                      SizedBox(width: 5),
                      Icon(
                        Icons.logout,
                        color: Colors.black,
                        size: 17.0,
                      )
                    ])),
              )
            ],
          ),
          SizedBox(
            height: 20,
          ),
          Expanded(
              child: Container(
            width: double.infinity,
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(45),
                    topRight: Radius.circular(45))),
            child: ProfileForm(),
          ))
        ],
      ),
    );
  }
}

class ProfileForm extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _ProfileForm();
  }
}

class _ProfileForm extends State<ProfileForm> {
  var defCourse;
  var defSemester;
  var defBranch;

  final profileKey = GlobalKey<FormState>();

  //student information variables
  String sid = "";
  String firstname = "";
  String lastname = "";
  String email = "";

  //dropdown lists
  var courseList = ["Diploma", "M.tech", "B.tech"];
  var semesterList = ["1", "2", "3", "4", "5", "6", "7", "8"];
  var branchList = ["CIVIL", "CSE", "EEE", "MECH", "META"];

  bool isProgress = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    _getStudentData();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: profileKey,
      child: Column(
        children: [
          Padding(
            padding: EdgeInsets.only(
                left: 16.0, right: 16.0, bottom: 10.0, top: 30.0),
            child: Text(
              "Profile",
              style: TextStyle(
                  fontFamily: 'roboto',
                  fontSize: 20.0,
                  fontWeight: FontWeight.w700,
                  color: Colors.black,
                  decoration: TextDecoration.none),
            ),
          ),
          Expanded(
            child: ListView(
              padding: EdgeInsets.only(
                  top: 10.0, left: 25.0, right: 25.0, bottom: 50.0),
              children: [
                //first name field
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: EdgeInsets.only(left: 7.0, bottom: 5.0),
                      child: Text(
                        "First Name",
                        style: TextStyle(
                            fontFamily: 'roboto',
                            fontWeight: FontWeight.w400,
                            fontSize: 16.0,
                            color: Colors.default_color),
                      ),
                    ),
                    TextFormField(
                      style: TextStyle(fontSize: 16.0, color: Colors.black),
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
                        hintText: "eg- Roshan",
                        isDense: true,
                        filled: true,
                        fillColor: Colors.gray,
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(7.0),
                            borderSide: BorderSide(
                                width: 0.0, style: BorderStyle.none)),
                        contentPadding: EdgeInsets.symmetric(
                            horizontal: 15.0, vertical: 20.0),
                      ),
                    )
                  ],
                ),

                SizedBox(
                  height: 20.0,
                ),

                //last name field
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: EdgeInsets.only(left: 7.0, bottom: 5.0),
                      child: Text(
                        "Last Name",
                        style: TextStyle(
                            fontFamily: 'roboto',
                            fontWeight: FontWeight.w400,
                            fontSize: 16.0,
                            color: Colors.default_color),
                      ),
                    ),
                    TextFormField(
                      style: TextStyle(fontSize: 16.0, color: Colors.black),
                      keyboardType: TextInputType.text,
                      controller: TextEditingController(text: lastname),
                      onChanged: (value) {
                        lastname = value;
                      },
                      decoration: InputDecoration(
                        hintText: "eg- Nahak",
                        isDense: true,
                        filled: true,
                        fillColor: Colors.gray,
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(7.0),
                            borderSide: BorderSide(
                                width: 0.0, style: BorderStyle.none)),
                        contentPadding: EdgeInsets.symmetric(
                            horizontal: 15.0, vertical: 20.0),
                      ),
                    )
                  ],
                ),

                SizedBox(
                  height: 20.0,
                ),

                //email field
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: EdgeInsets.only(left: 7.0, bottom: 5.0),
                      child: Text(
                        "Email",
                        style: TextStyle(
                            fontFamily: 'roboto',
                            fontWeight: FontWeight.w400,
                            fontSize: 16.0,
                            color: Colors.default_color),
                      ),
                    ),
                    TextFormField(
                      style: TextStyle(fontSize: 16.0, color: Colors.black),
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
                            horizontal: 15.0, vertical: 20.0),
                      ),
                    )
                  ],
                ),

                SizedBox(
                  height: 20.0,
                ),

                //course and semester dropdown
                Row(
                  children: [
                    //course
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: EdgeInsets.only(left: 7.0, bottom: 5.0),
                            child: Text(
                              "Course",
                              style: TextStyle(
                                  fontFamily: 'roboto',
                                  fontWeight: FontWeight.w400,
                                  fontSize: 16.0,
                                  color: Colors.default_color),
                            ),
                          ),
                          DropdownButtonFormField<String>(
                            isExpanded: true,
                            hint: Text("choose"),
                            validator: (value) {
                              if (value == null) {
                                return "*required";
                              }
                              return null;
                            },
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

                    SizedBox(
                      width: 20.0,
                    ),

                    //semester
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: EdgeInsets.only(left: 7.0, bottom: 5.0),
                            child: Text(
                              "Semester",
                              style: TextStyle(
                                  fontFamily: 'roboto',
                                  fontWeight: FontWeight.w400,
                                  fontSize: 16.0,
                                  color: Colors.default_color),
                            ),
                          ),
                          DropdownButtonFormField<String>(
                            isExpanded: true,
                            hint: Text("choose"),
                            validator: (value) {
                              if (value == null) {
                                return "*required";
                              }
                              return null;
                            },
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

                SizedBox(
                  height: 20.0,
                ),

                //Branch dropdown
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: EdgeInsets.only(left: 7.0, bottom: 5.0),
                      child: Text(
                        "Branch",
                        style: TextStyle(
                            fontFamily: 'roboto',
                            fontWeight: FontWeight.w400,
                            fontSize: 16.0,
                            color: Colors.default_color),
                      ),
                    ),
                    DropdownButtonFormField<String>(
                      isExpanded: true,
                      hint: Text("choose"),
                      validator: (value) {
                        if (value == null) {
                          return "*required";
                        }
                        return null;
                      },
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

                SizedBox(height: 40.0),

                //save profile button
                Container(
                  height: 45,
                  width: double.infinity,
                  margin: EdgeInsets.symmetric(horizontal: 40.0),
                  child: ElevatedButton(
                    onPressed: () {
                      if (profileKey.currentState!.validate()) {
                        setState(() {
                          isProgress = true;
                        });
                        _saveChanges(sid, firstname, lastname, email, defCourse,
                            defBranch, defSemester);
                      }
                    },
                    child: isProgress
                        ? SizedBox(
                            height: 25.0,
                            width: 25.0,
                            child: CircularProgressIndicator(
                              color: Colors.white,
                              strokeWidth: 2.0,
                            ))
                        : Text(
                            "Save Changes",
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
              ],
            ),
          )
        ],
      ),
    );
  }

//api call for save changes
  _saveChanges(String _sid, String _firstname, String _lastname, String _email,
      String _course, String _branch, String _semester) async {
    Map<String, dynamic> changedData = {
      "_id": _sid,
      "firstName": _firstname,
      "lastName": _lastname,
      "email": _email,
      "course": _course,
      "semester": _semester,
      "branch": _branch
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

          setState(() {
            isProgress = false;
          });
          _snackBar(msg!);
        }
      }
    } catch (e) {
      setState(() {
        isProgress = false;
      });
      var dioError = e as DioError;
      var error = DioExceptions.fromDioError(dioError).toString();
      _snackBar(error);
    }
  }

  _snackBar(String msg) {
    var snackbar = SnackBar(content: Text(msg));
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

    setState(() {
      sid = _sid;
      firstname = _firstname;
      lastname = _lastname;
      email = _email;

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
    });
  }
}
