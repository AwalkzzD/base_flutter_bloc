// To parse this JSON data, do
//
//     final learningStudentResponse = learningStudentResponseFromJson(jsonString);

import 'dart:convert';

List<LearningStudentResponse> learningStudentResponseFromJson(String str) => List<LearningStudentResponse>.from(json.decode(str).map((x) => LearningStudentResponse.fromJson(x)));

String learningStudentResponseToJson(List<LearningStudentResponse> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class LearningStudentResponse {
  int? id;
  String? imageUrl;
  Subject? subject;
  Grade? grade;
  String? stream;
  List<String>? teachers;
  String? description;
  String? microsoft365Url;
  int? moodleId;
  String? wordpressUrl;
  String? teamsUrl;
  String? teamsId;
  List<WeekprogramCategory>? weekprogramCategories;
  bool? hasActiveThesis;
  List<ActiveStudentThesis>? activeStudentTheses;
  bool? studentCanEnrollToThesisBasedOnOtherEnrollments;
  bool? studentApplDisabledApplyByCompanySetting;
  bool? awaitingForAcceptance;
  List<LearningRoom>? learningRooms;

  LearningStudentResponse({
    this.id,
    this.imageUrl,
    this.subject,
    this.grade,
    this.stream,
    this.teachers,
    this.description,
    this.microsoft365Url,
    this.moodleId,
    this.wordpressUrl,
    this.teamsUrl,
    this.teamsId,
    this.weekprogramCategories,
    this.hasActiveThesis,
    this.activeStudentTheses,
    this.studentCanEnrollToThesisBasedOnOtherEnrollments,
    this.studentApplDisabledApplyByCompanySetting,
    this.awaitingForAcceptance,
    this.learningRooms,
  });

  factory LearningStudentResponse.fromJson(Map<String, dynamic> json) => LearningStudentResponse(
    id: json["id"],
    imageUrl: json["imageUrl"],
    subject: json["subject"] == null ? null : Subject.fromJson(json["subject"]),
    grade: json["grade"] == null ? null : Grade.fromJson(json["grade"]),
    stream: json["stream"],
    teachers: json["teachers"] == null ? [] : List<String>.from(json["teachers"]!.map((x) => x)),
    description: json["description"],
    microsoft365Url: json["microsoft365Url"],
    moodleId: json["moodleId"],
    wordpressUrl: json["wordpressUrl"],
    teamsUrl: json["teamsUrl"],
    teamsId: json["teamsId"],
    weekprogramCategories: json["weekprogramCategories"] == null ? [] : List<WeekprogramCategory>.from(json["weekprogramCategories"]!.map((x) => WeekprogramCategory.fromJson(x))),
    hasActiveThesis: json["hasActiveThesis"],
    activeStudentTheses: json["activeStudentTheses"] == null ? [] : List<ActiveStudentThesis>.from(json["activeStudentTheses"]!.map((x) => ActiveStudentThesis.fromJson(x))),
    studentCanEnrollToThesisBasedOnOtherEnrollments: json["studentCanEnrollToThesisBasedOnOtherEnrollments"],
    studentApplDisabledApplyByCompanySetting: json["studentApplDisabledApplyByCompanySetting"],
    awaitingForAcceptance: json["awaitingForAcceptance"],
    learningRooms: json["learningRooms"] == null ? [] : List<LearningRoom>.from(json["learningRooms"]!.map((x) => LearningRoom.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "imageUrl": imageUrl,
    "subject": subject?.toJson(),
    "grade": grade?.toJson(),
    "stream": stream,
    "teachers": teachers == null ? [] : List<dynamic>.from(teachers!.map((x) => x)),
    "description": description,
    "microsoft365Url": microsoft365Url,
    "moodleId": moodleId,
    "wordpressUrl": wordpressUrl,
    "teamsUrl": teamsUrl,
    "teamsId": teamsId,
    "weekprogramCategories": weekprogramCategories == null ? [] : List<dynamic>.from(weekprogramCategories!.map((x) => x.toJson())),
    "hasActiveThesis": hasActiveThesis,
    "activeStudentTheses": activeStudentTheses == null ? [] : List<dynamic>.from(activeStudentTheses!.map((x) => x.toJson())),
    "studentCanEnrollToThesisBasedOnOtherEnrollments": studentCanEnrollToThesisBasedOnOtherEnrollments,
    "studentApplDisabledApplyByCompanySetting": studentApplDisabledApplyByCompanySetting,
    "awaitingForAcceptance": awaitingForAcceptance,
    "learningRooms": learningRooms == null ? [] : List<dynamic>.from(learningRooms!.map((x) => x.toJson())),
  };
}

class ActiveStudentThesis {
  int? studentThesisId;
  String? title;

  ActiveStudentThesis({
    this.studentThesisId,
    this.title,
  });

  factory ActiveStudentThesis.fromJson(Map<String, dynamic> json) => ActiveStudentThesis(
    studentThesisId: json["studentThesisId"],
    title: json["title"],
  );

  Map<String, dynamic> toJson() => {
    "studentThesisId": studentThesisId,
    "title": title,
  };
}

class Grade {
  String? id;
  String? description;

  Grade({
    this.id,
    this.description,
  });

  factory Grade.fromJson(Map<String, dynamic> json) => Grade(
    id: json["id"],
    description: json["description"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "description": description,
  };
}

class LearningRoom {
  int? id;
  String? title;
  bool? isRoomForSubject;

  LearningRoom({
    this.id,
    this.title,
    this.isRoomForSubject,
  });

  factory LearningRoom.fromJson(Map<String, dynamic> json) => LearningRoom(
    id: json["id"],
    title: json["title"],
    isRoomForSubject: json["isRoomForSubject"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "title": title,
    "isRoomForSubject": isRoomForSubject,
  };
}

class Subject {
  int? id;
  String? description;
  String? color;
  int? crossPeriodCode;
  String? subjectType;

  Subject({
    this.id,
    this.description,
    this.color,
    this.crossPeriodCode,
    this.subjectType,
  });

  factory Subject.fromJson(Map<String, dynamic> json) => Subject(
    id: json["id"],
    description: json["description"],
    color: json["color"],
    crossPeriodCode: json["crossPeriodCode"],
    subjectType: json["subjectType"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "description": description,
    "color": color,
    "crossPeriodCode": crossPeriodCode,
    "subjectType": subjectType,
  };
}

class WeekprogramCategory {
  int? id;
  String? description;
  bool? isDefault;
  DateTime? lockDate;

  WeekprogramCategory({
    this.id,
    this.description,
    this.isDefault,
    this.lockDate,
  });

  factory WeekprogramCategory.fromJson(Map<String, dynamic> json) => WeekprogramCategory(
    id: json["id"],
    description: json["description"],
    isDefault: json["isDefault"],
    lockDate: json["lockDate"] == null ? null : DateTime.parse(json["lockDate"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "description": description,
    "isDefault": isDefault,
    "lockDate": lockDate?.toIso8601String(),
  };
}
