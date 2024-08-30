import 'package:base_flutter_bloc/base/network/request/src_request.dart';
import 'package:base_flutter_bloc/remote/repository/payments_barcode/response/payments_barcode_response.dart';
import 'package:dio/dio.dart';

import '../../../utils/api_endpoints.dart';

class GetPaymentBarcodesRequest extends BaseRequest {
  Map<String, dynamic>? data;
  String? idList;

  GetPaymentBarcodesRequest({this.data, this.idList})
      : super(
          endPoint:
              "${ApiEndpoints.paymentsBarcode}$idList${ApiEndpoints.payments}",
          decoder: (response) => paymentsBarcodeFromJson(response),
          httpMethod: HttpMethod.GET,
          responseType: ResponseType.plain,
        );

  @override
  Map<String, dynamic> get queryParameters => data ?? {};
}
