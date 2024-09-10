// To parse this JSON data, do
//
//     final userProfilePreferencesResponse = userProfilePreferencesResponseFromJson(jsonString);

import 'dart:convert';

UserProfilePreferencesResponse userProfilePreferencesResponseFromJson(
        String str) =>
    UserProfilePreferencesResponse.fromJson(json.decode(str));

String userProfilePreferencesResponseToJson(
        UserProfilePreferencesResponse data) =>
    json.encode(data.toJson());

class UserProfilePreferencesResponse {
  List<Language>? languages;
  List<ContactMethod>? contactMethods;

  UserProfilePreferencesResponse({
    this.languages,
    this.contactMethods,
  });

  factory UserProfilePreferencesResponse.fromJson(Map<String, dynamic> json) =>
      UserProfilePreferencesResponse(
        languages: json["languages"] == null
            ? []
            : List<Language>.from(
                json["languages"]!.map((x) => Language.fromJson(x))),
        contactMethods: json["contactMethods"] == null
            ? []
            : List<ContactMethod>.from(
                json["contactMethods"]!.map((x) => ContactMethod.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "languages": languages == null
            ? []
            : List<dynamic>.from(languages!.map((x) => x.toJson())),
        "contactMethods": contactMethods == null
            ? []
            : List<dynamic>.from(contactMethods!.map((x) => x.toJson())),
      };
}

class ContactMethod {
  int? id;
  String? description;

  ContactMethod({
    this.id,
    this.description,
  });

  factory ContactMethod.fromJson(Map<String, dynamic> json) => ContactMethod(
        id: json["id"],
        description: json["description"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "description": description,
      };
}

class Language {
  String? id;
  String? description;

  Language({
    this.id,
    this.description,
  });

  factory Language.fromJson(Map<String, dynamic> json) => Language(
        id: json["id"],
        description: json["description"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "description": description,
      };
}
