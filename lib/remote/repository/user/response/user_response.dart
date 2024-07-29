// To parse this JSON data, do
//
//     final userResponse = userResponseFromJson(jsonString);

import 'dart:convert';

UserResponse userResponseFromJson(String str) => UserResponse.fromJson(json.decode(str));

String userResponseToJson(UserResponse data) => json.encode(data.toJson());

class UserResponse {
  int? id;
  String? userName;
  String? email;
  String? givenName;
  String? surname;
  String? image;
  String? role;
  Entity? entity;

  UserResponse({
    this.id,
    this.userName,
    this.email,
    this.givenName,
    this.surname,
    this.image,
    this.role,
    this.entity,
  });

  factory UserResponse.fromJson(Map<dynamic, dynamic> json) => UserResponse(
    id: json["id"],
    userName: json["userName"],
    email: json["email"],
    givenName: json["givenName"],
    surname: json["surname"],
    image: json["image"],
    role: json["role"],
    entity: json["entity"] == null ? null : Entity.fromJson(json["entity"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "userName": userName,
    "email": email,
    "givenName": givenName,
    "surname": surname,
    "image": image,
    "role": role,
    "entity": entity?.toJson(),
  };
}

class Entity {
  int? id;
  String? types;

  Entity({
    this.id,
    this.types,
  });

  factory Entity.fromJson(Map<String, dynamic> json) => Entity(
    id: json["id"],
    types: json["types"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "types": types,
  };
}
