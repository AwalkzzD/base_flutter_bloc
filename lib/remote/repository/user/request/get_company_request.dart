import 'package:base_flutter_bloc/base/network/request/src_request.dart';
import 'package:base_flutter_bloc/remote/repository/user/response/institute_response.dart';
import 'package:base_flutter_bloc/remote/utils/api_endpoints.dart';

class GetCompanyRequest extends BaseRequest {
  String? instituteCode;

  GetCompanyRequest({this.instituteCode})
      : super(
          endPoint: "${ApiEndpoints.institute}/$instituteCode",
          decoder: (response) => instituteResponseFromJson(response),
          httpMethod: HttpMethod.GET,
        );
}
