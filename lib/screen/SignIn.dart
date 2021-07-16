import 'package:dio/dio.dart';
import 'package:flutter/material.dart' hide Colors;
import 'package:flutter/rendering.dart';
import 'package:freed/model/StudentInfo.dart';
import 'package:freed/screen/BottomNavigation.dart';
import 'package:freed/screen/SignUp.dart';
import 'package:freed/services/ApiClient.dart';
import 'package:freed/storage/TempStorage.dart';
import 'package:freed/utils/DioExceptions.dart';
import 'package:freed/value/Colors.dart';
import 'package:freed/value/Image.dart';
import 'package:freed/value/SizeConfig.dart';
import 'package:freed/model/LoginResponse.dart';

class SignIn extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
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
                      padding: EdgeInsets.only(right: 15.0),
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
                                fontSize: 14.0,
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
                          child: SignInForm(),
                          height: SizeConfig.screenWidth! > 400
                              ? SizeConfig.safeBlockVertical! * 67
                              : SizeConfig.safeBlockVertical! * 70,
                          width: double.infinity,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(45),
                                topRight: Radius.circular(45)),
                          ),
                        ),
                      ),
                      Align(
                          alignment: Alignment(0.0, -0.9),
                          child: _doodleImage())
                    ],
                  ),
                ))
              ],
            ),
          ),
        ));
  }
}

Widget _doodleImage() {
  return Container(
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
              fontSize: 30.0),
        ),
        SizedBox(
          height: 20,
        ),
        Image.asset(
          dancingDoodle,
          width: SizeConfig.screenWidth! > 400
              ? SizeConfig.safeBlockHorizontal! * 60
              : SizeConfig.safeBlockHorizontal! * 75,
        ),
      ],
    ),
  );
}

class SignInForm extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _SignInForm();
  }
}

class _SignInForm extends State<SignInForm> {
  final loginKey = GlobalKey<FormState>();

  TextEditingController _rid = TextEditingController();
  TextEditingController _pass = TextEditingController();
  bool isprogress = false;

  @override
  Widget build(BuildContext context) {
    return Form(
      key: loginKey,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      child: ListView(
        children: [
          Padding(
            padding: EdgeInsets.only(
                top: SizeConfig.safeBlockVertical! * 16, left: 50, right: 50),
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
                      style: TextStyle(fontSize: 16.0),
                      decoration: InputDecoration(
                          hintText: "Registration No",
                          isDense: true,
                          contentPadding: EdgeInsets.symmetric(
                              vertical: 15.0, horizontal: 15.0),
                          hintMaxLines: 1,
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(30.0)),
                          focusedBorder: OutlineInputBorder(
                              borderSide:
                                  BorderSide(color: Colors.black, width: 1.5),
                              borderRadius: BorderRadius.circular(30.0)))),
                ),
                Container(
                  margin: EdgeInsets.only(top: 20),
                  width: double.infinity,
                  child: TextFormField(
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
                      keyboardType: TextInputType.number,
                      maxLines: 1,
                      style: TextStyle(fontSize: 16.0),
                      decoration: InputDecoration(
                          hintText: "Password",
                          isDense: true,
                          contentPadding: EdgeInsets.symmetric(
                              vertical: 15.0, horizontal: 15.0),
                          hintMaxLines: 1,
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(30.0)),
                          focusedBorder: OutlineInputBorder(
                              borderSide:
                                  BorderSide(color: Colors.black, width: 1.5),
                              borderRadius: BorderRadius.circular(30.0)))),
                ),
                Container(
                  height: 45,
                  margin: EdgeInsets.only(top: 25, bottom: 5),
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
                            height: 25.0,
                            width: 25.0,
                            child: CircularProgressIndicator(
                              color: Colors.white,
                              strokeWidth: 2.0,
                            ))
                        : Text(
                            "Sign In",
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
                TextButton(
                    onPressed: () {},
                    child: Text(
                      "Forgot Password ?",
                      style: TextStyle(
                          fontFamily: 'robot',
                          fontSize: 14.0,
                          fontWeight: FontWeight.w400,
                          color: Colors.default_color),
                    )),
                SizedBox(
                  height: SizeConfig.safeBlockVertical! * 1.5,
                ),
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
                          fontSize: 14.0,
                          fontWeight: FontWeight.w400,
                          color: Colors.default_color),
                    ))
              ],
            ),
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
      final err = e as DioError;
      setState(() {
        isprogress = false;
      });
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

        if (success!) {
          TempStorage.setRid(rid!);
          TempStorage.setUserId(userId!);

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
      final err = e as DioError;
      setState(() {
        isprogress = false;
      });
      final errormsg = DioExceptions.fromDioError(err).toString();
      _snackBar(errormsg);
    }
  }

  _snackBar(String msg) {
    var snackBar = SnackBar(content: Text(msg));
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }
}
