import 'package:flutter/material.dart' hide Colors;
import 'package:freed/value/Colors.dart';
import 'package:freed/value/SizeConfig.dart';

class ExpendedRecords extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _ExpendedRecords();
  }
}

class _ExpendedRecords extends State<ExpendedRecords> {
  @override
  Widget build(BuildContext context) {
    return Material(
      child: Container(
        width: SizeConfig.screenWidth,
        height: SizeConfig.screenHeight,
        decoration: BoxDecoration(color: Colors.white),
        child: Column(
          children: [
            AppBar(
              backgroundColor: Colors.white,
              automaticallyImplyLeading: false,
              shadowColor: Colors.transparent,
              leadingWidth: 70,
              leading: Padding(
                padding: EdgeInsets.only(left: 15.0),
                child: TextButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
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
            Container(
                padding: EdgeInsets.only(right: 16.0, left: 16.0, bottom: 16.0),
                child: Column(
                  children: [
                    Text(
                      "Escape Records",
                      style: TextStyle(
                          fontFamily: 'roboto',
                          fontWeight: FontWeight.w700,
                          color: Colors.black,
                          decoration: TextDecoration.none,
                          fontSize: 20.0),
                    ),
                    SizedBox(height: 15.0),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Text(
                          "Accepted",
                          style: TextStyle(
                              fontFamily: 'roboto',
                              fontWeight: FontWeight.w400,
                              fontSize: 16.0,
                              color: Colors.black),
                        ),
                        Text(
                          "Declined",
                          style: TextStyle(
                              fontFamily: 'roboto',
                              fontWeight: FontWeight.w400,
                              fontSize: 16.0,
                              color: Colors.black),
                        ),
                        Text(
                          "Process",
                          style: TextStyle(
                              fontFamily: 'roboto',
                              fontWeight: FontWeight.w400,
                              fontSize: 16.0,
                              color: Colors.black),
                        ),
                      ],
                    )
                  ],
                )),
            Expanded(
                child: ListView.builder(
              padding: EdgeInsets.all(0.0),
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text("item : $index"),
                );
              },
              itemCount: 25,
            ))
          ],
        ),
      ),
    );
  }
}
