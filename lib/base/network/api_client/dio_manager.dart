import 'package:dio/dio.dart';

class DioManager {
  DioManager._();

  static Dio? _instance;

  static Dio? getInstance({
    BaseOptions? baseOptions,
    List<Interceptor>? interceptors,
  }) {
    _instance ??= Dio(baseOptions)..interceptors.addAll(interceptors ?? []);
    return _instance;
  }
}
