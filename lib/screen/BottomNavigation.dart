import 'package:flutter/material.dart' hide Colors;
import 'package:freed/screen/Dashboard.dart';
import 'package:freed/screen/FreedNotification.dart';
import 'package:freed/screen/StudentProfile.dart';
import 'package:freed/value/Colors.dart';
import 'package:freed/value/Image.dart';

class BottomNavigation extends StatefulWidget {
  final sid;
  BottomNavigation({Key? key, @required this.sid}) : super(key: key);
  @override
  State<StatefulWidget> createState() {
    return _BottomNavigation(sid);
  }
}

class _BottomNavigation extends State<BottomNavigation> {
  final _navigatorKey = GlobalKey<NavigatorState>();
  int _currentIndex = 1;
  String? _sid;

  _BottomNavigation(this._sid);

  // late final List<Widget> tabs = <Widget>[
  //   StudentProfile(),
  //   Dashboard(sid: _sid),
  //   FreedNotification(),
  // ];

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

              switch (index) {
                case 0:
                  _navigatorKey.currentState!.pushNamed('/profile');
                  break;
                case 1:
                  _navigatorKey.currentState!.pushNamed('/');
                  break;
                case 2:
                  _navigatorKey.currentState!.pushNamed('/notification');
                  break;
              }
            });
          },
          items: [
            BottomNavigationBarItem(
                icon: Image.asset(userIcon),
                backgroundColor: Colors.white,
                label: "Profile"),
            BottomNavigationBarItem(
                icon: Image.asset(homeIcon),
                backgroundColor: Colors.white,
                label: "Home"),
            BottomNavigationBarItem(
                icon: Image.asset(bellIcon),
                backgroundColor: Colors.white,
                label: "Notification"),
          ]),
      // key: _navigatorKey,
      body: Navigator(
        key: _navigatorKey,
        initialRoute: '/',
        onGenerateRoute: (RouteSettings settings) {
          WidgetBuilder? builder;
          switch (settings.name) {
            case '/':
              builder = (BuildContext context) => Dashboard(sid: _sid);
              break;
            case '/profile':
              builder = (BuildContext context) => StudentProfile();
              setState(() {
                _currentIndex = 0;
              });
              break;
            case '/notification':
              builder = (BuildContext context) => FreedNotification();
              break;
          }
          return MaterialPageRoute(builder: builder!, settings: settings);
        },
      ),
    );
  }
}
