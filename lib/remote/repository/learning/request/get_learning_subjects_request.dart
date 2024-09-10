import 'package:base_flutter_bloc/base/network/request/base_request.dart';
import 'package:base_flutter_bloc/remote/repository/learning/response/learning_student_response.dart';
import 'package:base_flutter_bloc/remote/utils/api_endpoints.dart';
import 'package:dio/dio.dart';

import '../../../../base/network/request/http_method.dart';

class GetLearningSubjectsRequest extends BaseRequest {
  int? studentId;
  int? periodIdCode;
  Map<String, dynamic>? data;

  GetLearningSubjectsRequest({this.studentId, this.periodIdCode, this.data})
      : super(
          endPoint: '${ApiEndpoints.learningStudents}/$studentId',
          decoder: (response) => learningStudentResponseFromJson(response),
          httpMethod: HttpMethod.GET,
          responseType: ResponseType.plain,
          periodId: periodIdCode.toString(),
        );

  @override
  Map<String, dynamic> get queryParameters => data ?? {};
}
