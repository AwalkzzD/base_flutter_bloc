import 'package:base_flutter_bloc/base/network/request/src_request.dart';
import 'package:base_flutter_bloc/remote/repository/consents/response/consents_student_response.dart';
import 'package:dio/dio.dart';

import '../../../utils/api_endpoints.dart';

class GetConsentsListRequest extends BaseRequest {
  int? studentId;
  String? entityType;
  Map<String, dynamic>? data;

  GetConsentsListRequest({this.studentId, this.entityType, this.data})
      : super(
          endPoint: '${ApiEndpoints.consents}/$entityType/$studentId',
          decoder: (response) => consentsStudentsResponseFromJson(response),
          httpMethod: HttpMethod.GET,
          responseType: ResponseType.plain,
        );

  @override
  Map<String, dynamic> get queryParameters => data ?? {};
}
