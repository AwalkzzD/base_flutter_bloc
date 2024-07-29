// To parse this JSON data, do
//
//     final academicPeriodResponse = academicPeriodResponseFromJson(jsonString);

import 'dart:convert';

List<AcademicPeriodResponse> academicPeriodResponseFromJson(String str) => List<AcademicPeriodResponse>.from(json.decode(str).map((x) => AcademicPeriodResponse.fromJson(x)));

String academicPeriodResponseToJson(List<AcademicPeriodResponse> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class AcademicPeriodResponse {
  int? id;
  String? description;
  DateTime? startDate;
  DateTime? endDate;
  String? externalId;
  bool? isAdmission;
  bool? isDefault;
  int? positionOrder;

  AcademicPeriodResponse({
    this.id,
    this.description,
    this.startDate,
    this.endDate,
    this.externalId,
    this.isAdmission,
    this.isDefault,
    this.positionOrder,
  });

  factory AcademicPeriodResponse.fromJson(Map<dynamic, dynamic> json) => AcademicPeriodResponse(
    id: json["id"],
    description: json["description"],
    startDate: json["startDate"] == null ? null : DateTime.parse(json["startDate"]),
    endDate: json["endDate"] == null ? null : DateTime.parse(json["endDate"]),
    externalId: json["externalId"],
    isAdmission: json["isAdmission"],
    isDefault: json["isDefault"],
    positionOrder: json["positionOrder"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "description": description,
    "startDate": startDate?.toIso8601String(),
    "endDate": endDate?.toIso8601String(),
    "externalId": externalId,
    "isAdmission": isAdmission,
    "isDefault": isDefault,
    "positionOrder": positionOrder,
  };

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is AcademicPeriodResponse &&
            (identical(other.id, id) || other.id == id));
  }

  @override
  int get hashCode => Object.hash(runtimeType, id);
}
