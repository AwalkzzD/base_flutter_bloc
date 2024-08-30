import 'package:base_flutter_bloc/remote/repository/payments_barcode/payment_barcode_repository.dart';

import '../../base/network/api_client/base_client.dart';

class PaymentsBarcodeProvider {
  PaymentsBarcodeProvider._();

  static BaseClient? _client;
  static PaymentBarcodeRepository? _repository;

  static get baseClient => _client ??= BaseClient();

  static PaymentBarcodeRepository get paymentsBarcodeRepository =>
      _repository ??= PaymentBarcodeRepository(baseClient);
}
