// To parse this JSON data, do
//
//     final eventDetailResponse = eventDetailResponseFromJson(jsonString);

import 'dart:convert';

import '../../utils/files/file_element.dart';

EventDetailResponse eventDetailResponseFromJson(String str) =>
    EventDetailResponse.fromJson(json.decode(str));

String eventDetailResponseToJson(EventDetailResponse data) =>
    json.encode(data.toJson());

class EventDetailResponse {
  int? id;
  String? title;
  String? type;
  String? shortDescription;
  String? description;
  DateTime? startDate;
  DateTime? endDate;
  String? subject;
  String? group;
  String? location;
  EventCategory? eventCategory;
  bool? isRead;
  bool? useRsvp;
  String? response;
  OnlineMeeting? onlineMeeting;
  List<FileElement>? files;
  List<ChildrenResponse>? childrenResponses;
  int? creator;

  EventDetailResponse({
    this.id,
    this.title,
    this.type,
    this.shortDescription,
    this.description,
    this.startDate,
    this.endDate,
    this.subject,
    this.group,
    this.location,
    this.eventCategory,
    this.isRead,
    this.useRsvp,
    this.response,
    this.onlineMeeting,
    this.files,
    this.childrenResponses,
    this.creator,
  });

  factory EventDetailResponse.fromJson(Map<String, dynamic> json) =>
      EventDetailResponse(
        id: json["id"],
        title: json["title"],
        type: json["type"],
        shortDescription: json["shortDescription"],
        description: json["description"],
        startDate: json["startDate"] == null
            ? null
            : DateTime.parse(json["startDate"]),
        endDate:
            json["endDate"] == null ? null : DateTime.parse(json["endDate"]),
        subject: json["subject"],
        group: json["group"],
        location: json["location"],
        eventCategory: json["eventCategory"] == null
            ? null
            : EventCategory.fromJson(json["eventCategory"]),
        isRead: json["isRead"],
        useRsvp: json["useRSVP"],
        response: json["response"],
        onlineMeeting: json["onlineMeeting"] == null
            ? null
            : OnlineMeeting.fromJson(json["onlineMeeting"]),
        files: json["files"] == null
            ? []
            : List<FileElement>.from(
                json["files"]!.map((x) => FileElement.fromJson(x))),
        childrenResponses: json["childrenResponses"] == null
            ? []
            : List<ChildrenResponse>.from(json["childrenResponses"]!
                .map((x) => ChildrenResponse.fromJson(x))),
        creator: json["creator"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "title": title,
        "type": type,
        "shortDescription": shortDescription,
        "description": description,
        "startDate": startDate?.toIso8601String(),
        "endDate": endDate?.toIso8601String(),
        "subject": subject,
        "group": group,
        "location": location,
        "eventCategory": eventCategory?.toJson(),
        "isRead": isRead,
        "useRSVP": useRsvp,
        "response": response,
        "onlineMeeting": onlineMeeting?.toJson(),
        "files": files == null
            ? []
            : List<dynamic>.from(files!.map((x) => x.toJson())),
        "childrenResponses": childrenResponses == null
            ? []
            : List<dynamic>.from(childrenResponses!.map((x) => x.toJson())),
        "creator": creator,
      };
}

class ChildrenResponse {
  int? id;
  String? givenName;
  String? surname;
  String? fullname;
  String? response;

  ChildrenResponse({
    this.id,
    this.givenName,
    this.surname,
    this.fullname,
    this.response,
  });

  factory ChildrenResponse.fromJson(Map<String, dynamic> json) =>
      ChildrenResponse(
        id: json["id"],
        givenName: json["givenName"],
        surname: json["surname"],
        fullname: json["fullname"],
        response: json["response"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "givenName": givenName,
        "surname": surname,
        "fullname": fullname,
        "response": response,
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

class OnlineMeeting {
  bool? hasMeeting;
  String? password;

  OnlineMeeting({
    this.hasMeeting,
    this.password,
  });

  factory OnlineMeeting.fromJson(Map<String, dynamic> json) => OnlineMeeting(
        hasMeeting: json["hasMeeting"],
        password: json["password"],
      );

  Map<String, dynamic> toJson() => {
        "hasMeeting": hasMeeting,
        "password": password,
      };
}
