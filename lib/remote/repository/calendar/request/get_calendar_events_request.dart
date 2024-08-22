import 'package:base_flutter_bloc/base/network/request/src_request.dart';
import 'package:dio/dio.dart';

import '../../../utils/api_endpoints.dart';
import '../response/calender_list_response.dart';

class GetCalendarEventsRequest extends BaseRequest {
  Map<String, dynamic>? data;

  GetCalendarEventsRequest({this.data})
      : super(
          endPoint: ApiEndpoints.calendar,
          decoder: (response) => calenderListResponseFromJson(response),
          httpMethod: HttpMethod.GET,
          responseType: ResponseType.plain,
        );

  @override
  Map<String, dynamic> get queryParameters => data ?? {};
}
