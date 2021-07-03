// To parse this JSON data, do
//
//     final signUpResponse = signUpResponseFromJson(jsonString);

import 'dart:convert';

SignUpResponse signUpResponseFromJson(String str) => SignUpResponse.fromJson(json.decode(str));

String signUpResponseToJson(SignUpResponse data) => json.encode(data.toJson());

class SignUpResponse {
    SignUpResponse({
        this.msg,
        this.success,
        this.result,
    });

    String? msg;
    bool? success;
    Result? result;

    factory SignUpResponse.fromJson(Map<String, dynamic> json) => SignUpResponse(
        msg: json["msg"],
        success: json["success"],
        // result: Result.fromJson(json["result"]),
    );

    Map<String, dynamic> toJson() => {
        "msg": msg,
        "success": success,
        "result": result?.toJson(),
    };
}

class Result {
    Result({
        this.records,
        this.id,
        this.rid,
        this.password,
        this.v,
    });

    List<dynamic>? records;
    String? id;
    String? rid;
    String? password;
    int? v;

    factory Result.fromJson(Map<String, dynamic> json) => Result(
        records: List<dynamic>.from(json["records"].map((x) => x)),
        id: json["_id"],
        rid: json["RID"],
        password: json["password"],
        v: json["__v"],
    );

    Map<String, dynamic> toJson() => {
        "records": List<dynamic>.from(records!.map((x) => x)),
        "_id": id,
        "RID": rid,
        "password": password,
        "__v": v,
    };
}
