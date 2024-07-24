import 'package:base_flutter_bloc/base/network/response/base_response.dart';

class SuccessResponse<T> extends BaseResponse {
  final T data;

  SuccessResponse(super.statusCode, this.data);
}
