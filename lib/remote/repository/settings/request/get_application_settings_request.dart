import 'package:base_flutter_bloc/base/network/request/base_request.dart';
import 'package:base_flutter_bloc/remote/repository/settings/response/app_settings_response.dart';
import 'package:dio/dio.dart';

import '../../../../base/network/request/http_method.dart';
import '../../../utils/api_endpoints.dart';

class GetApplicationSettingsRequest extends BaseRequest {
  final Map<String, dynamic> data;

  GetApplicationSettingsRequest({required this.data})
      : super(
          endPoint: ApiEndpoints.settings,
          decoder: (response) => appSettingsResponseFromJson(response),
          httpMethod: HttpMethod.GET,
          responseType: ResponseType.plain,
        );

  @override
  Map<String, dynamic> get queryParameters => data;
}
