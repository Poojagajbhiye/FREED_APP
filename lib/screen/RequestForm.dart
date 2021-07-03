import 'package:flutter/material.dart' hide Colors;
import 'package:freed/value/Colors.dart';
import 'package:freed/value/Image.dart';
import 'package:freed/value/SizeConfig.dart';

class RequestForm extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _RequestForm();
  }
}

class _RequestForm extends State<RequestForm> with TickerProviderStateMixin {
  AnimationController? controller, reqStatusCtrl;
  Animation<Offset>? offset, reqStatusOffset;
  bool _visible = true;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    controller =
        AnimationController(vsync: this, duration: Duration(milliseconds: 500));
    offset = Tween<Offset>(begin: Offset.zero, end: Offset(0.0, 2.5))
        .animate(controller!);
  }

  Widget leaveRequestForm() {
    return Padding(
      padding: EdgeInsets.only(left: 35, right: 35, top: 30),
      child: Column(
        children: [
          Text(
            "Escape Request Form",
            style: TextStyle(
                fontFamily: 'roboto',
                fontWeight: FontWeight.w700,
                fontSize: 20),
          ),
          SizedBox(
            height: 40,
          ),
          Row(
            children: [
              Expanded(
                  child: Container(
                height: 45,
                width: double.infinity,
                child: TextFormField(
                    textAlign: TextAlign.center,
                    keyboardType: TextInputType.datetime,
                    maxLines: 1,
                    style: TextStyle(fontSize: 16.0),
                    decoration: InputDecoration(
                        hintText: "Out Date",
                        isDense: true,
                        contentPadding: EdgeInsets.symmetric(
                            vertical: 10.0, horizontal: 10.0),
                        hintMaxLines: 1,
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(4.0)),
                        focusedBorder: OutlineInputBorder(
                            borderSide:
                                BorderSide(color: Colors.black, width: 1.5),
                            borderRadius: BorderRadius.circular(4.0)))),
              )),
              SizedBox(
                width: 25,
              ),
              Expanded(
                  child: Container(
                height: 45,
                width: double.infinity,
                child: TextFormField(
                    textAlign: TextAlign.center,
                    keyboardType: TextInputType.datetime,
                    maxLines: 1,
                    style: TextStyle(fontSize: 16.0),
                    decoration: InputDecoration(
                        hintText: "In Date",
                        isDense: true,
                        contentPadding: EdgeInsets.symmetric(
                            vertical: 10.0, horizontal: 10.0),
                        hintMaxLines: 1,
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(4.0)),
                        focusedBorder: OutlineInputBorder(
                            borderSide:
                                BorderSide(color: Colors.black, width: 1.5),
                            borderRadius: BorderRadius.circular(4.0)))),
              ))
            ],
          ),
          SizedBox(
            height: 10,
          ),
          Row(
            children: [
              Expanded(
                  child: Container(
                height: 45,
                width: double.infinity,
                child: TextFormField(
                    textAlign: TextAlign.center,
                    keyboardType: TextInputType.text,
                    maxLines: 1,
                    style: TextStyle(fontSize: 16.0),
                    decoration: InputDecoration(
                        hintText: "To",
                        isDense: true,
                        contentPadding: EdgeInsets.symmetric(
                            vertical: 10.0, horizontal: 10.0),
                        hintMaxLines: 1,
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(4.0)),
                        focusedBorder: OutlineInputBorder(
                            borderSide:
                                BorderSide(color: Colors.black, width: 1.5),
                            borderRadius: BorderRadius.circular(4.0)))),
              )),
              SizedBox(
                width: 25,
              ),
              Expanded(
                  child: Container(
                height: 45,
                width: double.infinity,
                child: TextFormField(
                    textAlign: TextAlign.center,
                    keyboardType: TextInputType.text,
                    maxLines: 1,
                    style: TextStyle(fontSize: 16.0),
                    decoration: InputDecoration(
                        hintText: "From",
                        isDense: true,
                        contentPadding: EdgeInsets.symmetric(
                            vertical: 10.0, horizontal: 10.0),
                        hintMaxLines: 1,
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(4.0)),
                        focusedBorder: OutlineInputBorder(
                            borderSide:
                                BorderSide(color: Colors.black, width: 1.5),
                            borderRadius: BorderRadius.circular(4.0)))),
              ))
            ],
          ),
          SizedBox(
            height: 40,
          ),
          Container(
            width: double.infinity,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  "Reason for escape",
                  style: TextStyle(
                      fontFamily: 'roboto',
                      fontWeight: FontWeight.w400,
                      fontSize: 16.0,
                      color: Colors.black),
                ),
                SizedBox(
                  height: 15,
                ),
                Container(
                  child: TextFormField(
                    maxLines: 5,
                    maxLength: 250,
                    style: TextStyle(fontSize: 16.0),
                    decoration: InputDecoration(
                        isDense: true,
                        contentPadding: EdgeInsets.symmetric(
                            vertical: 10.0, horizontal: 10.0),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(4.0)),
                        focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(4.0),
                            borderSide:
                                BorderSide(color: Colors.black, width: 1.5))),
                  ),
                ),
              ],
            ),
          ),
          Container(
            height: 45,
            margin: EdgeInsets.only(top: 30, bottom: 15, right: 15, left: 15),
            width: double.infinity,
            child: ElevatedButton(
              onPressed: () {
                if (controller!.isDismissed) {
                  controller!.forward();
                }
                setState(() {
                  _visible = !_visible;
                });
              },
              child: Text(
                "Process Request",
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
            onPressed: () {
              Navigator.pushNamed(context, '/view request');
            },
            child: Text(
              "Cancel",
              style: TextStyle(
                  fontFamily: 'robot',
                  fontSize: 16.0,
                  fontWeight: FontWeight.w400,
                  color: Colors.default_color),
            ),
          ),
        ],
      ),
    );
  }

  Widget _reqStatusContainer() {
    return Padding(
      padding: EdgeInsets.only(top: 50, right: 15, bottom: 15, left: 15),
      child: Column(
        children: [
          Container(
            margin: EdgeInsets.only(top: 10),
            width: 50,
            height: 50,
            decoration:
                BoxDecoration(shape: BoxShape.circle, color: Colors.black),
            child: Icon(
              Icons.done_rounded,
              color: Colors.white,
              size: 40,
            ),
          ),
          SizedBox(height: 10),
          Text(
            "Get Ready, with the plan!",
            style: TextStyle(
                fontFamily: 'roboto',
                fontWeight: FontWeight.w700,
                fontSize: 20,
                color: Colors.black),
          ),
          SizedBox(height: 10),
          Text(
            "Your Request  has been sent successfully",
            style: TextStyle(
                fontFamily: 'roboto',
                fontWeight: FontWeight.w400,
                fontSize: 14,
                color: Colors.default_color),
          ),
          SizedBox(height: 30),
          Container(
              height: 40.0,
              width: 110,
              child: ElevatedButton(
                  onPressed: () {},
                  style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all(Colors.black),
                      shape: MaterialStateProperty.all(RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30.0))),
                      shadowColor: MaterialStateProperty.all(Colors.black)),
                  child: Text(
                    "Done",
                    style: TextStyle(
                        color: Colors.white,
                        fontFamily: 'roboto',
                        fontWeight: FontWeight.w700,
                        fontSize: 16.0),
                  ))),
          SizedBox(height: 7),
          TextButton(
              onPressed: () {},
              child: Text(
                "Track Request Status",
                style: TextStyle(
                    fontFamily: 'roboto',
                    fontWeight: FontWeight.w400,
                    fontSize: 14.0,
                    color: Colors.default_color),
              ))
        ],
      ),
    );
  }

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
              leadingWidth: 70,
              leading: Padding(
                padding: EdgeInsets.only(left: 15.0),
                child: AnimatedOpacity(
                  opacity: _visible ? 1.0 : 0.0,
                  duration: Duration(milliseconds: 500),
                  child: TextButton(
                      onPressed: () {},
                      child: Text(
                        "Back",
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 14.0,
                            fontFamily: 'roboto',
                            fontWeight: FontWeight.w700),
                      )),
                ),
              ),
            ),
            Expanded(
                child: Container(
              height: double.infinity,
              width: double.infinity,
              child: Stack(children: [
                Positioned(
                  bottom: 0,
                  child: Container(
                    child: _reqStatusContainer(),
                    width: SizeConfig.screenWidth,
                    height: SizeConfig.safeBlockVertical! * 50,
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
                Align(
                    alignment: Alignment(1.0, -0.3),
                    child: Container(
                      width: SizeConfig.safeBlockHorizontal! * 60,
                      height: SizeConfig.safeBlockHorizontal! * 50,
                      child: Image.asset(sitReadingDoodle),
                    )),
                Column(
                  children: [
                    AnimatedOpacity(
                      opacity: _visible ? 1.0 : 0.0,
                      duration: Duration(milliseconds: 500),
                      child: Container(
                        margin: EdgeInsets.only(
                            left: 40, right: 40, top: 20, bottom: 40),
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
                    ),
                    Expanded(
                      child: Align(
                        alignment: Alignment.bottomCenter,
                        child: SlideTransition(
                          position: offset!,
                          child: Container(
                            child: leaveRequestForm(),
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
                      ),
                    ),
                  ],
                ),
              ]),
            ))
          ],
        ),
      ),
    );
  }
}
