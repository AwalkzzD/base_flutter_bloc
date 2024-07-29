import 'package:base_flutter_bloc/base/network/request/src_request.dart';
import 'package:base_flutter_bloc/remote/repository/settings/response/app_settings_response.dart';
import 'package:base_flutter_bloc/remote/utils/api_endpoints.dart';
import 'package:base_flutter_bloc/utils/common_utils/shared_pref.dart';
import 'package:base_flutter_bloc/utils/stream_helper/settings_utils.dart';
import 'package:dio/dio.dart';

class GetActivePeriodRequest extends BaseRequest {
  String? tenant;
  String? periodId;
  List<SettingsValue> settingValues;

  GetActivePeriodRequest(
      {this.tenant, this.periodId, required this.settingValues})
      : super(
          endPoint: ApiEndpoints.settings,
          decoder: (response) => appSettingsResponseFromJson(response),
          httpMethod: HttpMethod.GET,
          responseType: ResponseType.plain,
        );

  @override
  Map<String, dynamic> get queryParameters => {
        "names": settingValues
            .map((value) => value.toString().split('.').last)
            .toList()
            .join(','),
      };

  @override
  Map<String, String>? get header => {
        "Content-Type": "application/json",
        "Cookie": "_culture_main=${getLanguage()}",
        "Accept": "application/json",
        "X-Institute-Tenant": tenant ??
            ((getRequestProperties() == null)
                ? ''
                : getRequestProperties()!.instituteId),
        "X-Institute-Period": periodId ??
            ((getRequestProperties() == null)
                ? ''
                : getRequestProperties()!.periodCode),
      };
}
