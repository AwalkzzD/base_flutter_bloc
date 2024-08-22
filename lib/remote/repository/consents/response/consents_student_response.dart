// To parse this JSON data, do
//
//     final consentsStudentsResponse = consentsStudentsResponseFromJson(jsonString);

import 'dart:convert';

// List<ConsentsStudentsResponse> consentsStudentsResponseFromJson(String str) => List<ConsentsStudentsResponse>.from(json.decode(str).map((x) => ConsentsStudentsResponse.fromJson(x)));
List<ConsentsStudentsResponse> consentsStudentsResponseFromJson(String str) {
  List<ConsentsStudentsResponse> responseList = List<ConsentsStudentsResponse>.from(json.decode(str).map((x) => ConsentsStudentsResponse.fromJson(x)));
  responseList.sort((a, b) {
    int? order1 = a.order ?? 0;
    int? order2 = b.order ?? 0;
    return order1.compareTo(order2);
  });
  return responseList;
}

String consentsStudentsResponseToJson(List<ConsentsStudentsResponse> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class ConsentsStudentsResponse {
  int? id;
  String? description;
  String? info;
  bool? required;
  int? order;
  Category? category;
  List<Entry>? entries;

  ConsentsStudentsResponse({
    this.id,
    this.description,
    this.info,
    this.required,
    this.order,
    this.category,
    this.entries,
  });

  factory ConsentsStudentsResponse.fromJson(Map<String, dynamic> json) => ConsentsStudentsResponse(
    id: json["id"],
    description: json["description"],
    info: json["info"],
    required: json["required"],
    order: json["order"],
    category: json["category"] == null ? null : Category.fromJson(json["category"]),
    entries: getEntries(json),
  );

  static List<Entry> getEntries(Map<String, dynamic> json){
    List<Entry> entries = [];
    if(json["entries"] == null){
      return entries;
    }
    entries = List<Entry>.from(json["entries"]!.map((x) => Entry.fromJson(x)));
    entries.sort((a, b) {
      int? order1 = a.order ?? 0;
      int? order2 = b.order ?? 0;
      return order1.compareTo(order2);
    });
    return entries;
  }

  Map<String, dynamic> toJson() => {
    "id": id,
    "description": description,
    "info": info,
    "required": required,
    "order": order,
    "category": category?.toJson(),
    "entries": entries == null ? [] : List<dynamic>.from(entries!.map((x) => x.toJson())),
  };
}

class Category {
  int? id;
  String? description;
  dynamic info;

  Category({
    this.id,
    this.description,
    this.info,
  });

  factory Category.fromJson(Map<String, dynamic> json) => Category(
    id: json["id"],
    description: json["description"],
    info: json["info"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "description": description,
    "info": info,
  };
}

class Entry {
  int? id;
  String? description;
  String? type;
  int? order;
  List<Option>? options;
  String? answer;
  String? answerLabel;
  List<FileAnswerArray>? fileAnswerList;

  Entry({
    this.id,
    this.description,
    this.type,
    this.order,
    this.options,
    this.answer,
    this.answerLabel,
    this.fileAnswerList,
  });

  factory Entry.fromJson(Map<String, dynamic> json) => Entry(
    id: json["id"],
    description: json["description"],
    type: json["type"],
    order: json["order"],
    options: json["options"] == null ? [] : List<Option>.from(json["options"]!.map((x) => Option.fromJson(x))),
    answer: json["answer"],
    answerLabel: json["answerLabel"],
    fileAnswerList: json["fileAnswerList"] == null ? [] : List<FileAnswerArray>.from(json["fileAnswerList"]!.map((x) => Option.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "description": description,
    "type": type,
    "order": order,
    "options": options == null ? [] : List<dynamic>.from(options!.map((x) => x.toJson())),
    "fileAnswerList": fileAnswerList == null ? [] : List<dynamic>.from(fileAnswerList!.map((x) => x.toJson())),
    "answer": answer,
    "answerLabel": answerLabel,
  };
}

class Option {
  int? id;
  String? description;

  Option({
    this.id,
    this.description,
  });

  factory Option.fromJson(Map<String, dynamic> json) => Option(
    id: json["id"],
    description: json["description"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "description": description,
  };
}

class FileAnswerArray {
  String? answer;
  String? answerLabel;

  FileAnswerArray({
    this.answer,
    this.answerLabel,
  });

  factory FileAnswerArray.fromJson(Map<String, dynamic> json) => FileAnswerArray(
    answer: json["answer"],
    answerLabel: json["answerLabel"],
  );

  Map<String, dynamic> toJson() => {
    "id": answer,
    "answerLabel": answerLabel,
  };
}
