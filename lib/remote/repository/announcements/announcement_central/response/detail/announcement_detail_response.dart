import 'dart:convert';

import '../../../../utils/files/file_element.dart';
import '../event_category.dart';
import '../online_meeting.dart';

AnnouncementDetailResponse announcementDetailsResponseFromJson(String str) {
  final Map<String, dynamic> jsonData = json.decode(str);
  return AnnouncementDetailResponse.fromJson(jsonData);
}

class AnnouncementDetailResponse {
  AnnouncementDetailResponse({
    required this.id,
    required this.title,
    required this.type,
    required this.shortDescription,
    required this.description,
    required this.startDate,
    required this.endDate,
    required this.subject,
    required this.group,
    required this.location,
    required this.eventCategory,
    required this.isRead,
    required this.useRsvp,
    required this.response,
    required this.onlineMeeting,
    required this.files,
    required this.childrenResponses,
    required this.creator,
  });

  final int? id;
  final String? title;
  final String? type;
  final String? shortDescription;
  final String? description;
  final DateTime? startDate;
  final DateTime? endDate;
  final String? subject;
  final String? group;
  final String? location;
  final EventCategory? eventCategory;
  final bool? isRead;
  final bool? useRsvp;
  final dynamic response;
  final OnlineMeeting? onlineMeeting;
  List<FileElement>? files;
  final List<dynamic> childrenResponses;
  final int? creator;

  factory AnnouncementDetailResponse.fromJson(Map<String, dynamic> json) {
    return AnnouncementDetailResponse(
      id: json["id"],
      title: json["title"],
      type: json["type"],
      shortDescription: json["shortDescription"],
      description: json["description"],
      startDate: DateTime.tryParse(json["startDate"] ?? ""),
      endDate: DateTime.tryParse(json["endDate"] ?? ""),
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
          : List<dynamic>.from(json["childrenResponses"]!.map((x) => x)),
      creator: json["creator"],
    );
  }

  Map<String, dynamic> toJson() {
    return {
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
      "files": files,
      "childrenResponses": childrenResponses,
      "creator": creator,
    };
  }
}
