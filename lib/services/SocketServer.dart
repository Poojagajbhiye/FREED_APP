import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;
import 'package:socket_io_client/socket_io_client.dart';

class SocketServer {
  static Socket? socket;

  static StreamController streamController = StreamController();

  static void connect() {
    try {
      socket =
          IO.io('https://dco-leave-app-api.herokuapp.com/', <String, dynamic>{
        'transports': ['websocket'],
        'autoConnect': true,
      });
      socket?.connect();

      socket?.onConnect((data) => print("connected"));
      print(socket?.connected);
    } catch (e) {
      print("connection failed");
    }
  }

  static void join({@required String? studentId}) {
    socket?.emit("join", studentId);
  }

  static void initListen() {
    socket?.on("msg to student", (data) => streamController.sink.add(data));
  }
}
