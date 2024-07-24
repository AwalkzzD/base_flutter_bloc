import 'package:base_flutter_bloc/remote/utils/api_endpoints.dart';
import 'package:base_flutter_bloc/remote/utils/oauth_dio.dart';

import 'base_config.dart';

class StagingConfig implements BaseConfig {
  @override
  String get apiHost => "https://consumerapi.classter.com/";

  @override
  bool get httpLogs => true;

  @override
  OAuth get oauth => OAuth(
      clientId: ApiEndpoints.clientId,
      clientSecret: ApiEndpoints.clientSecret,
      tokenUrl: ApiEndpoints.tokenEndpoint);
}
