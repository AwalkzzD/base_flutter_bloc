// To parse this JSON data, do
//
//     final terminologyListResponse = terminologyListResponseFromJson(jsonString);

import 'dart:convert';

List<TerminologyListResponse> terminologyListResponseFromJson(String str) =>
    List<TerminologyListResponse>.from(
        json.decode(str).map((x) => TerminologyListResponse.fromJson(x)));

String terminologyListResponseToJson(List<TerminologyListResponse> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class TerminologyListResponse {
  String? terminology;
  String? description;
  String? descriptionPlural;

  TerminologyListResponse({
    this.terminology,
    this.description,
    this.descriptionPlural,
  });

  factory TerminologyListResponse.fromJson(Map<dynamic, dynamic> json) =>
      TerminologyListResponse(
        terminology: json["terminology"],
        description: json["description"],
        descriptionPlural: json["descriptionPlural"],
      );

  Map<String, dynamic> toJson() => {
        "terminology": terminology,
        "description": description,
        "descriptionPlural": descriptionPlural,
      };
}
