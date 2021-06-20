import 'package:flutter/material.dart' hide Colors;
import 'package:flutter/rendering.dart';
import 'package:freed/value/Colors.dart';
import 'package:freed/value/Image.dart';
import 'package:freed/value/SizeConfig.dart';

class Dashboard extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _Dashboard();
  }
}

class _Dashboard extends State<Dashboard> {
  Widget draggableSheetInnerContent() {
    return Padding(
        padding: EdgeInsets.symmetric(horizontal: 16.0),
        child: Column(
          children: [
            Container(
              width: double.infinity,
              height: 35,
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
              padding: EdgeInsets.only(bottom: 20.0, top: 5.0),
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
              child: ListView.builder(
                padding: EdgeInsets.all(0.0),
                itemBuilder: (context, index) {
                  return ListTile(
                    title: Text("item : $index"),
                  );
                },
                itemCount: 25,
              ),
            ),
          ],
        ));
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Container(
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
                  leading: Padding(
                    padding: const EdgeInsets.only(left: 16),
                    child: Icon(
                      Icons.filter_list,
                      color: Colors.black,
                      size: 35,
                    ),
                  ),
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
                            width: 80,
                            height: 80,
                            decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: Colors.white,
                                boxShadow: [
                                  BoxShadow(
                                      color: Colors.default_color,
                                      blurRadius: 6.0)
                                ]),
                          ),
                          Positioned(
                            bottom: -10.0,
                            left: 0.0,
                            right: 0.0,
                            child: Container(
                              width: 70,
                              height: 70,
                              child: Image.asset(readingDoodle),
                            ),
                          )
                        ],
                      ),
                      SizedBox(height: 10),
                      Text(
                        "Aman Vishwakarma",
                        style: TextStyle(
                            fontFamily: 'roboto',
                            fontWeight: FontWeight.w700,
                            fontSize: 20.0,
                            decoration: TextDecoration.none,
                            color: Colors.black),
                      ),
                      SizedBox(height: 5),
                      Text(
                        "B.Tech CSE",
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
                          Navigator.pushNamed(context, '/expend records');
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
              child: Container(
                width: SizeConfig.screenWidth,
                height: SizeConfig.blockSizeVertical * 60,
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
                child: draggableSheetInnerContent(),
              ),
            )
          ],
        ),
      ),
    );
  }
}
