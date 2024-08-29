class AnnouncementListParameters {
  bool? isRead;
  String? fromDate;
  String? toDate;
  int? pageNumber;
  int pageSize = 25;
  String? orderBy = "StartDate desc";
  String? types = "Events";

  AnnouncementListParameters({
    this.isRead,
    this.fromDate,
    this.toDate,
    this.pageNumber,
  });

  Map<String, dynamic> toMap() {
    Map<String, dynamic> data = {
      'PageNumber': pageNumber,
      'PageSize': pageSize,
     };

    if (isRead != null) {
      data['isRead'] = isRead;
    }

    if (orderBy != null) {
      data['orderBy'] = orderBy;
    }

    if (toDate != null) {
      data['toDate'] = toDate;
    }

    return data;
  }
}
