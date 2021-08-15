import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;
import 'package:socket_io_client/socket_io_client.dart';

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

  @override
  void initState() {
    connectToServer();
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
                    },
                    child: Text("Send")),
                SizedBox(height: 20),
                StreamBuilder(
                    stream: streamController.stream,
                    builder: (context, snapshot) {
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

  //STEP2: Add this function in main function in main.dart file and add incoming data to the stream
  // void connectAndListen() {
  //   try {
  //     socket = io('https://dco-leave-app-api.herokuapp.com/',
  //         OptionBuilder().setTransports(['websocket']).build());

  //     socket?.onConnect((_) {
  //       print('connect: ${socket?.id}');
  //       socket?.emit('msg from admin', 'test message');
  //     });

  //     //When an event recieved from server, data is added to the stream
  //     socket?.on('message', (data) => streamSocket.addResponse);
  //     //socket?.on('typing', fromAdmin());
  //     socket?.onDisconnect((_) => print('disconnect'));
  //   } catch (e) {
  //     print(e);
  //   }

  //   fromAdmin() {
  //     socket?.emit("msg from admin", "hello roshan");
  //   }
  // }
}

// STEP1:  Stream setup
// class StreamSocket {
//   final _socketResponse = StreamController<String>();

//   void Function(String) get addResponse => _socketResponse.sink.add;

//   Stream<String> get getResponse => _socketResponse.stream;

//   void dispose() {
//     _socketResponse.close();
//   }
// }
