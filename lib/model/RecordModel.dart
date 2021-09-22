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
    this.deviceId,
    this.issuedDate,
    this.status,
    this.id,
    this.rid,
    this.student,
    this.from,
    this.to,
    this.destination,
    this.reason,
    this.v,
    this.remarkByWarden,
    this.approval,
  });

String? deviceId;
  DateTime? issuedDate;
  String? status;
  String? id;
  String? rid;
  Student? student;
  DateTime? from;
  DateTime? to;
  String? destination;
  String? reason;
  int? v;
  RemarkByWarden? remarkByWarden;
  Approval? approval;

  factory Record.fromJson(Map<String, dynamic> json) => Record(
    deviceId: json["device_id"],
        issuedDate: DateTime.parse(json["issuedDate"]),
        status: json["status"],
        id: json["_id"],
        rid: json["RID"],
        student: Student.fromJson(json["student"]),
        from: DateTime.parse(json["from"]),
        to: DateTime.parse(json["to"]),
        destination: json["destination"],
        reason: json["reason"],
        v: json["__v"],
        remarkByWarden: json["remark_by_warden"] == null ? null : RemarkByWarden.fromJson(json["remark_by_warden"]),
        approval: json["approval"] == null ? null : Approval.fromJson(json["approval"]),
      );

  Map<String, dynamic> toJson() => {
    "device_id": deviceId,
        "issuedDate": issuedDate?.toIso8601String(),
        "status": status,
        "_id": id,
        "RID": rid,
        "student": student?.toJson(),
        "from": from?.toIso8601String(),
        "to": to?.toIso8601String(),
        "destination": destination,
        "reason": reason,
        "__v": v,
        "remark_by_warden": remarkByWarden?.toJson(),
        "approval": approval?.toJson(),
      };
}

class Approval {
    Approval({
        this.accepted,
        this.sentForApproval,
        this.declined,
        this.id,
        this.sentForApprovalBy,
        this.declinedBy,
        this.remark,
    });

    bool? accepted;
    bool? sentForApproval;
    bool? declined;
    String? id;
    ApproveBy? sentForApprovalBy;
    ApproveBy? declinedBy;
    String? remark;

    factory Approval.fromJson(Map<String, dynamic> json) => Approval(
        accepted: json["accepted"],
        sentForApproval: json["sent_for_approval"],
        declined: json["declined"],
        id: json["_id"],
        sentForApprovalBy: json["sent_for_approval_by"] == null ? null : ApproveBy.fromJson(json["sent_for_approval_by"]),
        declinedBy: json["declined_by"] == null ? null : ApproveBy.fromJson(json["declined_by"]),
        remark: json["remark"],
    );

    Map<String, dynamic> toJson() => {
        "accepted": accepted,
        "sent_for_approval": sentForApproval,
        "declined": declined,
        "_id": id,
        "sent_for_approval_by": sentForApprovalBy?.toJson(),
        "declined_by": declinedBy?.toJson(),
        "remark": remark,
    };
}

class ApproveBy {
    ApproveBy({
        this.id,
        this.firstname,
        this.lastname,
        this.email,
        this.contact,
    });

    String? id;
    String? firstname;
    String? lastname;
    String? email;
    int? contact;

    factory ApproveBy.fromJson(Map<String, dynamic> json) => ApproveBy(
        id: json["_id"],
        firstname: json["firstname"],
        lastname: json["lastname"],
        email: json["email"],
        contact: json["contact"],
    );

    Map<String, dynamic> toJson() => {
        "_id": id,
        "firstname": firstname,
        "lastname": lastname,
        "email": email,
        "contact": contact,
    };
}

class RemarkByWarden {
    RemarkByWarden({
        this.by,
        this.msg,
    });

    By? by;
    String? msg;

    factory RemarkByWarden.fromJson(Map<String, dynamic> json) => RemarkByWarden(
        by: By.fromJson(json["by"]),
        msg: json["msg"],
    );

    Map<String, dynamic> toJson() => {
        "by": by,
        "msg": msg,
    };
}

class By {
    By({
        this.adminIs,
        this.id,
        this.firstname,
        this.lastname,
        this.contact,
    });

    String? adminIs;
    String? id;
    String? firstname;
    String? lastname;
    int? contact;

    factory By.fromJson(Map<String, dynamic> json) => By(
        adminIs: json["adminIs"],
        id: json["_id"],
        firstname: json["firstname"],
        lastname: json["lastname"],
        contact: json["contact"],
    );

    Map<String, dynamic> toJson() => {
        "adminIs": adminIs,
        "_id": id,
        "firstname": firstname,
        "lastname": lastname,
        "contact": contact,
    };
}

class Student {
  Student({
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

  factory Student.fromJson(Map<String, dynamic> json) => Student(
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
