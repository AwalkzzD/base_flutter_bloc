import 'package:base_flutter_bloc/base/network/response/base_response.dart';
import 'package:dio/dio.dart';

class SuccessResponse<T> extends BaseResponse {
  final T data;
  final Response? rawResponse;

  SuccessResponse(super.statusCode, {required this.data, this.rawResponse});
}
