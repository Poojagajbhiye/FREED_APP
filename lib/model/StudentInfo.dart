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
    this.branch,
    this.course,
    this.email,
    this.firstName,
    this.lastName,
    this.semester,
    this.updatedAt,
  });

  Contact? contact;
  String? id;
  String? rid;
  String? branch;
  String? course;
  String? email;
  String? firstName;
  String? lastName;
  String? semester;
  DateTime? updatedAt;

  factory Decoded.fromJson(Map<String, dynamic> json) => Decoded(
        contact: Contact.fromJson(json["contact"]),
        id: json["_id"],
        rid: json["RID"],
        branch: json["branch"],
        course: json["course"],
        email: json["email"],
        firstName: json["firstName"],
        lastName: json["lastName"],
        semester: json["semester"].toString(),
        updatedAt: DateTime.parse(json["updatedAt"]),
      );

  Map<String, dynamic> toJson() => {
        "contact": contact?.toJson(),
        "_id": id,
        "RID": rid,
        "branch": branch,
        "course": course,
        "email": email,
        "firstName": firstName,
        "lastName": lastName,
        "semester": semester,
        "updatedAt": updatedAt?.toIso8601String(),
      };
}

class Contact {
  Contact({
    this.personal,
    this.guardian,
  });

  String? personal;
  String? guardian;

  factory Contact.fromJson(Map<String, dynamic> json) => Contact(
        personal: json["personal"].toString(),
        guardian: json["guardian"].toString(),
      );

  Map<String, dynamic> toJson() => {
        "personal": personal,
        "guardian": guardian,
      };
}
