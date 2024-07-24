import 'package:base_flutter_bloc/remote/utils/api_endpoints.dart';
import 'package:base_flutter_bloc/remote/utils/oauth_dio.dart';

import 'base_config.dart';

class DevConfig implements BaseConfig {
  @override
  String get apiHost => "https://consumerapi-dev.classter.com/";

  @override
  bool get httpLogs => true;

  @override
  OAuth get oauth => OAuth(
      clientId: ApiEndpoints.clientId,
      clientSecret: ApiEndpoints.clientSecret,
      tokenUrl: ApiEndpoints.tokenEndpoint);
}
