class AnnouncementCentralListParameters {
  String? currentDate;
  int? pageNumber;
  int pageSize;
  String? orderBy;

  AnnouncementCentralListParameters({
    this.currentDate,
    this.pageNumber,
    this.pageSize = 10,
    this.orderBy = "Order ,StartDate desc",
  });

  Map<String, dynamic> toMap() {
    Map<String, dynamic> data = {
      'PageNumber': pageNumber,
      'PageSize': pageSize,
      'CurrentDate': DateTime.now().toIso8601String(),
    };

    if (orderBy != null) {
      data['orderBy'] = orderBy;
    }

    return data;
  }
}
