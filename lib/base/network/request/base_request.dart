import 'package:base_flutter_bloc/base/network/request/http_method.dart';
import 'package:base_flutter_bloc/utils/common_utils/shared_pref.dart';
import 'package:dio/dio.dart';

abstract class BaseRequest {
  final String? token;
  final String endPoint;
  final HttpMethod httpMethod;

  Map<String, String>? get header => {
        "Content-Type": "application/json",
        "Cookie": "_culture_main=${getLanguage()}",
        "Accept": "application/json",
        "X-Institute-Tenant": ((getRequestProperties() == null)
            ? ''
            : getRequestProperties()!.instituteId),
        "X-Institute-Period": ((getRequestProperties() == null)
            ? ''
            : getRequestProperties()!.periodCode),
      };

  Map<String, dynamic> get queryParameters => {};
  FormData? formData;
  int? receiveTimeout;
  int? sendTimeout;
  Map<String, dynamic>? body;
  ResponseType? responseType;
  Options? options;

  final dynamic Function(dynamic)? decoder;

  BaseRequest({
    required this.endPoint,
    required this.httpMethod,
    this.token,
    this.decoder,
    this.body,
    this.receiveTimeout,
    this.sendTimeout,
    this.responseType = ResponseType.plain,
    this.options,
  });
}
