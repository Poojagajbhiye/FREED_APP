// To parse this JSON data, do
//
//     final recordModel = recordModelFromJson(jsonString);

import 'dart:convert';

RecordModel recordModelFromJson(String str) =>
    RecordModel.fromJson(json.decode(str));

String recordModelToJson(RecordModel data) => json.encode(data.toJson());

class RecordModel {
  RecordModel({
    this.success,
    this.record,
  });

  bool? success;
  List<Record>? record;

  factory RecordModel.fromJson(Map<String, dynamic> json) => RecordModel(
        success: json["success"],
        record:
            List<Record>.from(json["record"].map((x) => Record.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "success": success,
        "record": List<dynamic>.from(record!.map((x) => x.toJson())),
      };
}

class Record {
  Record({
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

  factory Record.fromJson(Map<String, dynamic> json) => Record(
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
