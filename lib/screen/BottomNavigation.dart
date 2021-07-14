import 'package:flutter/material.dart' hide Colors;
import 'package:freed/screen/Dashboard.dart';
import 'package:freed/screen/ExpendedRecords.dart';
import 'package:freed/value/Colors.dart';

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
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
          unselectedItemColor: Colors.default_color,
          selectedItemColor: Colors.black,
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
                  Icons.home,
                ),
                backgroundColor: Colors.white,
                label: "Home"),
            BottomNavigationBarItem(
                icon: Icon(Icons.home),
                backgroundColor: Colors.white,
                label: "Track"),
            BottomNavigationBarItem(
                icon: Icon(Icons.supervised_user_circle),
                backgroundColor: Colors.white,
                label: "Profile"),
            BottomNavigationBarItem(
                icon: Icon(Icons.home),
                backgroundColor: Colors.white,
                label: "Setting"),
            // BottomNavigationBarItem(icon: Icon(Icons.home), label: "Logout"),
          ]),
      body: tabs[_currentIndex],
    );
  }
}
