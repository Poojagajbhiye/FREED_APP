import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:web_socket_channel/io.dart';
import 'package:web_socket_channel/status.dart' as status;

class FreedNotification extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _FreedNotification();
  }
}

class _FreedNotification extends State<FreedNotification> {
  final channel = IOWebSocketChannel.connect(
      Uri.parse("wss://dco-leave-app-api.herokuapp.com"));

  @override
  void initState() {
    channel.stream.listen((message) {
      channel.sink.add("6109de65a8529e00042a7fd8");
      //channel.sink.close(status.goingAway);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("web socket"),
        ),
        body: Container(
          width: 1.sw,
          height: 1.sh,
          child: Center(
            child: StreamBuilder(
                stream: channel.stream,
                builder: (context, snapshot) {
                  return Text(
                      "connection response ${snapshot.hasData ? snapshot.data : 'null'}");
                }),
          ),
        ));
  }
}
