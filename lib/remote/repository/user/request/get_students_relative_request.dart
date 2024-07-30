import 'package:base_flutter_bloc/base/network/request/base_request.dart';
import 'package:base_flutter_bloc/remote/repository/user/response/student_of_relative_response.dart';
import 'package:base_flutter_bloc/remote/utils/api_endpoints.dart';

class GetStudentsRelativeRequest extends BaseRequest {
  int? relativeId;
  List<String>? statusIds = [];

  GetStudentsRelativeRequest({this.relativeId, this.statusIds})
      : super(
          endPoint:
              "${ApiEndpoints.studentsRelative}/${relativeId.toString()}/students",
          decoder: (response) => studentOfRelativeResponseFromJson(response),
        );

  @override
  Map<String, dynamic> get queryParameters => {
        'StatusIds': statusIds,
      };
}
