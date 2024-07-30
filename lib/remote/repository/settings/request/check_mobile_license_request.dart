import 'package:base_flutter_bloc/base/network/request/src_request.dart';
import 'package:base_flutter_bloc/remote/repository/settings/response/check_mobile_license_response.dart';
import 'package:base_flutter_bloc/remote/utils/api_endpoints.dart';

class CheckMobileLicenseRequest extends BaseRequest {
  CheckMobileLicenseRequest()
      : super(
            endPoint: ApiEndpoints.checkLicense,
            decoder: (response) =>
                checkMobileLicenseResponseFromRawResponse(response));
}
