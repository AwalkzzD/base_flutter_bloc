// To parse this JSON data, do
//
//     final appSettingsResponse = appSettingsResponseFromJson(jsonString);

import 'dart:convert';

List<AppSettingsResponse> appSettingsResponseFromJson(String str) => List<AppSettingsResponse>.from(json.decode(str).map((x) => AppSettingsResponse.fromJson(x)));

String appSettingsResponseToJson(List<AppSettingsResponse> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class AppSettingsResponse {
  String? setting;
  String? type;
  String? value;

  AppSettingsResponse({
    this.setting,
    this.type,
    this.value,
  });

  factory AppSettingsResponse.fromJson(Map<String, dynamic> json) => AppSettingsResponse(
    setting: json["setting"],
    type: json["type"],
    value: json["value"],
  );

  Map<String, dynamic> toJson() => {
    "setting": setting,
    "type": type,
    "value": value,
  };
}
