class SessionsTaskResourceParameters {
  int? pageNumber;
  int pageSize = 25;
  String? date;
  int? studentId;

  SessionsTaskResourceParameters({
    this.pageNumber,
    this.date,
    this.studentId
  });

  Map<String, dynamic> toMap() {
    Map<String, dynamic> data = {
      'PageNumber': pageNumber,
      'PageSize': pageSize,
    };

    if(date!=null && date?.isNotEmpty==true) {
      data['Date'] = date;
    }
    if(studentId!=null) {
      data['StudentId'] = studentId;
    }

    /*data['OrderBy'] = {
      "Day" : "Desc"
    };*/
    return data;
  }
}