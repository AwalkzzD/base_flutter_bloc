import 'package:base_flutter_bloc/base/network/request/src_request.dart';
import 'package:base_flutter_bloc/remote/repository/user/response/student_educational_program_response.dart';
import 'package:base_flutter_bloc/remote/utils/api_endpoints.dart';

class GetStudentEducationalProgramsRequest extends BaseRequest {
  int? studentId;
  int? pageNumber;
  int? pageSize;

  GetStudentEducationalProgramsRequest(
      {this.studentId, this.pageNumber, this.pageSize = 50})
      : super(
          endPoint: "${ApiEndpoints.educationPrograms}/${studentId.toString()}",
          decoder: (response) =>
              studentEducationalProgramResponseFromJson(response),
        );

  @override
  Map<String, dynamic> get queryParameters => {
        'PageNumber': pageNumber,
        'PageSize': pageSize,
      };
}
