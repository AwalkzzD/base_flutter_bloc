class EventCategory {
  int? id;
  String? description;
  String? color;

  EventCategory({this.id, this.description, this.color});

  EventCategory.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    description = json['description'];
    color = json['color'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['description'] = this.description;
    data['color'] = this.color;
    return data;
  }
}