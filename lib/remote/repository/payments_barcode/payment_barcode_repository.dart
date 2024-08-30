import 'package:base_flutter_bloc/base/network/repository/remote_repository.dart';
import 'package:base_flutter_bloc/base/network/response/error/error_response.dart';
import 'package:base_flutter_bloc/base/network/response/success/success_response.dart';
import 'package:base_flutter_bloc/remote/repository/payments_barcode/request/get_payment_barcodes_request.dart';
import 'package:base_flutter_bloc/remote/repository/payments_barcode/response/payments_barcode_response.dart';

import '../../../utils/remote/pagination_data.dart';
import '../../../utils/remote/pagination_utils.dart';

class PaymentBarcodeRepository extends RemoteRepository {
  PaymentBarcodeRepository(super.remoteDataSource);

  Future<void> apiGetPaymentsBarcodeData(
    String? idList,
    Map<String, dynamic>? data,
    Function(SuccessResponse<List<PaymentsBarcodeResponse>>,
            PaginationData paginationData)
        onSuccess,
    Function(ErrorResponse) onError,
  ) async {
    final response =
        await dataSource.makeRequest<List<PaymentsBarcodeResponse>>(
            GetPaymentBarcodesRequest(data: data, idList: idList));

    response.fold((error) {
      onError(error);
    }, (success) {
      onSuccess(success, getPaginationHeader(success.rawResponse));
    });
  }
}
