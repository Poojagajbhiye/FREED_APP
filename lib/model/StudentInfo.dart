// To parse this JSON data, do
//
//     final studentInfo = studentInfoFromJson(jsonString);

import 'dart:convert';

StudentInfo studentInfoFromJson(String str) => StudentInfo.fromJson(json.decode(str));

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
    });

    String? id;
    String? rid;

    factory Decoded.fromJson(Map<String, dynamic> json) => Decoded(
        id: json["_id"],
        rid: json["RID"],
    );

    Map<String, dynamic> toJson() => {
        "_id": id,
        "RID": rid,
    };
}
