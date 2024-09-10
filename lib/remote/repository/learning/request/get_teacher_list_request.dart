import 'package:base_flutter_bloc/base/network/request/src_request.dart';
import 'package:base_flutter_bloc/remote/repository/learning/response/teacher_list_response.dart';
import 'package:base_flutter_bloc/remote/utils/api_endpoints.dart';
import 'package:dio/dio.dart';

class GetTeacherListRequest extends BaseRequest {
  int? studentId;
  Map<String, dynamic>? data;

  GetTeacherListRequest({
    this.studentId,
    this.data,
  }) : super(
          endPoint:
              '${ApiEndpoints.api}/${ApiEndpoints.students}/$studentId/${ApiEndpoints.teachers}',
          decoder: (response) => teacherListResponseFromJson(response),
          httpMethod: HttpMethod.GET,
          responseType: ResponseType.plain,
        );

  @override
  Map<String, dynamic> get queryParameters => data ?? {};
}
