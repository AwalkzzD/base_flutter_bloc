import 'package:base_flutter_bloc/base/network/request/src_request.dart';
import 'package:dio/dio.dart';

import '../../../../utils/api_endpoints.dart';
import '../../announcement_central/response/announcements_list_response.dart';

class GetAnnouncementListRequest extends BaseRequest {
  Map<String, dynamic>? data;

  GetAnnouncementListRequest({this.data})
      : super(
          endPoint: ApiEndpoints.announcement,
          decoder: (response) => announcementResponseFromJson(response),
          httpMethod: HttpMethod.GET,
          responseType: ResponseType.plain,
        );

  @override
  Map<String, dynamic> get queryParameters => data ?? {};
}
