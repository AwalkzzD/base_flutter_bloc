// To parse this JSON data, do
//
//     final mobileLicenseMenuResponse = mobileLicenseMenuResponseFromJson(jsonString);

import 'dart:convert';

MobileLicenseMenuResponse mobileLicenseMenuResponseFromJson(String str) => MobileLicenseMenuResponse.fromJson(json.decode(str));

String mobileLicenseMenuResponseToJson(MobileLicenseMenuResponse data) => json.encode(data.toJson());

class MobileLicenseMenuResponse {
  List<dynamic>? modules;
  List<Menu>? menus;

  MobileLicenseMenuResponse({
    this.modules,
    this.menus,
  });

  factory MobileLicenseMenuResponse.fromJson(Map<dynamic, dynamic> json) => MobileLicenseMenuResponse(
    modules: json["modules"] == null ? [] : List<dynamic>.from(json["modules"]!.map((x) => x)),
    menus: json["menus"] == null ? [] : List<Menu>.from(json["menus"]!.map((x) => Menu.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "modules": modules == null ? [] : List<dynamic>.from(modules!.map((x) => x)),
    "menus": menus == null ? [] : List<dynamic>.from(menus!.map((x) => x.toJson())),
  };

}

class Menu {
  int? id;
  String? icon;
  String? optionName;
  String? newFeedCount;
  bool? isNewFeedAvailable;
  String? view;

  Menu({
    this.id,
    this.icon,
    this.optionName,
    this.newFeedCount,
    this.isNewFeedAvailable,
    this.view,
  });

  factory Menu.fromJson(Map<dynamic, dynamic> json) => Menu(
    id: json["id"],
    icon: json["icon"],
    optionName: json["optionName"],
    newFeedCount: json["newFeedCount"],
    isNewFeedAvailable: json["isNewFeedAvailable"],
    view: json["view"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "icon": icon,
    "optionName": optionName,
    "newFeedCount": newFeedCount,
    "isNewFeedAvailable": isNewFeedAvailable,
    "view": view,
  };
}

class Privilege {
  dynamic? privilege;
  dynamic? value;
  String? valueType;

  Privilege({
    this.privilege,
    this.value,
    this.valueType,
  });

  factory Privilege.fromJson(Map<dynamic, dynamic> json) => Privilege(
    privilege: json["privilege"],
    value: json["value"],
    valueType: json["valueType"],
  );

  Map<String, dynamic> toJson() => {
    "privilege": privilege,
    "value": value,
    "valueType": valueType,
  };
}
