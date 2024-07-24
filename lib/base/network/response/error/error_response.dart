import 'package:base_flutter_bloc/base/network/response/base_response.dart';

class ErrorResponse extends BaseResponse {
  final String errorMsg;

  ErrorResponse(super.statusCode, this.errorMsg);
}
