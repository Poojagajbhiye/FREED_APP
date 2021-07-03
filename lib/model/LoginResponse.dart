// To parse this JSON data, do
//
//     final signUpResponse = loginResponseFromJson(jsonString);

import 'dart:convert';

LoginResponse loginResponseFromJson(String str) =>
    LoginResponse.fromJson(json.decode(str));

String loginResponseToJson(LoginResponse data) => json.encode(data.toJson());

class LoginResponse {
  LoginResponse({
    this.msg,
    this.success,
    this.token,
  });

  String? msg;
  bool? success;
  String? token;

  factory LoginResponse.fromJson(Map<String, dynamic> json) => LoginResponse(
        msg: json["msg"],
        success: json["success"],
        token: json["token"],
      );

  Map<String, dynamic> toJson() => {
        "msg": msg,
        "success": success,
        "token": token,
      };
}
