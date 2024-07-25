// To parse this JSON data, do
//
//     final companyIdResponse = companyIdResponseFromJson(jsonString);

import 'dart:convert';

CompanyIdResponse companyIdResponseFromJson(String str) => CompanyIdResponse.fromJson(json.decode(str));

String companyIdResponseToJson(CompanyIdResponse data) => json.encode(data.toJson());

class CompanyIdResponse {
  String? id;
  String? description;
  String? image;

  CompanyIdResponse({
    this.id,
    this.description,
    this.image,
  });

  factory CompanyIdResponse.fromJson(Map<dynamic, dynamic> json) => CompanyIdResponse(
    id: json["id"],
    description: json["description"],
    image: json["image"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "description": description,
    "image": image,
  };
}
