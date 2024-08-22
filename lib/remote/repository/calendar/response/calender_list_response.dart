// To parse this JSON data, do
//
//     final calenderListResponse = calenderListResponseFromJson(jsonString);

import 'dart:convert';

List<CalenderListResponse> calenderListResponseFromJson(String str) => List<CalenderListResponse>.from(json.decode(str).map((x) => CalenderListResponse.fromJson(x)));

String calenderListResponseToJson(List<CalenderListResponse> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class CalenderListResponse {
  int? id;
  String? subject;
  String? type;
  String? shortDescription;
  DateTime? startDate;
  DateTime? endDate;
  String? location;
  EventCategory? eventCategory;
  bool? isRead;
  int? creator;

  CalenderListResponse({
    this.id,
    this.subject,
    this.type,
    this.shortDescription,
    this.startDate,
    this.endDate,
    this.location,
    this.eventCategory,
    this.isRead,
    this.creator,
  });

  factory CalenderListResponse.fromJson(Map<String, dynamic> json) => CalenderListResponse(
    id: json["id"],
    subject: json["subject"],
    type: json["type"],
    shortDescription: json["shortDescription"],
    startDate: json["startDate"] == null ? null : DateTime.parse(json["startDate"]),
    endDate: json["endDate"] == null ? null : DateTime.parse(json["endDate"]),
    location: json["location"],
    eventCategory: json["eventCategory"] == null ? null : EventCategory.fromJson(json["eventCategory"]),
    isRead: json["isRead"],
    creator: json["creator"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "subject": subject,
    "type": type,
    "shortDescription": shortDescription,
    "startDate": startDate?.toIso8601String(),
    "endDate": endDate?.toIso8601String(),
    "location": location,
    "eventCategory": eventCategory?.toJson(),
    "isRead": isRead,
    "creator": creator,
  };
}

class EventCategory {
  int? id;
  String? description;
  String? color;

  EventCategory({
    this.id,
    this.description,
    this.color,
  });

  factory EventCategory.fromJson(Map<String, dynamic> json) => EventCategory(
    id: json["id"],
    description: json["description"],
    color: json["color"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "description": description,
    "color": color,
  };
}
