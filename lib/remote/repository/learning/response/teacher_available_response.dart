// To parse this JSON data, do
//
//     final teacherAvailableListResponse = teacherAvailableListResponseFromJson(jsonString);

import 'dart:convert';

List<TeacherAvailableListResponse> teacherAvailableListResponseFromJson(String str) => List<TeacherAvailableListResponse>.from(json.decode(str).map((x) => TeacherAvailableListResponse.fromJson(x)));

String teacherAvailableListResponseToJson(List<TeacherAvailableListResponse> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class TeacherAvailableListResponse {
  int? id;
  String? description;
  String? day;
  String? timeFrom;
  String? timeTo;
  String? availabilityType;
  DateTime? startDate;
  DateTime? endDate;
  String? concernType;

  TeacherAvailableListResponse({
    this.id,
    this.description,
    this.day,
    this.timeFrom,
    this.timeTo,
    this.availabilityType,
    this.startDate,
    this.endDate,
    this.concernType,
  });

  factory TeacherAvailableListResponse.fromJson(Map<String, dynamic> json) => TeacherAvailableListResponse(
    id: json["id"],
    description: json["description"],
    day: json["day"],
    timeFrom: json["timeFrom"],
    timeTo: json["timeTo"],
    availabilityType: json["availabilityType"],
    startDate: json["startDate"] == null ? null : DateTime.parse(json["startDate"]),
    endDate: json["endDate"] == null ? null : DateTime.parse(json["endDate"]),
    concernType: json["concernType"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "description": description,
    "day": day,
    "timeFrom": timeFrom,
    "timeTo": timeTo,
    "availabilityType": availabilityType,
    "startDate": startDate?.toIso8601String(),
    "endDate": endDate?.toIso8601String(),
    "concernType": concernType,
  };
}
