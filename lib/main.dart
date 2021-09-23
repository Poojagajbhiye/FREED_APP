import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart' hide Colors;
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:freed/screen/SplashScreen/SplashScreen.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:freed/utils/Colors.dart';

const AndroidNotificationChannel channel = AndroidNotificationChannel(
    "01",
    "freed student notification",
    "student side notification when accept or declined the request",
    importance: Importance.high);

final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin();

Future<void> firebaseMessagingBackgroundHandler(RemoteMessage msg) async {
  await Firebase.initializeApp();
}

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  FirebaseMessaging.onBackgroundMessage(firebaseMessagingBackgroundHandler);

  await flutterLocalNotificationsPlugin
      .resolvePlatformSpecificImplementation<
          AndroidFlutterLocalNotificationsPlugin>()
      ?.createNotificationChannel(channel);

  await FirebaseMessaging.instance.setForegroundNotificationPresentationOptions(
      alert: true, badge: true, sound: true);

  runApp(
    ScreenUtilInit(
      designSize: Size(360, 780),
      builder: () => MaterialApp(
        theme: ThemeData.light().copyWith(
            primaryColor: Colors.yellow,
            colorScheme: ColorScheme.light(
                primary: Colors.black, secondary: Colors.default_color)),
        debugShowCheckedModeBanner: false,
        title: "Freed",
        home: SplashScreen(),
      ),
    ),
  );
}
