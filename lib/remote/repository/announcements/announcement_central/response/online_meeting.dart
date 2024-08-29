class OnlineMeeting {
  OnlineMeeting({
    required this.hasMeeting,
    required this.password,
  });

  final bool? hasMeeting;
  final dynamic password;

  factory OnlineMeeting.fromJson(Map<String, dynamic> json) {
    return OnlineMeeting(
      hasMeeting: json["hasMeeting"],
      password: json["password"],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "hasMeeting": hasMeeting,
      "password": password,
    };
  }
}
