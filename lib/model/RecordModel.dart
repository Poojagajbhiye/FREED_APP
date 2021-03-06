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
  Record? record;

  factory RecordModel.fromJson(Map<String, dynamic> json) => RecordModel(
        success: json["success"],
        record: Record.fromJson(json["record"]),
      );

  Map<String, dynamic> toJson() => {
        "success": success,
        "record": record?.toJson(),
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
  StudentId? studentId;
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
        studentId: StudentId.fromJson(json["studentId"]),
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
        "studentId": studentId?.toJson(),
        "from": from?.toIso8601String(),
        "to": to?.toIso8601String(),
        "destination": destination,
        "reason": reason,
        "__v": v,
      };
}

class StudentId {
  StudentId({
    this.id,
    this.rid,
    this.v,
    this.branch,
    this.course,
    this.email,
    this.firstName,
    this.lastName,
    this.semester,
  });

  String? id;
  String? rid;
  int? v;
  String? branch;
  String? course;
  String? email;
  String? firstName;
  String? lastName;
  int? semester;

  factory StudentId.fromJson(Map<String, dynamic> json) => StudentId(
        id: json["_id"],
        rid: json["RID"],
        v: json["__v"],
        branch: json["branch"],
        course: json["course"],
        email: json["email"],
        firstName: json["firstName"],
        lastName: json["lastName"],
        semester: json["semester"],
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "RID": rid,
        "__v": v,
        "branch": branch,
        "course": course,
        "email": email,
        "firstName": firstName,
        "lastName": lastName,
        "semester": semester,
      };
}
