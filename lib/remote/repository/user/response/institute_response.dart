// To parse this JSON data, do
//
//     final instituteResponse = instituteResponseFromJson(jsonString);

import 'dart:convert';

InstituteResponse instituteResponseFromJson(String str) => InstituteResponse.fromJson(json.decode(str));

String instituteResponseToJson(InstituteResponse data) => json.encode(data.toJson());

class InstituteResponse {
  String? id;
  String? description;
  String? name;
  String? title;
  String? image;

  InstituteResponse({
    this.id,
    this.description,
    this.name,
    this.title,
    this.image,
  });

  factory InstituteResponse.fromJson(Map<dynamic, dynamic> json) => InstituteResponse(
    id: json["id"],
    description: json["description"],
    name: json["name"],
    title: json["title"],
    image: json["image"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "description": description,
    "name": name,
    "title": title,
    "image": image,
  };
}
