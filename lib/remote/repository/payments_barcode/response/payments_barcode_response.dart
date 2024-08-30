import 'dart:convert';

List<PaymentsBarcodeResponse> paymentsBarcodeFromJson(String str) => List<PaymentsBarcodeResponse>.from(json.decode(str).map((x) => PaymentsBarcodeResponse.fromJson(x)));

String paymentsBarcodeToJson(List<PaymentsBarcodeResponse> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class PaymentsBarcodeResponse {
  int? studentId;
  String? barcodeString;
  String? barcode;

  PaymentsBarcodeResponse({
    this.studentId,
    this.barcodeString,
    this.barcode,
  });

  factory PaymentsBarcodeResponse.fromJson(Map<String, dynamic> json) => PaymentsBarcodeResponse(
    studentId: json["studentId"],
    barcodeString: json["barcodeString"],
    barcode: json["barcode"],
  );

  Map<String, dynamic> toJson() => {
    "studentId": studentId,
    "barcodeString": barcodeString,
    "barcode": barcode,
  };
}
