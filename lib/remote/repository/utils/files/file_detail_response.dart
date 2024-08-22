// To parse this JSON data, do
//
//     final fileDetailResponse = fileDetailResponseFromJson(jsonString);

import 'dart:convert';

FileDetailResponse fileDetailResponseFromJson(String str) => FileDetailResponse.fromJson(json.decode(str));

String fileDetailResponseToJson(FileDetailResponse data) => json.encode(data.toJson());

class FileDetailResponse {
  int? id;
  String? name;
  String? extension;
  int? size;
  String? data;

  FileDetailResponse({
    this.id,
    this.name,
    this.extension,
    this.size,
    this.data,
  });

  factory FileDetailResponse.fromJson(Map<String, dynamic> json) => FileDetailResponse(
    id: json["id"],
    name: json["name"],
    extension: json["extension"],
    size: json["size"],
    data: json["data"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "extension": extension,
    "size": size,
    "data": data,
  };

  String getNameWithoutExtension() {
    if (name != null) {
      return name!.split('.').first;
    }
    return "";
  }




}
