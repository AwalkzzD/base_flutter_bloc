import 'package:base_flutter_bloc/base/network/api_client/dio_manager.dart';
import 'package:base_flutter_bloc/base/network/data_source/base_data_source.dart';
import 'package:base_flutter_bloc/base/network/request/base_request.dart';
import 'package:base_flutter_bloc/base/network/response/error/error_response.dart';
import 'package:base_flutter_bloc/base/network/response/success/success_response.dart';
import 'package:base_flutter_bloc/env/environment.dart';
import 'package:base_flutter_bloc/remote/utils/api_constants.dart';
import 'package:base_flutter_bloc/remote/utils/dio_http_formatter.dart';
import 'package:base_flutter_bloc/remote/utils/oauth_dio.dart';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';

class BaseClient extends BaseDataSource<BaseRequest> {
  final BaseOptions? baseOptions;
  final String? baseUrl;

  late Dio _dioClient;

  BaseClient({
    this.baseUrl,
    this.baseOptions,
    List<Interceptor>? interceptors,
  }) {
    createDioInstance(
        baseOptions: baseOptions ??
            BaseOptions(
              validateStatus: (status) => true,
              responseType: ResponseType.plain,
              baseUrl: baseUrl ?? ApiConstants.getBaseUrl(),
              connectTimeout:
                  Duration(milliseconds: ApiConstants.connectTimeout),
              receiveTimeout:
                  Duration(milliseconds: ApiConstants.receiveTimeout),
              sendTimeout: Duration(milliseconds: ApiConstants.writeTimeout),
            ),
        interceptors: interceptors ?? [HttpFormatter()]);
  }

  @override
  Future<Either<ErrorResponse, SuccessResponse<T>>> makeRequest<T>(
    BaseRequest request, {
    bool? enableCaching = false,
    bool? forceRefresh,
    Duration? duration,
  }) async {
    try {
      Options options = Options(
        contentType: request.contentType,
        headers: request.header,
        method: request.httpMethod.name,
        receiveDataWhenStatusError: true,
        receiveTimeout: Duration(
            milliseconds:
                request.receiveTimeout ?? ApiConstants.receiveTimeout),
        sendTimeout: Duration(
            milliseconds: request.sendTimeout ?? ApiConstants.writeTimeout),
        responseType: request.responseType,
      );

      Response dioResponse = await _dioClient.request(
        request.endPoint,
        data: request.formData ?? request.body,
        options: options,
        queryParameters: request.queryParameters,
      );

      final decoder = request.decoder;

      if (decoder != null) {
        /// with decoder
        final data = decoder(dioResponse.data);
        return Right(SuccessResponse<T>(dioResponse.statusCode,
            data: data, rawResponse: dioResponse));
      } else {
        /// without decoder
        final data = dioResponse.data;
        return Right(SuccessResponse(dioResponse.statusCode,
            data: data, rawResponse: dioResponse));
      }
    } on DioException catch (ex) {
      print('Dio Exception --> ${ex.message}');
      return Left(ErrorResponse(
          ex.response?.statusCode ?? -1, ex.message ?? 'Something went wrong'));
    } on Exception catch (ex) {
      print('Exception --> ${ex.toString()}');
      return Left(ErrorResponse(-1, ex.toString()));
    }
  }

  void createDioInstance({
    BaseOptions? baseOptions,
    List<Interceptor>? interceptors,
  }) {
    final oauth = Environment().config?.oauth;

    _dioClient = DioManager.getInstance(
        baseOptions: baseOptions, interceptors: interceptors)!;

    if (oauth != null) {
      _dioClient.interceptors
          .add(AuthBearerInterceptor(oauth, onInvalid: onAuthError));
    }
  }

  Future<void> onAuthError(Exception error) {
    return Future.value();
  }
}
