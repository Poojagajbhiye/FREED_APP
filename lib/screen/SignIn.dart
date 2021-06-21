import 'package:flutter/material.dart' hide Colors;
import 'package:freed/value/Colors.dart';
import 'package:freed/value/Image.dart';
import 'package:freed/value/SizeConfig.dart';

// class SignIn extends StatefulWidget {
//   @override
//   State<StatefulWidget> createState() {
//     return _SignIn();
//   }
// }

class SignIn extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Material(
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
                        Navigator.pushNamed(context, '/sign up');
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
                      height: SizeConfig.screenWidth > 400
                          ? SizeConfig.safeBlockVertical * 67
                          : SizeConfig.safeBlockVertical * 70,
                      width: double.infinity,
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(45),
                              topRight: Radius.circular(45)),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.shadow,
                              offset: Offset(0.0, -2.0),
                              blurRadius: 10.0,
                            )
                          ]),
                    ),
                  ),
                  Align(alignment: Alignment(0.0, -0.9), child: DoodleImage())
                ],
              ),
            ))
          ],
        ),
      ),
    );
  }
}

class DoodleImage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
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
            width: SizeConfig.screenWidth > 400
                ? SizeConfig.safeBlockHorizontal * 60
                : SizeConfig.safeBlockHorizontal * 75,
          ),
        ],
      ),
    );
  }
}

class SignInForm extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _SignInForm();
  }
}

class _SignInForm extends State<SignInForm> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
          top: SizeConfig.safeBlockVertical * 20, left: 50, right: 50),
      child: Column(
        children: [
          Container(
            height: 45,
            width: double.infinity,
            child: TextFormField(
                textAlign: TextAlign.center,
                keyboardType: TextInputType.number,
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
                        borderSide: BorderSide(color: Colors.black, width: 1.5),
                        borderRadius: BorderRadius.circular(30.0)))),
          ),
          Container(
            height: 62,
            margin: EdgeInsets.only(top: 20),
            width: double.infinity,
            child: TextFormField(
                textAlign: TextAlign.center,
                keyboardType: TextInputType.number,
                maxLines: 1,
                maxLength: 6,
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
                        borderSide: BorderSide(color: Colors.black, width: 1.5),
                        borderRadius: BorderRadius.circular(30.0)))),
          ),
          Container(
            height: 45,
            margin: EdgeInsets.only(top: 20, bottom: 5),
            width: double.infinity,
            child: ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context, '/dashboard');
              },
              child: Text(
                "Sign In",
                style: TextStyle(
                    fontFamily: 'roboto',
                    fontWeight: FontWeight.w700,
                    fontSize: 18.0),
              ),
              style: ButtonStyle(
                  shape: MaterialStateProperty.all(RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(30.0)))),
                  backgroundColor: MaterialStateProperty.all(Colors.black)),
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
            height: SizeConfig.safeBlockVertical * 1.5,
          ),
          TextButton(
              onPressed: () {
                Navigator.pushNamed(context, '/sign up');
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
    );
  }
}
