class PaymentsBarcodeParameters {
  int? pageNumber;
  int pageSize;
  String? orderBy;

  PaymentsBarcodeParameters({
    this.pageNumber,
    this.pageSize = 100,
    this.orderBy = "Order",
  });

  Map<String, dynamic> toMap() {
    Map<String, dynamic> data = {
      'PageNumber': pageNumber,
      'PageSize': pageSize,
    };

    if (orderBy != null) {
      data['orderBy'] = orderBy;
    }

    return data;
  }
}
