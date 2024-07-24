import 'package:base_flutter_bloc/remote/utils/api_endpoints.dart';
import 'package:base_flutter_bloc/remote/utils/oauth_dio.dart';

import 'base_config.dart';

class ProdConfig implements BaseConfig {
  @override
  String get apiHost => "https://consumerapi.classter.com/";

  @override
  bool get httpLogs => false;

  @override
  OAuth get oauth => OAuth(
      clientId: ApiEndpoints.clientId,
      clientSecret: ApiEndpoints.clientSecret,
      tokenUrl: ApiEndpoints.tokenEndpoint);
}
