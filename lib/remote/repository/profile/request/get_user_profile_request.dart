import 'package:base_flutter_bloc/remote/repository/profile/response/user_profile_response.dart';
import 'package:dio/dio.dart';

import '../../../../base/network/request/src_request.dart';
import '../../../utils/api_endpoints.dart';

class GetUserProfileRequest extends BaseRequest {
  final int userId;

  GetUserProfileRequest({required this.userId})
      : super(
          endPoint: "${ApiEndpoints.user}/$userId/${ApiEndpoints.userProfile}",
          decoder: (response) => userProfileResponseFromJson(response),
          httpMethod: HttpMethod.GET,
          responseType: ResponseType.plain,
        );
}
