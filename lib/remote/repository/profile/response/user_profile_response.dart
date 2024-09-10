// To parse this JSON data, do
//
//     final userProfileResponse = userProfileResponseFromJson(jsonString);

import 'dart:convert';

import '../../user/response/user_response.dart';

UserProfileResponse userProfileResponseFromJson(String str) =>
    UserProfileResponse.fromJson(json.decode(str));

String userProfileResponseToJson(UserProfileResponse data) =>
    json.encode(data.toJson());

class UserProfileResponse {
  String? languagePreference;
  dynamic contactMethodPreference;
  bool? hideBirthday;
  Contact? contact;
  Contact? contactOfficial;
  int? id;
  String? userName;
  String? email;
  String? givenName;
  String? surname;
  String? image;
  String? role;
  Entity? entity;
  bool? mustChangePassword;

  UserProfileResponse({
    this.languagePreference,
    this.contactMethodPreference,
    this.hideBirthday,
    this.contact,
    this.contactOfficial,
    this.id,
    this.userName,
    this.email,
    this.givenName,
    this.surname,
    this.image,
    this.role,
    this.entity,
    this.mustChangePassword,
  });

  factory UserProfileResponse.fromJson(Map<String, dynamic> json) =>
      UserProfileResponse(
        languagePreference: json["languagePreference"],
        contactMethodPreference: json["contactMethodPreference"],
        hideBirthday: json["hideBirthday"],
        contact:
            json["contact"] == null ? null : Contact.fromJson(json["contact"]),
        contactOfficial: json["contactOfficial"] == null
            ? null
            : Contact.fromJson(json["contactOfficial"]),
        id: json["id"],
        userName: json["userName"],
        email: json["email"],
        givenName: json["givenName"],
        surname: json["surname"],
        image: json["image"],
        role: json["role"],
        entity: json["entity"] == null ? null : Entity.fromJson(json["entity"]),
        mustChangePassword: json["mustChangePassword"],
      );

  Map<String, dynamic> toJson() => {
        "languagePreference": languagePreference,
        "contactMethodPreference": contactMethodPreference,
        "hideBirthday": hideBirthday,
        "contact": contact?.toJson(),
        "contactOfficial": contactOfficial?.toJson(),
        "id": id,
        "userName": userName,
        "email": email,
        "givenName": givenName,
        "surname": surname,
        "image": image,
        "role": role,
        "entity": entity?.toJson(),
        "mustChangePassword": mustChangePassword,
      };
}

class Contact {
  String? address;
  String? city;
  String? postCode;
  String? area;
  String? mobilePhone;
  String? homePhone;
  String? email;
  String? taxId;
  String? image;

  Contact({
    this.address,
    this.city,
    this.postCode,
    this.area,
    this.mobilePhone,
    this.homePhone,
    this.email,
    this.taxId,
    this.image,
  });

  factory Contact.fromJson(Map<String, dynamic> json) => Contact(
        address: json["address"],
        city: json["city"],
        postCode: json["postCode"],
        area: json["area"],
        mobilePhone: json["mobilePhone"],
        homePhone: json["homePhone"],
        email: json["email"],
        taxId: json["taxId"],
        image: json["image"],
      );

  Map<String, dynamic> toJson() => {
        "address": address,
        "city": city,
        "postCode": postCode,
        "area": area,
        "mobilePhone": mobilePhone,
        "homePhone": homePhone,
        "email": email,
        "taxId": taxId,
        "image": image,
      };
}
