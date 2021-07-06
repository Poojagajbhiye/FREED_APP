// To parse this JSON data, do
//
//     final newleaveResponse = newleaveResponseFromJson(jsonString);

import 'dart:convert';

NewleaveResponse newleaveResponseFromJson(String str) => NewleaveResponse.fromJson(json.decode(str));

String newleaveResponseToJson(NewleaveResponse data) => json.encode(data.toJson());

class NewleaveResponse {
    NewleaveResponse({
        this.msg,
        this.success,
        this.result,
    });

    String? msg;
    bool? success;
    Result? result;

    factory NewleaveResponse.fromJson(Map<String, dynamic> json) => NewleaveResponse(
        msg: json["msg"],
        success: json["success"],
        result: Result.fromJson(json["result"]),
    );

    Map<String, dynamic> toJson() => {
        "msg": msg,
        "success": success,
        "result": result?.toJson(),
    };
}

class Result {
    Result({
        this.issuedDate,
        this.permitted,
        this.id,
        this.rid,
        this.studentId,
        this.from,
        this.to,
        this.destination,
        this.reason,
        this.v,
    });

    DateTime? issuedDate;
    bool? permitted;
    String? id;
    String? rid;
    String? studentId;
    DateTime? from;
    DateTime? to;
    String? destination;
    String? reason;
    int? v;

    factory Result.fromJson(Map<String, dynamic> json) => Result(
        issuedDate: DateTime.parse(json["issuedDate"]),
        permitted: json["permitted"],
        id: json["_id"],
        rid: json["RID"],
        studentId: json["studentId"],
        from: DateTime.parse(json["from"]),
        to: DateTime.parse(json["to"]),
        destination: json["destination"],
        reason: json["reason"],
        v: json["__v"],
    );

    Map<String, dynamic> toJson() => {
        "issuedDate": issuedDate?.toIso8601String(),
        "permitted": permitted,
        "_id": id,
        "RID": rid,
        "studentId": studentId,
        "from": from?.toIso8601String(),
        "to": to?.toIso8601String(),
        "destination": destination,
        "reason": reason,
        "__v": v,
    };
}
