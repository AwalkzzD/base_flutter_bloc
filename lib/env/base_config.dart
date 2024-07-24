import 'package:base_flutter_bloc/remote/utils/oauth_dio.dart';

abstract class BaseConfig {
  String get apiHost;
  OAuth get oauth;
  bool get httpLogs;
}
