import 'package:base_flutter_bloc/base/network/request/src_request.dart';
import 'package:base_flutter_bloc/remote/utils/api_endpoints.dart';
import 'package:base_flutter_bloc/utils/common_utils/shared_pref.dart';

import '../../profile/response/user_profile_response.dart';

class GetUserProfileRequest extends BaseRequest {
  GetUserProfileRequest()
      : super(
            endPoint:
                "${ApiEndpoints.user}/${getRequestProperties()?.userId.toString()}/${ApiEndpoints.userProfile}",
            decoder: (response) => userProfileResponseFromJson(response));
}
