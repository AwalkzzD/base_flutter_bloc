class CalenderResourceParameters {
  int? pageNumber;
  int pageSize = 100;

  DateTime? fromDate;
  DateTime? toDate;
  int? studentId;

  CalenderResourceParameters({
    this.pageNumber,
    this.fromDate,
    this.toDate,
    this.studentId
  });

  Map<String, dynamic> toMap() {
    Map<String, dynamic> data = {
      'PageNumber': pageNumber,
      'PageSize': pageSize,
      'FromDate' : fromDate?.toIso8601String(),
      'ToDate' : toDate?.toIso8601String(),
    };
    if(studentId!=null){
      data["StudentIds"] = [studentId];
    }
    return data;
  }
}