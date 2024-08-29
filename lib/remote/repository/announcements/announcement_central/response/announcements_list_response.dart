import 'dart:convert';

import 'event_category.dart';

List<AnnouncementsListResponse> announcementResponseFromJson(String str) =>
    List<AnnouncementsListResponse>.from(
        json.decode(str).map((x) => AnnouncementsListResponse.fromJson(x)));

String announcementListResponseToJson(List<AnnouncementsListResponse> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class AnnouncementsListResponse {
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

  AnnouncementsListResponse(
      {this.id,
      this.subject,
      this.type,
      this.shortDescription,
      this.startDate,
      this.endDate,
      this.location,
      this.eventCategory,
      this.isRead,
      this.creator});

  AnnouncementsListResponse.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    subject = json['subject'];
    type = json['type'];
    shortDescription = json['shortDescription'];
    startDate =
        json["startDate"] == null ? null : DateTime.parse(json["startDate"]);
    endDate = json["endDate"] == null ? null : DateTime.parse(json["endDate"]);
    // startDate = json['startDate'];
    //  endDate = json['endDate'];
    location = json['location'];
    eventCategory = json['eventCategory'] != null
        ? new EventCategory.fromJson(json['eventCategory'])
        : null;
    isRead = json['isRead'];
    creator = json['creator'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['subject'] = this.subject;
    data['type'] = this.type;
    data['shortDescription'] = this.shortDescription;
    data['startDate'] = this.startDate;
    data['endDate'] = this.endDate;
    data['location'] = this.location;
    if (this.eventCategory != null) {
      data['eventCategory'] = this.eventCategory!.toJson();
    }
    data['isRead'] = this.isRead;
    data['creator'] = this.creator;
    return data;
  }
}
