import 'package:flutter/material.dart' hide Colors;
import 'package:freed/screen/Dashboard.dart';
import 'package:freed/screen/FreedNotification.dart';
import 'package:freed/screen/StudentProfile.dart';
import 'package:freed/value/Colors.dart';
import 'package:freed/value/custom_icons.dart';

class BottomNavigation extends StatefulWidget {
  final sid;
  BottomNavigation({Key? key, @required this.sid}) : super(key: key);
  @override
  State<StatefulWidget> createState() {
    return _BottomNavigation(sid);
  }
}

class _BottomNavigation extends State<BottomNavigation> {
  int _currentIndex = 0;
  String? _sid;

  _BottomNavigation(this._sid);

  late final List<Widget> tabs = <Widget>[
    Dashboard(sid: _sid),
    StudentProfile(),
    FreedNotification(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
          unselectedItemColor: Colors.default_color,
          selectedItemColor: Colors.black,
          selectedFontSize: 12.0,
          type: BottomNavigationBarType.shifting,
          currentIndex: _currentIndex,
          onTap: (index) {
            setState(() {
              _currentIndex = index;
            });
          },
          items: [
            BottomNavigationBarItem(
                icon: Icon(
                  CustomIcons.home,
                ),
                backgroundColor: Colors.white,
                label: "Home"),
            BottomNavigationBarItem(
                icon: Icon(CustomIcons.user),
                backgroundColor: Colors.white,
                label: "Profile"),
            BottomNavigationBarItem(
                icon: Icon(CustomIcons.bell),
                backgroundColor: Colors.white,
                label: "Notification"),
          ]),
      body: tabs[_currentIndex],
    );
  }
}
