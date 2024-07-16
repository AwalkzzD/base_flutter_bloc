import 'package:base_flutter_bloc/remote/api_manager/api_manager.dart';

/// class for storing api response, status code, response status, and error message
/// used in [APIManager] class.
class BaseResponse {
  final String data;
  final int statusCode;
  final String error;
  final bool isSuccessful;

  BaseResponse({
    required this.data,
    this.statusCode = -1,
    this.error = '',
    this.isSuccessful = false,
  });
}
