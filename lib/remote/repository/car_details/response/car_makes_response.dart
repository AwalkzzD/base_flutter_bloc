// To parse this JSON data, do
//
//     final carMakesResponse = carMakesResponseFromJson(jsonString);

import 'dart:convert';

CarMakesResponse carMakesResponseFromJson(String str) =>
    CarMakesResponse.fromJson(json.decode(str));

String carMakesResponseToJson(CarMakesResponse data) =>
    json.encode(data.toJson());

class CarMakesResponse {
  int? count;
  String? message;
  dynamic searchCriteria;
  List<Result>? results;

  CarMakesResponse({
    this.count,
    this.message,
    this.searchCriteria,
    this.results,
  });

  factory CarMakesResponse.fromJson(Map<String, dynamic> json) =>
      CarMakesResponse(
        count: json["Count"],
        message: json["Message"],
        searchCriteria: json["SearchCriteria"],
        results: json["Results"] == null
            ? []
            : List<Result>.from(
                json["Results"]!.map((x) => Result.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "Count": count,
        "Message": message,
        "SearchCriteria": searchCriteria,
        "Results": results == null
            ? []
            : List<dynamic>.from(results!.map((x) => x.toJson())),
      };
}

class Result {
  int? makeId;
  String? makeName;

  Result({
    this.makeId,
    this.makeName,
  });

  factory Result.fromJson(Map<String, dynamic> json) => Result(
        makeId: json["Make_ID"],
        makeName: json["Make_Name"],
      );

  Map<String, dynamic> toJson() => {
        "Make_ID": makeId,
        "Make_Name": makeName,
      };
}
