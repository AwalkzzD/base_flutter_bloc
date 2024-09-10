class TeacherListResourceParameters {
  String? search;
  int? pageNumber;
  int pageSize = 25;

  TeacherListResourceParameters({
    this.search,
    this.pageNumber,
  });

  Map<String, dynamic> toMap() {
    Map<String, dynamic> data = {
      'PageNumber': pageNumber,
      'PageSize': pageSize,
    };
    if (search != null && search?.isNotEmpty == true) {
      data['Search'] = search;
    }
    //data['OrderBy'] = "Date desc";
    return data;
  }
}
