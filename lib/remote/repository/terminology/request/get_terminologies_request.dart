import 'package:base_flutter_bloc/base/network/request/src_request.dart';
import 'package:base_flutter_bloc/remote/repository/terminology/response/terminology_list_response.dart';
import 'package:base_flutter_bloc/remote/utils/api_endpoints.dart';
import 'package:base_flutter_bloc/utils/enum_to_string/enum_to_string.dart';
import 'package:base_flutter_bloc/utils/stream_helper/common_enums.dart';

class GetTerminologiesRequest extends BaseRequest {
  GetTerminologiesRequest()
      : super(
          endPoint: ApiEndpoints.terminologies,
          decoder: (response) => terminologyListResponseFromJson(response),
          httpMethod: HttpMethod.GET,
        );

  @override
  Map<String, dynamic> get queryParameters => {
        "types": EnumToString.toList(TerminologyType.values),
      };
}
