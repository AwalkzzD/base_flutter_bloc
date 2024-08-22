// To parse this JSON data, do
//
//     final filesListResponse = filesListResponseFromJson(jsonString);

import 'dart:convert';

import 'file_element.dart';

List<FileElement> filesListResponseFromJson(String str) => List<FileElement>.from(json.decode(str).map((x) => FileElement.fromJson(x)));

String filesListResponseToJson(List<FileElement> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));