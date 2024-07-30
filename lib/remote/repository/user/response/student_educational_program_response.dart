// To parse this JSON data, do
//
//     final studentEducationalProgramResponse = studentEducationalProgramResponseFromJson(jsonString);

import 'dart:convert';

List<StudentEducationalProgramResponse> studentEducationalProgramResponseFromJson(String str) => List<StudentEducationalProgramResponse>.from(json.decode(str).map((x) => StudentEducationalProgramResponse.fromJson(x)));

String studentEducationalProgramResponseToJson(List<StudentEducationalProgramResponse> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class StudentEducationalProgramResponse {
  int? id;
  EducationalProgramSpecialization? grade;
  EducationalProgramSpecialization? stream;
  EducationalProgramSpecialization? registrationStatus;
  EducationalProgramSpecialization? educationalProgramSpecialization;
  EducationalProgramSpecialization? gradingStructure;
  EducationalProgramSpecialization? pricingCategory;
  String? educationalProgramCode;
  DateTime? startDate;
  DateTime? endDate;
  DateTime? firstContactDate;
  DateTime? statusDate;
  String? comments;
  EducationalProgramSpecialization? formStatus;
  EducationalProgramSpecialization? formStatus2;
  EducationalProgramSpecialization? location;
  String? academicPeriod;

  StudentEducationalProgramResponse({
    this.id,
    this.grade,
    this.stream,
    this.registrationStatus,
    this.educationalProgramSpecialization,
    this.gradingStructure,
    this.pricingCategory,
    this.educationalProgramCode,
    this.startDate,
    this.endDate,
    this.firstContactDate,
    this.statusDate,
    this.comments,
    this.formStatus,
    this.formStatus2,
    this.location,
    this.academicPeriod,
  });

  factory StudentEducationalProgramResponse.fromJson(Map<String, dynamic> json) => StudentEducationalProgramResponse(
    id: json["id"],
    grade: json["grade"] == null ? null : EducationalProgramSpecialization.fromJson(json["grade"]),
    stream: json["stream"] == null ? null : EducationalProgramSpecialization.fromJson(json["stream"]),
    registrationStatus: json["registrationStatus"] == null ? null : EducationalProgramSpecialization.fromJson(json["registrationStatus"]),
    educationalProgramSpecialization: json["educationalProgramSpecialization"] == null ? null : EducationalProgramSpecialization.fromJson(json["educationalProgramSpecialization"]),
    gradingStructure: json["gradingStructure"] == null ? null : EducationalProgramSpecialization.fromJson(json["gradingStructure"]),
    pricingCategory: json["pricingCategory"] == null ? null : EducationalProgramSpecialization.fromJson(json["pricingCategory"]),
    educationalProgramCode: json["educationalProgramCode"],
    startDate: json["startDate"] == null ? null : DateTime.parse(json["startDate"]),
    endDate: json["endDate"] == null ? null : DateTime.parse(json["endDate"]),
    firstContactDate: json["firstContactDate"] == null ? null : DateTime.parse(json["firstContactDate"]),
    statusDate: json["statusDate"] == null ? null : DateTime.parse(json["statusDate"]),
    comments: json["comments"],
    formStatus: json["formStatus"] == null ? null : EducationalProgramSpecialization.fromJson(json["formStatus"]),
    formStatus2: json["formStatus2"] == null ? null : EducationalProgramSpecialization.fromJson(json["formStatus2"]),
    location: json["location"] == null ? null : EducationalProgramSpecialization.fromJson(json["location"]),
    academicPeriod: json["academicPeriod"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "grade": grade?.toJson(),
    "stream": stream?.toJson(),
    "registrationStatus": registrationStatus?.toJson(),
    "educationalProgramSpecialization": educationalProgramSpecialization?.toJson(),
    "gradingStructure": gradingStructure?.toJson(),
    "pricingCategory": pricingCategory?.toJson(),
    "educationalProgramCode": educationalProgramCode,
    "startDate": startDate?.toIso8601String(),
    "endDate": endDate?.toIso8601String(),
    "firstContactDate": firstContactDate?.toIso8601String(),
    "statusDate": statusDate?.toIso8601String(),
    "comments": comments,
    "formStatus": formStatus?.toJson(),
    "formStatus2": formStatus2?.toJson(),
    "location": location?.toJson(),
    "academicPeriod": academicPeriod,
  };
}

class EducationalProgramSpecialization {
  int? id;
  String? description;

  EducationalProgramSpecialization({
    this.id,
    this.description,
  });

  factory EducationalProgramSpecialization.fromJson(Map<String, dynamic> json) => EducationalProgramSpecialization(
    id: json["id"],
    description: json["description"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "description": description,
  };
}
