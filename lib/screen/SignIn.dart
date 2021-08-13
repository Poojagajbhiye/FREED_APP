import 'package:dio/dio.dart';
import 'package:flutter/material.dart' hide Colors;
import 'package:flutter/rendering.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:freed/model/StudentInfo.dart';
import 'package:freed/screen/BottomNavigation.dart';
import 'package:freed/screen/SignUp.dart';
import 'package:freed/services/ApiClient.dart';
import 'package:freed/storage/TempStorage.dart';
import 'package:freed/utils/DioExceptions.dart';
import 'package:freed/value/Colors.dart';
import 'package:freed/value/Image.dart';
import 'package:freed/model/LoginResponse.dart';

class SignIn extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _SignIn();
  }
}

class _SignIn extends State<SignIn> {
  final loginKey = GlobalKey<FormState>();

  TextEditingController _rid = TextEditingController();
  TextEditingController _pass = TextEditingController();
  bool isprogress = false;

  bool keyboardVisiblity = false;

  @override
  void dispose() {
    _rid.dispose();
    _pass.dispose();
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
                  actions: [
                    Padding(
                      padding: EdgeInsets.only(right: 15.w),
                      child: TextButton(
                          onPressed: () {
                            Navigator.pushAndRemoveUntil(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => SignUp()),
                                (route) => false);
                          },
                          child: Text(
                            "Register",
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: 14.sp,
                                fontFamily: 'roboto',
                                fontWeight: FontWeight.w700),
                          )),
                    )
                  ],
                ),
                Expanded(
                    child: Container(
                  height: double.infinity,
                  width: double.infinity,
                  child: Stack(
                    children: [
                      Align(
                        alignment: Alignment.bottomCenter,
                        child: Container(
                          child: _SignInForm(),
                          height: keyboardVisiblity ? double.infinity : 523.6.h,
                          width: double.infinity,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(45.r),
                                topRight: Radius.circular(45.r)),
                          ),
                        ),
                      ),
                      Positioned(bottom: 395.h, child: _doodleImage())
                    ],
                  ),
                ))
              ],
            ),
          ),
        ));
  }

  Widget _SignInForm() {
    return Form(
      key: loginKey,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      child: ListView(
        padding: EdgeInsets.only(top: 0.0),
        children: [
          SingleChildScrollView(
            reverse: true,
            child: Padding(
              padding: EdgeInsets.only(
                  top: 135.h,
                  left: 50.w,
                  right: 50.w,
                  bottom: MediaQuery.of(context).viewInsets.bottom),
              child: Column(
                children: [
                  Container(
                    width: double.infinity,
                    child: TextFormField(
                        validator: (String? value) {
                          if (value!.isEmpty) {
                            return "*field required";
                          } else if (!value.toUpperCase().contains("UG")) {
                            return "please enter valid id";
                          }
                          return null;
                        },
                        controller: _rid,
                        textAlign: TextAlign.center,
                        keyboardType: TextInputType.text,
                        maxLines: 1,
                        style: TextStyle(fontSize: 16.sp),
                        decoration: InputDecoration(
                            hintText: "Registration No",
                            isDense: true,
                            contentPadding: EdgeInsets.symmetric(
                                vertical: 15.r, horizontal: 15.r),
                            hintMaxLines: 1,
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(30.0)),
                            focusedBorder: OutlineInputBorder(
                                borderSide:
                                    BorderSide(color: Colors.black, width: 1.5),
                                borderRadius: BorderRadius.circular(30.0)))),
                  ),
                  Container(
                    margin: EdgeInsets.only(top: 20.h),
                    width: double.infinity,
                    child: TextFormField(
                        obscureText: true,
                        validator: (String? value) {
                          if (value!.isEmpty) {
                            return "*required field";
                          } else if (value.length < 6) {
                            return "please enter min 6 char.";
                          }
                          return null;
                        },
                        controller: _pass,
                        textAlign: TextAlign.center,
                        keyboardType: TextInputType.text,
                        maxLines: 1,
                        style: TextStyle(fontSize: 16.sp),
                        decoration: InputDecoration(
                            hintText: "Password",
                            isDense: true,
                            contentPadding: EdgeInsets.symmetric(
                                vertical: 15.r, horizontal: 15.r),
                            hintMaxLines: 1,
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(30.0)),
                            focusedBorder: OutlineInputBorder(
                                borderSide:
                                    BorderSide(color: Colors.black, width: 1.5),
                                borderRadius: BorderRadius.circular(30.0)))),
                  ),
                  Container(
                    height: 45.h,
                    margin: EdgeInsets.only(top: 25.h, bottom: 5.h),
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () {
                        var isvalid = loginKey.currentState?.validate();

                        if (isvalid!) {
                          String id = _rid.text;
                          String pass = _pass.text;

                          setState(() {
                            isprogress = true;
                          });

                          _loginControler(id.toUpperCase(), pass);
                        }
                      },
                      child: isprogress
                          ? SizedBox(
                              height: 25.r,
                              width: 25.r,
                              child: CircularProgressIndicator(
                                color: Colors.white,
                                strokeWidth: 2.0,
                              ))
                          : Text(
                              "Sign In",
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
                      onPressed: () {},
                      child: Text(
                        "Forgot Password ?",
                        style: TextStyle(
                            fontFamily: 'robot',
                            fontSize: 14.sp,
                            fontWeight: FontWeight.w400,
                            color: Colors.default_color),
                      )),
                  SizedBox(height: 11.22.h),
                  TextButton(
                      onPressed: () {
                        Navigator.pushAndRemoveUntil(
                            context,
                            MaterialPageRoute(builder: (context) => SignUp()),
                            (route) => false);
                      },
                      child: Text(
                        "Don't have an account ?",
                        style: TextStyle(
                            fontFamily: 'robot',
                            fontSize: 14.sp,
                            fontWeight: FontWeight.w400,
                            color: Colors.default_color),
                      ))
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _doodleImage() {
    return keyboardVisiblity
        ? SizedBox()
        : Container(
            width: 1.sw,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Sign In",
                  style: TextStyle(
                      decoration: TextDecoration.none,
                      color: Colors.black,
                      fontFamily: 'roboto',
                      fontWeight: FontWeight.w700,
                      fontSize: 30.sp),
                ),
                SizedBox(
                  height: 10.h,
                ),
                Image.asset(
                  dancingDoodle,
                  width: 270.r,
                  // height: 270.h,
                ),
              ],
            ),
          );
  }

  void _loginControler(String id, String pass) async {
    print("$id, $pass");
    Map<String, dynamic> reqdata = {"RID": id, "password": pass};
    try {
      var response = await ApiClient.getServices().requestLogin(reqdata);
      if (response.isNotEmpty) {
        LoginResponse loginResponse = loginResponseFromJson(response);
        bool? success = loginResponse.success;
        String? token = loginResponse.token;

        if (success!) {
          TempStorage.setToken(token!);
          _getDataFromToken(await TempStorage.getToken());

          print(loginResponse.msg);
        }
      }
    } catch (e) {
      setState(() {
        isprogress = false;
      });
      final err = e as DioError;
      final errormsg = DioExceptions.fromDioError(err).toString();
      _snackBar(errormsg);
    }
  }

  _getDataFromToken(String token) async {
    try {
      var response = await ApiClient.getServices().tokenDecodeRequest(token);
      if (response.isNotEmpty) {
        StudentInfo studentInfo = studentInfoFromJson(response);

        bool? success = studentInfo.success;
        String? userId = studentInfo.decoded?.id;
        String? rid = studentInfo.decoded?.rid;
        String? _firstname = studentInfo.decoded?.firstName ?? "";
        String? _lastname = studentInfo.decoded?.lastName ?? "";
        String? _email = studentInfo.decoded?.email ?? "";
        String? _branch = studentInfo.decoded?.branch ?? "";
        String? _course = studentInfo.decoded?.course ?? "";
        String? _semester = studentInfo.decoded?.semester ?? "";

        if (success!) {
          TempStorage.setRid(rid!);
          TempStorage.setUserId(userId!);
          TempStorage.setFirstName(_firstname);
          TempStorage.setLastName(_lastname);
          TempStorage.setEmail(_email);
          TempStorage.setBranch(_branch);
          TempStorage.setCourse(_course);
          TempStorage.setSemester(_semester);

          setState(() {
            isprogress = false;
          });
          Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(
                  builder: (context) => BottomNavigation(sid: userId)),
              (route) => false);
        }
      }
    } catch (e) {
      setState(() {
        isprogress = false;
      });
      final err = e as DioError;

      final errormsg = DioExceptions.fromDioError(err).toString();
      _snackBar(errormsg);
    }
  }

  _snackBar(String msg) {
    var snackBar = SnackBar(
      content: Text(msg),
      behavior: SnackBarBehavior.floating,
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }
}
