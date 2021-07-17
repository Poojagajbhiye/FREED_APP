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
    this.id,
    this.rid,
    this.branch,
    this.course,
    this.email,
    this.firstName,
    this.lastName,
    this.semester,
  });

  String? id;
  String? rid;
  String? branch;
  String? course;
  String? email;
  String? firstName;
  String? lastName;
  String? semester;

  factory Decoded.fromJson(Map<String, dynamic> json) => Decoded(
        id: json["_id"],
        rid: json["RID"],
        branch: json["branch"],
        course: json["course"],
        email: json["email"],
        firstName: json["firstName"],
        lastName: json["lastName"],
        semester: json["semester"].toString(),
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "RID": rid,
        "branch": branch,
        "course": course,
        "email": email,
        "firstName": firstName,
        "lastName": lastName,
        "semester": semester,
      };
}
