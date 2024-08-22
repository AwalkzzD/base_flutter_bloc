import 'package:base_flutter_bloc/remote/repository/todo/response/session_task_list_response.dart';
import 'package:dio/dio.dart';

import '../../../../base/network/request/base_request.dart';
import '../../../../base/network/request/http_method.dart';
import '../../../utils/api_endpoints.dart';

class GetSessionTasksRequest extends BaseRequest {
  Map<String, dynamic>? data;

  GetSessionTasksRequest({this.data})
      : super(
          endPoint: ApiEndpoints.sessionTasks,
          decoder: (response) => sessionTaskListResponseFromJson(response),
          httpMethod: HttpMethod.GET,
          responseType: ResponseType.plain,
        );

  @override
  Map<String, dynamic> get queryParameters => data ?? {};
}
