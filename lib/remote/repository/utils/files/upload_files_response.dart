// To parse this JSON data, do
//
//     final uploadFilesResponse = uploadFilesResponseFromJson(jsonString);

import 'dart:convert';

UploadFilesResponse uploadFilesResponseFromJson(String str) => UploadFilesResponse.fromJson(json.decode(str));

String uploadFilesResponseToJson(UploadFilesResponse data) => json.encode(data.toJson());

class UploadFilesResponse {
  int? count;
  String? size;

  UploadFilesResponse({
    this.count,
    this.size,
  });

  factory UploadFilesResponse.fromJson(Map<String, dynamic> json) => UploadFilesResponse(
    count: json["count"],
    size: json["size"],
  );

  Map<String, dynamic> toJson() => {
    "count": count,
    "size": size,
  };
}
