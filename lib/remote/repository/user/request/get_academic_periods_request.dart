import 'package:base_flutter_bloc/base/network/request/src_request.dart';
import 'package:base_flutter_bloc/remote/repository/user/response/academic_periods_response.dart';
import 'package:base_flutter_bloc/remote/utils/api_endpoints.dart';
import 'package:base_flutter_bloc/utils/common_utils/shared_pref.dart';
import 'package:dio/dio.dart';

class GetAcademicPeriodsRequest extends BaseRequest {
  String? tenant;
  String? periodId;

  GetAcademicPeriodsRequest({this.tenant, this.periodId})
      : super(
          endPoint: ApiEndpoints.academicPeriods,
          decoder: (response) => academicPeriodResponseFromJson(response),
          httpMethod: HttpMethod.GET,
          responseType: ResponseType.plain,
        );

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
