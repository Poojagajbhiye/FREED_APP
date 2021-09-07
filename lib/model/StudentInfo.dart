// To parse this JSON data, do
//
//     final studentInfo = studentInfoFromJson(jsonString);

import 'dart:convert';

StudentInfo studentInfoFromJson(String str) =>
    StudentInfo.fromJson(json.decode(str));

String studentInfoToJson(StudentInfo data) => json.encode(data.toJson());

class StudentInfo {
  StudentInfo({
    this.success,
    this.decoded,
  });

  bool? success;
  Decoded? decoded;

  factory StudentInfo.fromJson(Map<String, dynamic> json) => StudentInfo(
        success: json["success"],
        decoded: Decoded.fromJson(json["decoded"]),
      );

  Map<String, dynamic> toJson() => {
        "success": success,
        "decoded": decoded?.toJson(),
      };
}

class Decoded {
  Decoded({
    this.contact,
    this.id,
    this.rid,
    this.createdAt,
    this.updatedAt,
    this.branch,
    this.course,
    this.email,
    this.firstName,
    this.lastName,
    this.semester,
    this.gender,
    this.roomNo,
  });

  Contact? contact;
  String? id;
  String? rid;
  DateTime? createdAt;
  DateTime? updatedAt;
  String? branch;
  String? course;
  String? email;
  String? firstName;
  String? lastName;
  int? semester;
  String? gender;
  String? roomNo;

  factory Decoded.fromJson(Map<String, dynamic> json) => Decoded(
        contact: json["contact"] == null ? null : Contact.fromJson(json["contact"]),
        id: json["_id"],
        rid: json["RID"],
        createdAt: DateTime.parse(json["createdAt"]),
        updatedAt: DateTime.parse(json["updatedAt"]),
        branch: json["branch"],
        course: json["course"],
        email: json["email"],
        firstName: json["firstName"],
        lastName: json["lastName"],
        semester: json["semester"],
        gender: json["gender"],
        roomNo: json["room_no"],
      );

  Map<String, dynamic> toJson() => {
        "contact": contact?.toJson(),
        "_id": id,
        "RID": rid,
        "createdAt": createdAt?.toIso8601String(),
        "updatedAt": updatedAt?.toIso8601String(),
        "branch": branch,
        "course": course,
        "email": email,
        "firstName": firstName,
        "lastName": lastName,
        "semester": semester,
        "gender": gender,
        "room_no": roomNo,
      };
}

class Contact {
  Contact({
    this.personal,
    this.guardian,
  });

  int? personal;
  int? guardian;

  factory Contact.fromJson(Map<String, dynamic> json) => Contact(
        personal: json["personal"],
        guardian: json["guardian"],
      );

  Map<String, dynamic> toJson() => {
        "personal": personal,
        "guardian": guardian,
      };
}
