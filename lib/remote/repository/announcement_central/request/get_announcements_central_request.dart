import 'package:base_flutter_bloc/remote/repository/announcement_central/response/announcements_central_list_response.dart';
import 'package:dio/dio.dart';

import '../../../../base/network/request/base_request.dart';
import '../../../../base/network/request/http_method.dart';
import '../../../utils/api_endpoints.dart';

class GetAnnouncementsCentralRequest extends BaseRequest {
  Map<String, dynamic>? data;

  GetAnnouncementsCentralRequest({this.data})
      : super(
          endPoint: ApiEndpoints.announcementCentral,
          decoder: (response) => announcementCentralResponseFromJson(response),
          httpMethod: HttpMethod.GET,
          responseType: ResponseType.plain,
        );

  @override
  Map<String, dynamic> get queryParameters => data ?? {};
}
