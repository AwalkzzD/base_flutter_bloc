import 'package:base_flutter_bloc/base/network/exception/base_exception.dart';
import 'package:base_flutter_bloc/base/network/response/base_response.dart';
import 'package:base_flutter_bloc/remote/api_manager/utils/dio_manager.dart';
import 'package:dio/dio.dart';

/// Enum [APIMethod] for HTTP method types.
enum APIMethod { get, post, put, delete }

class APIManager {
  /// returns singleton instance of [Dio] client.
  static Dio client = DioManager.getInstance()!;

  static APIManager? _instance;

  /// Internal constructor
  APIManager._();

  /// returns singleton instance of [APIManager] class.
  factory APIManager.getInstance() {
    _instance ??= APIManager._();
    return _instance!;
  }

  static dispose() {
    _instance = null;
  }

  /// The [request] method makes the HTTP call and returns object of [BaseResponse].
  /// HTTP Method type is passed in the method parameters. Default value is [APIMethod.get].
  Future<BaseResponse> request(
    String endPoint, {
    APIMethod method = APIMethod.get,
    Map? data,
    Map<String, dynamic>? queryParams,
  }) async {
    Response response;

    try {
      switch (method) {
        case APIMethod.get:
          response = await client.get(endPoint,
              queryParameters: queryParams, data: data);
          break;
        case APIMethod.post:
          response = await client.post(endPoint,
              data: data, queryParameters: queryParams);
          break;
        case APIMethod.put:
          response = (await client.put(endPoint,
              data: data, queryParameters: queryParams));
          break;
        case APIMethod.delete:
          response =
              (await client.delete(endPoint, queryParameters: queryParams));
          break;
      }
    } on DioException catch (ex) {
      if (ex.response != null) {
        response = ex.response!;
      } else {
        return BaseResponse(data: '');
      }
    }
    return _handleResponse(response);
  }

  /// [_handleResponse] method takes [Response] object as input
  /// return [BaseResponse] object as output based on the input response object.
  /// checks if response was successful from the status code, and return data accordingly.
  /// if response is not valid, it throws [BaseException].
  BaseResponse _handleResponse(Response response) {
    String responseBody = (response.data).toString();

    int statusCode = response.statusCode ?? -1;

    bool isSuccessful = statusCode >= 200 && statusCode < 300;

    String error = '';
    if (!isSuccessful) {
      error = BaseException.getExceptionMessage(statusCode);
      throw BaseException(error, statusCode: statusCode);
    }

    return BaseResponse(
      data: responseBody,
      statusCode: statusCode,
      isSuccessful: isSuccessful,
      error: error,
    );
  }
}

/// method that uses [APIManager.getInstance]'s request method to make appropriate HTTP call.
Future<BaseResponse> getNetworkResource({
  required String endPoint,
  APIMethod method = APIMethod.get,
  Map? data,
  Map<String, dynamic>? queryParams,
}) async {
  BaseResponse response = await APIManager.getInstance()
      .request(endPoint, method: method, data: data, queryParams: queryParams);
  return response;
}
