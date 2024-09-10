import 'package:base_flutter_bloc/remote/repository/profile/response/user_profile_prefrences_response.dart';
import 'package:dio/dio.dart';

import '../../../../base/network/request/src_request.dart';
import '../../../utils/api_endpoints.dart';

class GetProfilePreferencesRequest extends BaseRequest {
  GetProfilePreferencesRequest()
      : super(
          endPoint: ApiEndpoints.userProfilePref,
          decoder: (response) =>
              userProfilePreferencesResponseFromJson(response),
          httpMethod: HttpMethod.GET,
          responseType: ResponseType.plain,
        );
}
