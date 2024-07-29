import 'package:base_flutter_bloc/base/network/request/src_request.dart';
import 'package:base_flutter_bloc/remote/repository/settings/response/mobile_license_menu.dart';
import 'package:base_flutter_bloc/remote/utils/api_endpoints.dart';

class GetMobileLicenseMenuRequest extends BaseRequest {
  GetMobileLicenseMenuRequest()
      : super(
          endPoint: ApiEndpoints.mobileLicenseMenus,
          decoder: (response) => mobileLicenseMenuResponseFromJson(response),
          httpMethod: HttpMethod.GET,
        );
}
