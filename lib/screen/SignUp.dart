import 'package:dio/dio.dart';
import 'package:flutter/material.dart' hide Colors;
import 'package:freed/model/SignUpResponse.dart';
import 'package:freed/services/ApiClient.dart';
import 'package:freed/utils/DioExceptions.dart';
import 'package:freed/value/Colors.dart';

class SignUp extends StatelessWidget {
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
                actions: [
                  Padding(
                    padding: EdgeInsets.only(right: 15.0),
                    child: TextButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child: Text(
                          "Login",
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
                child: Column(
                  children: [
                    Container(
                      margin: EdgeInsets.only(
                          left: 40, right: 40, top: 20, bottom: 50),
                      child: Text(
                        "Sed ut perspiciatis unde omnis iste natus error sit voluptatem accusantium",
                        textAlign: TextAlign.center,
                        maxLines: 2,
                        style: TextStyle(
                            fontSize: 14.0,
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
                                topLeft: Radius.circular(45),
                                topRight: Radius.circular(45)),
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
  Widget build(BuildContext context) {
    return Form(
      key: signupKey,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      child: ListView(
        children: [
          Padding(
            padding: EdgeInsets.only(left: 50, right: 50, top: 10),
            child: Column(
              children: [
                Text(
                  "Sign Up",
                  style: TextStyle(
                      fontFamily: 'roboto',
                      fontWeight: FontWeight.w700,
                      fontSize: 30),
                ),
                Container(
                  margin: EdgeInsets.only(top: 35),
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
                      controller: _pass,
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
                  margin: EdgeInsets.only(top: 20),
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
                      keyboardType: TextInputType.number,
                      maxLines: 1,
                      style: TextStyle(fontSize: 16.0),
                      decoration: InputDecoration(
                          hintText: "Confirm Password",
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
                  margin: EdgeInsets.only(top: 30, bottom: 15),
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
                            height: 25.0,
                            width: 25.0,
                            child: CircularProgressIndicator(
                              color: Colors.white,
                              strokeWidth: 2.0,
                            ))
                        : Text(
                            "Sign Up",
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
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: Text(
                    "Already have an account ?",
                    style: TextStyle(
                        fontFamily: 'robot',
                        fontSize: 14.0,
                        fontWeight: FontWeight.w400,
                        color: Colors.default_color),
                  ),
                ),
              ],
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

        if (isSuccess!) {
          setState(() {
            isProgress = false;
          });
          Navigator.popAndPushNamed(context, "/sign in");
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
