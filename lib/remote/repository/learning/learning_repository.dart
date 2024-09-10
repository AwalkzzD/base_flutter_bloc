import 'package:base_flutter_bloc/base/network/repository/remote_repository.dart';
import 'package:base_flutter_bloc/base/network/response/error/error_response.dart';
import 'package:base_flutter_bloc/base/network/response/success/success_response.dart';
import 'package:base_flutter_bloc/remote/repository/learning/request/get_learning_subjects_request.dart';
import 'package:base_flutter_bloc/remote/repository/learning/request/get_teacher_list_request.dart';
import 'package:base_flutter_bloc/remote/repository/learning/response/learning_student_response.dart';
import 'package:base_flutter_bloc/remote/repository/learning/response/teacher_list_response.dart';

import '../../../utils/remote/pagination_data.dart';
import '../../../utils/remote/pagination_utils.dart';

class LearningRepository extends RemoteRepository {
  LearningRepository(super.remoteDataSource);

  Future<void> apiGetLearningSubjects(
    int? periodId,
    int? studentId,
    Map<String, dynamic>? data,
    Function(SuccessResponse<List<LearningStudentResponse>>,
            PaginationData paginationData)
        onSuccess,
    Function(ErrorResponse) onError,
  ) async {
    final response = await dataSource
        .makeRequest<List<LearningStudentResponse>>(GetLearningSubjectsRequest(
            studentId: studentId, periodIdCode: periodId, data: data));

    response.fold((error) {
      onError(error);
    }, (success) {
      onSuccess(success, getPaginationHeader(success.rawResponse));
    });
  }

  Future<void> apiGetTeachers(
    int? studentId,
    Map<String, dynamic>? data,
    Function(SuccessResponse<List<TeacherListResponse>>,
            PaginationData paginationData)
        onSuccess,
    Function(ErrorResponse) onError,
  ) async {
    final response = await dataSource.makeRequest<List<TeacherListResponse>>(
        GetTeacherListRequest(studentId: studentId, data: data));

    response.fold((error) {
      onError(error);
    }, (success) {
      onSuccess(success, getPaginationHeader(success.rawResponse));
    });
  }
}
