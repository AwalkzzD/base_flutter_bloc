import 'package:base_flutter_bloc/remote/api_manager/utils/api_constants.dart';
import 'package:dio/dio.dart';

class DioManager {
  DioManager._();

  static Dio? _instance;

  static Dio? getInstance() {
    _instance ??= Dio(BaseOptions(
      responseType: ResponseType.plain,
      baseUrl: ApiConstants.getBaseUrl(),
      connectTimeout: Duration(seconds: ApiConstants.connectTimeout),
      receiveTimeout: Duration(seconds: ApiConstants.receiveTimeout),
      sendTimeout: Duration(seconds: ApiConstants.writeTimeout),
    ));
    return _instance;
  }
}
