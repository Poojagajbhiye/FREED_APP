import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;
import 'package:socket_io_client/socket_io_client.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class FreedNotification extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _FreedNotification();
  }
}

class _FreedNotification extends State<FreedNotification> {
  // StreamSocket streamSocket = StreamSocket();
  Socket? socket;
  TextEditingController textEditingController = TextEditingController();
  StreamController streamController = StreamController<String>();

  FlutterLocalNotificationsPlugin localNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  @override
  void initState() {
    connectToServer();
    initNotification();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("web socket"),
        ),
        body: Container(
          margin: EdgeInsets.symmetric(horizontal: 50),
          width: 1.sw,
          height: 1.sh,
          child: Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextFormField(
                  controller: textEditingController,
                  textAlign: TextAlign.center,
                  keyboardType: TextInputType.text,
                  style: TextStyle(fontSize: 18),
                  decoration: InputDecoration(hintText: "enter message here"),
                ),
                SizedBox(height: 20),
                ElevatedButton(
                    onPressed: () {
                      String inputmsg = textEditingController.text;
                      sendMsgtoServer(inputmsg);
                      //showNotification();
                    },
                    child: Text("Send")),
                SizedBox(height: 20),
                StreamBuilder(
                    stream: streamController.stream,
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        showNotification(snapshot.data.toString());
                      }
                      return Text("response: ${snapshot.data}");
                    })
              ],
            ),
          ),
        ));
  }

  sendMsgtoServer(String msg) {
    socket?.emit("msg from admin", msg);
  }

  connectToServer() {
    try {
      socket =
          IO.io('https://dco-leave-app-api.herokuapp.com/', <String, dynamic>{
        'transports': ['websocket'],
        'autoConnect': false,
      });

      socket?.connect();

      socket?.onConnect((data) => print("connected"));
      //socket?.emit("msg from admin", "hey im roshan");
      print(socket?.connected);
      socket?.on("msg to student", (data) => streamController.sink.add(data));
    } catch (e) {
      print(e);
    }
  }

  Future<void> showNotification(String msg) async {
    var androidDetails = AndroidNotificationDetails(
        "channelId", "channelName", "channelDescription");
    var generalNotification = NotificationDetails(android: androidDetails);
    await localNotificationsPlugin.show(
        1, "Message", "* $msg", generalNotification);
  }

  initNotification() {
    //localNotificationsPlugin = FlutterLocalNotificationsPlugin();
    var initializeAndroid = AndroidInitializationSettings('ic_launcher');
    var initializeSetting = InitializationSettings(android: initializeAndroid);
    localNotificationsPlugin.initialize(initializeSetting);
  }
}
