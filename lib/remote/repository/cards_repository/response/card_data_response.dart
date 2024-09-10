// To parse this JSON data, do
//
//     final cardDataResponse = cardDataResponseFromJson(jsonString);

import 'dart:convert';

CardDataResponse cardDataResponseFromJson(String str) => CardDataResponse.fromJson(json.decode(str));

String cardDataResponseToJson(CardDataResponse data) => json.encode(data.toJson());

class CardDataResponse {
  int? id;
  String? qrCode;
  String? cardIdNumber;
  String? rfid;
  bool? isActive;
  bool? isDelivered;
  bool? isPrinted;
  DateTime? deliveryDate;
  DateTime? printDate;
  DateTime? expirationDate;
  CardHolder? cardHolder;
  String? qrCodeBenefits;
  String? cardIdNumberBenefits;

  CardDataResponse({
    this.id,
    this.qrCode,
    this.cardIdNumber,
    this.rfid,
    this.isActive,
    this.isDelivered,
    this.isPrinted,
    this.deliveryDate,
    this.printDate,
    this.expirationDate,
    this.cardHolder,
    this.qrCodeBenefits,
    this.cardIdNumberBenefits,
  });

  factory CardDataResponse.fromJson(Map<String, dynamic> json) => CardDataResponse(
    id: json["id"],
    qrCode: json["qrCode"],
    cardIdNumber: json["cardIdNumber"],
    rfid: json["rfid"],
    isActive: json["isActive"],
    isDelivered: json["isDelivered"],
    isPrinted: json["isPrinted"],
    deliveryDate: json["deliveryDate"] == null ? null : DateTime.parse(json["deliveryDate"]),
    printDate: json["printDate"] == null ? null : DateTime.parse(json["printDate"]),
    expirationDate: json["expirationDate"] == null ? null : DateTime.parse(json["expirationDate"]),
    cardHolder: json["cardHolder"] == null ? null : CardHolder.fromJson(json["cardHolder"]),
    qrCodeBenefits: json["qrCodeBenefits"],
    cardIdNumberBenefits: json["cardIdNumberBenefits"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "qrCode": qrCode,
    "cardIdNumber": cardIdNumber,
    "rfid": rfid,
    "isActive": isActive,
    "isDelivered": isDelivered,
    "isPrinted": isPrinted,
    "deliveryDate": deliveryDate?.toIso8601String(),
    "printDate": printDate?.toIso8601String(),
    "expirationDate": expirationDate?.toIso8601String(),
    "cardHolder": cardHolder?.toJson(),
    "qrCodeBenefits": qrCodeBenefits,
    "cardIdNumberBenefits": cardIdNumberBenefits,
  };
}

class CardHolder {
  int? id;
  String? type;
  String? name;
  String? firstName;
  String? lastName;
  String? email;
  String? mobilePhone;
  String? homePhone;
  String? thumbnail;
  String? globalRegistrationNumber;
  String? pinCode;

  CardHolder({
    this.id,
    this.type,
    this.name,
    this.firstName,
    this.lastName,
    this.email,
    this.mobilePhone,
    this.homePhone,
    this.thumbnail,
    this.globalRegistrationNumber,
    this.pinCode,
  });

  factory CardHolder.fromJson(Map<String, dynamic> json) => CardHolder(
    id: json["id"],
    type: json["type"],
    name: json["name"],
    firstName: json["firstName"],
    lastName: json["lastName"],
    email: json["email"],
    mobilePhone: json["mobilePhone"],
    homePhone: json["homePhone"],
    thumbnail: json["thumbnail"],
    globalRegistrationNumber: json["globalRegistrationNumber"],
    pinCode: json["pinCode"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "type": type,
    "name": name,
    "firstName": firstName,
    "lastName": lastName,
    "email": email,
    "mobilePhone": mobilePhone,
    "homePhone": homePhone,
    "thumbnail": thumbnail,
    "globalRegistrationNumber": globalRegistrationNumber,
    "pinCode": pinCode,
  };
}
