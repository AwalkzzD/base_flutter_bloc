class ConsentsRequest {
  String? admissionDataCategories;
  int? pageNumber;
  int pageSize = 10;
  String? orderBy;
  bool? required;

  ConsentsRequest(
      {this.admissionDataCategories = 'Consents',
      this.pageNumber = 1,
      this.pageSize = 25,
      this.required,
      this.orderBy = 'Order'});

  Map<String, dynamic> toMap() {
    Map<String, dynamic> data = {
      'AdmissionDataCategories': admissionDataCategories,
      'PageNumber': pageNumber,
      'PageSize': pageSize,
      'OrderBy': orderBy,
    };
    if (required != null) {
      data['required'] = required;
    }
    return data;
  }
}
