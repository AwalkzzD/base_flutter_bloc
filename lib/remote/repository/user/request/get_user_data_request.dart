import 'package:base_flutter_bloc/base/network/request/src_request.dart';
import 'package:base_flutter_bloc/remote/repository/user/response/user_response.dart';
import 'package:base_flutter_bloc/remote/utils/api_endpoints.dart';
import 'package:base_flutter_bloc/utils/common_utils/shared_pref.dart';

class GetUserDataRequest extends BaseRequest {
  GetUserDataRequest()
      : super(
            endPoint:
                "${ApiEndpoints.user}/${getRequestProperties()?.userId.toString()}",
            decoder: (response) => userResponseFromJson(response));
}
