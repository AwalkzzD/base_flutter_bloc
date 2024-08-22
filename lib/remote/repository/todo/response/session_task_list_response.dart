// To parse this JSON data, do
//
//     final sessionTaskListResponse = sessionTaskListResponseFromJson(jsonString);

import 'dart:convert';

List<SessionTaskListResponse> sessionTaskListResponseFromJson(String str) =>
    List<SessionTaskListResponse>.from(
        json.decode(str).map((x) => SessionTaskListResponse.fromJson(x)))
      ..sort((task1, task2) => task1.startDate?.compareTo(task2.startDate!) == 0
          ? (task1.endDate ?? DateTime.now()).compareTo(task2.endDate ?? DateTime.now())
          : (task1.startDate ?? DateTime.now()).compareTo(task2.startDate ?? DateTime.now()));

String sessionTaskListResponseToJson(List<SessionTaskListResponse> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class SessionTaskListResponse {
  int? id;
  String? type;
  DateTime? startDate;
  DateTime? endDate;
  List<Teacher>? teachers;
  List<Subject>? subjects;
  List<ClassRoom>? groups;
  List<ClassRoom>? classRooms;
  List<Period>? periods;

  SessionTaskListResponse({
    this.id,
    this.type,
    this.startDate,
    this.endDate,
    this.teachers,
    this.subjects,
    this.groups,
    this.classRooms,
    this.periods,
  });

  factory SessionTaskListResponse.fromJson(Map<String, dynamic> json) => SessionTaskListResponse(
    id: json["id"],
    type: json["type"],
    startDate: json["startDate"] == null ? null : DateTime.parse(json["startDate"]),
    endDate: json["endDate"] == null ? null : DateTime.parse(json["endDate"]),
    teachers: json["teachers"] == null ? [] : List<Teacher>.from(json["teachers"]!.map((x) => Teacher.fromJson(x))),
    subjects: json["subjects"] == null ? [] : List<Subject>.from(json["subjects"]!.map((x) => Subject.fromJson(x))),
    groups: json["groups"] == null ? [] : List<ClassRoom>.from(json["groups"]!.map((x) => ClassRoom.fromJson(x))),
    classRooms: json["classRooms"] == null ? [] : List<ClassRoom>.from(json["classRooms"]!.map((x) => ClassRoom.fromJson(x))),
    periods: json["periods"] == null ? [] : List<Period>.from(json["periods"]!.map((x) => Period.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "type": type,
    "startDate": startDate?.toIso8601String(),
    "endDate": endDate?.toIso8601String(),
    "teachers": teachers == null ? [] : List<dynamic>.from(teachers!.map((x) => x.toJson())),
    "subjects": subjects == null ? [] : List<dynamic>.from(subjects!.map((x) => x.toJson())),
    "groups": groups == null ? [] : List<dynamic>.from(groups!.map((x) => x.toJson())),
    "classRooms": classRooms == null ? [] : List<dynamic>.from(classRooms!.map((x) => x.toJson())),
    "periods": periods == null ? [] : List<dynamic>.from(periods!.map((x) => x.toJson())),
  };
}

class ClassRoom {
  int? id;
  String? description;

  ClassRoom({
    this.id,
    this.description,
  });

  factory ClassRoom.fromJson(Map<String, dynamic> json) => ClassRoom(
    id: json["id"],
    description: json["description"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "description": description,
  };
}

class Period {
  int? id;
  String? description;
  String? from;
  String? to;
  int? order;

  Period({
    this.id,
    this.description,
    this.from,
    this.to,
    this.order,
  });

  factory Period.fromJson(Map<String, dynamic> json) => Period(
    id: json["id"],
    description: json["description"],
    from: json["from"],
    to: json["to"],
    order: json["order"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "description": description,
    "from": from,
    "to": to,
    "order": order,
  };
}

class Subject {
  int? id;
  String? description;
  String? color;

  Subject({
    this.id,
    this.description,
    this.color,
  });

  factory Subject.fromJson(Map<String, dynamic> json) => Subject(
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

class Teacher {
  int? id;
  String? givenName;
  String? surname;

  Teacher({
    this.id,
    this.givenName,
    this.surname,
  });

  factory Teacher.fromJson(Map<String, dynamic> json) => Teacher(
    id: json["id"],
    givenName: json["givenName"],
    surname: json["surname"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "givenName": givenName,
    "surname": surname,
  };
}