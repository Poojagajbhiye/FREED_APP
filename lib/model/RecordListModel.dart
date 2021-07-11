// To parse this JSON data, do
//
//     final recordListModel = recordListModelFromJson(jsonString);

import 'dart:convert';

RecordListModel recordListModelFromJson(String str) =>
    RecordListModel.fromJson(json.decode(str));

String recordListModelToJson(RecordListModel data) =>
    json.encode(data.toJson());

class RecordListModel {
  RecordListModel({
    this.success,
    this.records,
  });

  bool? success;
  List<Record>? records;

  factory RecordListModel.fromJson(Map<String, dynamic> json) =>
      RecordListModel(
        success: json["success"],
        records:
            List<Record>.from(json["records"].map((x) => Record.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "success": success,
        "records": List<dynamic>.from(records!.map((x) => x.toJson())),
      };
}

class Record {
  Record({
    this.issuedDate,
    this.status,
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
  String? status;
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
        status: json["status"],
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
        "status": status,
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
