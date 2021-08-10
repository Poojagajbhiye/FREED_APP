import 'package:dio/dio.dart';
import 'package:flutter/material.dart' hide Colors;
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:freed/model/SignUpResponse.dart';
import 'package:freed/screen/SignIn.dart';
import 'package:freed/services/ApiClient.dart';
import 'package:freed/utils/DioExceptions.dart';
import 'package:freed/value/Colors.dart';

class SignUp extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _SignUp();
  }
}

class _SignUp extends State<SignUp> {
  bool keyboardVisiblity = false;

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
                leadingWidth: 70.w,
                actions: [
                  Padding(
                    padding: EdgeInsets.only(right: 15.w),
                    child: TextButton(
                        onPressed: () {
                          Navigator.pushAndRemoveUntil(
                              context,
                              MaterialPageRoute(builder: (context) => SignIn()),
                              (route) => false);
                        },
                        child: Text(
                          "Login",
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
                child: Column(
                  children: [
                    keyboardVisiblity
                        ? SizedBox()
                        : Container(
                            margin: EdgeInsets.only(
                                left: 40.w,
                                right: 40.w,
                                top: 20.h,
                                bottom: 49.8.h),
                            child: Text(
                              "Sed ut perspiciatis unde omnis iste natus error sit voluptatem accusantium",
                              textAlign: TextAlign.center,
                              maxLines: 2,
                              style: TextStyle(
                                  fontSize: 14.sp,
                                  fontFamily: 'roboto',
                                  fontWeight: FontWeight.w700),
                            ),
                          ),
                    Expanded(
                      child: Align(
                        alignment: Alignment.bottomCenter,
                        child: Container(
                          child: SignUpForm(),
                          width: double.infinity,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(45.r),
                                topRight: Radius.circular(45.r)),
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ))
            ],
          ),
        ),
      ),
    );
  }
}

class SignUpForm extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _SignUpForm();
  }
}

class _SignUpForm extends State<SignUpForm> {
  final signupKey = GlobalKey<FormState>();
  var password;
  bool isProgress = false;

  TextEditingController _rid = TextEditingController();
  TextEditingController _pass = TextEditingController();

  @override
  void dispose() {
    _rid.dispose();
    _pass.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: signupKey,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      child: ListView(
        padding: EdgeInsets.only(top: 0.0),
        children: [
          SingleChildScrollView(
            reverse: true,
            child: Padding(
              padding: EdgeInsets.only(
                  left: 50.w,
                  right: 50.w,
                  top: 40.h,
                  bottom: MediaQuery.of(context).viewInsets.bottom),
              child: Column(
                children: [
                  Text(
                    "Sign Up",
                    style: TextStyle(
                        fontFamily: 'roboto',
                        fontWeight: FontWeight.w700,
                        fontSize: 30.sp),
                  ),
                  Container(
                    margin: EdgeInsets.only(top: 35.h),
                    width: double.infinity,
                    child: TextFormField(
                        controller: _rid,
                        validator: (String? value) {
                          if (value!.isEmpty) {
                            return "*required field";
                          } else if (!value.toUpperCase().contains("UG")) {
                            return "please enter valid id";
                          }
                          return null;
                        },
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
                        controller: _pass,
                        obscureText: true,
                        validator: (String? value) {
                          if (value!.isEmpty) {
                            return "*required field";
                          } else if (value.length < 6) {
                            return "please enter min 6 char.";
                          }
                          password = value;
                          return null;
                        },
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
                    margin: EdgeInsets.only(top: 20.h),
                    width: double.infinity,
                    child: TextFormField(
                        textAlign: TextAlign.center,
                        validator: (String? value) {
                          if (value!.isEmpty) {
                            return "*required field";
                          } else if (value != password) {
                            return "password does't match";
                          }
                          return null;
                        },
                        keyboardType: TextInputType.text,
                        maxLines: 1,
                        style: TextStyle(fontSize: 16.sp),
                        decoration: InputDecoration(
                            hintText: "Confirm Password",
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
                    margin: EdgeInsets.only(top: 30.h, bottom: 15.h),
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () {
                        var isvalid = signupKey.currentState?.validate();
                        if (isvalid!) {
                          String id = _rid.text;
                          String pass = _pass.text;

                          setState(() {
                            isProgress = true;
                          });

                          _signUpControler(id.toUpperCase(), pass);
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
                              "Sign Up",
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
                    onPressed: () {
                      Navigator.pushAndRemoveUntil(
                          context,
                          MaterialPageRoute(builder: (context) => SignIn()),
                          (route) => false);
                    },
                    child: Text(
                      "Already have an account ?",
                      style: TextStyle(
                          fontFamily: 'robot',
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w400,
                          color: Colors.default_color),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _signUpControler(String id, String pass) async {
    print("$id, $pass");
    Map<String, dynamic> reqData = {"RID": id, "password": pass};

    try {
      var response = await ApiClient.getServices().requestSignUp(reqData);

      if (response.isNotEmpty) {
        SignUpResponse signUpResponse = signUpResponseFromJson(response);
        bool? isSuccess = signUpResponse.success;
        String? msg = signUpResponse.msg;

        setState(() {
          isProgress = false;
        });
        if (isSuccess!) {
          Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(builder: (context) => SignIn()),
              (route) => false);
        } else {
          _snackBar(msg!);
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
}
