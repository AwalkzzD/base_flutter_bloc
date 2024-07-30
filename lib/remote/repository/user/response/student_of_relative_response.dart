// To parse this JSON data, do
//
//     final studentOfRelativeResponse = studentOfRelativeResponseFromJson(jsonString);

import 'dart:convert';

List<StudentOfRelativeResponse> studentOfRelativeResponseFromJson(String str) => List<StudentOfRelativeResponse>.from(json.decode(str).map((x) => StudentOfRelativeResponse.fromJson(x)));

String studentOfRelativeResponseToJson(List<StudentOfRelativeResponse> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class StudentOfRelativeResponse {
  int? id;
  String? givenName;
  String? surname;
  String? image;
  String? fullname;
  String? reference;
  Type? type;
  bool? isGuardian;
  bool? isGeneralContact;
  bool? isAcademicContact;
  bool? isFinancialContact;

  StudentOfRelativeResponse({
    this.id,
    this.givenName,
    this.surname,
    this.image,
    this.fullname,
    this.reference,
    this.type,
    this.isGuardian,
    this.isGeneralContact,
    this.isAcademicContact,
    this.isFinancialContact,
  });

  factory StudentOfRelativeResponse.fromJson(Map<String, dynamic> json) => StudentOfRelativeResponse(
    id: json["id"],
    givenName: json["givenName"],
    surname: json["surname"],
    image: json["image"],
    fullname: json["fullname"],
    reference: json["reference"],
    type: json["type"] == null ? null : Type.fromJson(json["type"]),
    isGuardian: json["isGuardian"],
    isGeneralContact: json["isGeneralContact"],
    isAcademicContact: json["isAcademicContact"],
    isFinancialContact: json["isFinancialContact"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "givenName": givenName,
    "surname": surname,
    "image": image,
    "fullname": fullname,
    "reference": reference,
    "type": type?.toJson(),
    "isGuardian": isGuardian,
    "isGeneralContact": isGeneralContact,
    "isAcademicContact": isAcademicContact,
    "isFinancialContact": isFinancialContact,
  };

  String getName(){
    String name = "";
    if(givenName?.isNotEmpty==true){
      name = givenName ?? "";
    }
    if(name.isNotEmpty==true){
      if(surname?.isNotEmpty==true){
        name = "$name $surname";
      }
    }else{
      name = surname ?? "";
    }
    return name;
  }
}

class Type {
  int? id;
  String? description;

  Type({
    this.id,
    this.description,
  });

  factory Type.fromJson(Map<String, dynamic> json) => Type(
    id: json["id"],
    description: json["description"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "description": description,
  };
}
