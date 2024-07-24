import 'package:base_flutter_bloc/base/network/api_client/base_client.dart';
import 'package:base_flutter_bloc/remote/repository/car_details/car_details_repository.dart';
import 'package:base_flutter_bloc/remote/utils/api_constants.dart';
import 'package:dio/dio.dart';

class CarDetailsProvider {
  CarDetailsProvider._(String baseUrl);

  static BaseClient? _client;
  static CarDetailsRepository? _repository;

  static get baseClient => _client ??= BaseClient(
        baseUrl: ApiConstants.carDetailsBaseUrl,
        interceptors: [LogInterceptor(responseBody: true, requestBody: true)],
      );

  static get carDetailsRepository =>
      _repository ??= CarDetailsRepository(baseClient);
}
