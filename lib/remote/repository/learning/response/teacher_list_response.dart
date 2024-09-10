// To parse this JSON data, do
//
//     final teacherListResponse = teacherListResponseFromJson(jsonString);

import 'dart:convert';

List<TeacherListResponse> teacherListResponseFromJson(String str) => List<TeacherListResponse>.from(json.decode(str).map((x) => TeacherListResponse.fromJson(x)));

String teacherListResponseToJson(List<TeacherListResponse> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class TeacherListResponse {
  int? id;
  String? image;
  String? givenName;
  String? surname;
  String? fullname;
  bool? isMentor;
  bool? isSupervisor;
  bool? isPartner;
  bool? isActivityTeacher;
  bool? showAvailableHours;
  String? email;
  JobRole? jobRole;
  List<JobRole>? teacherActivities;
  List<JobRole>? teacherSubjects;
  int? userId;

  TeacherListResponse({
    this.id,
    this.image,
    this.givenName,
    this.surname,
    this.fullname,
    this.isMentor,
    this.isSupervisor,
    this.isPartner,
    this.isActivityTeacher,
    this.showAvailableHours,
    this.email,
    this.jobRole,
    this.teacherActivities,
    this.teacherSubjects,
    this.userId,
  });

  factory TeacherListResponse.fromJson(Map<String, dynamic> json) => TeacherListResponse(
    id: json["id"],
    image: json["image"],
    givenName: json["givenName"],
    surname: json["surname"],
    fullname: json["fullname"],
    isMentor: json["isMentor"],
    isSupervisor: json["isSupervisor"],
    isPartner: json["isPartner"],
    isActivityTeacher: json["isActivityTeacher"],
    showAvailableHours: json["showAvailableHours"],
    email: json["email"],
    jobRole: json["jobRole"] == null ? null : JobRole.fromJson(json["jobRole"]),
    teacherActivities: json["teacherActivities"] == null ? [] : List<JobRole>.from(json["teacherActivities"]!.map((x) => JobRole.fromJson(x))),
    teacherSubjects: json["teacherSubjects"] == null ? [] : List<JobRole>.from(json["teacherSubjects"]!.map((x) => JobRole.fromJson(x))),
    userId: json["userId"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "image" : image,
    "givenName": givenName,
    "surname": surname,
    "fullname": fullname,
    "isMentor": isMentor,
    "isSupervisor": isSupervisor,
    "isPartner": isPartner,
    "isActivityTeacher": isActivityTeacher,
    "showAvailableHours": showAvailableHours,
    "email": email,
    "jobRole": jobRole?.toJson(),
    "teacherActivities": teacherActivities == null ? [] : List<dynamic>.from(teacherActivities!.map((x) => x.toJson())),
    "teacherSubjects": teacherSubjects == null ? [] : List<dynamic>.from(teacherSubjects!.map((x) => x.toJson())),
    "userId": userId,
  };
}

class JobRole {
  int? id;
  String? description;

  JobRole({
    this.id,
    this.description,
  });

  factory JobRole.fromJson(Map<String, dynamic> json) => JobRole(
    id: json["id"],
    description: json["description"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "description": description,
  };
}
