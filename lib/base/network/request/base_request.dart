import 'package:base_flutter_bloc/base/network/request/http_method.dart';
import 'package:dio/dio.dart';

abstract class BaseRequest {
  final String? token;
  final String endPoint;
  final HttpMethod httpMethod;
  Map<String, String>? header = {
    Headers.contentTypeHeader: Headers.jsonContentType,
    Headers.acceptHeader: Headers.jsonContentType,
  };

  Map<String, dynamic> get queryParameters => {};
  FormData? formData;
  int? receiveTimeout;
  int? sendTimeout;
  Map<String, dynamic>? body;
  ResponseType? responseType;

  final dynamic Function(dynamic)? decoder;

  BaseRequest({
    required this.endPoint,
    required this.httpMethod,
    this.token,
    this.decoder,
    this.header,
    this.body,
    this.receiveTimeout,
    this.sendTimeout,
    this.responseType = ResponseType.plain,
  });
}
