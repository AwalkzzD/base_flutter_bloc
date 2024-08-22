import 'package:base_flutter_bloc/base/network/response/error/error_response.dart';
import 'package:base_flutter_bloc/base/network/response/success/success_response.dart';
import 'package:base_flutter_bloc/remote/repository/consents/request/get_consents_list_request.dart';
import 'package:base_flutter_bloc/remote/repository/consents/response/consents_student_response.dart';

import '../../../base/network/repository/remote_repository.dart';

class ConsentRepository extends RemoteRepository {
  ConsentRepository(super.remoteDataSource);

  ///Get a paged collection of Students Admissions data
  Future<void> apiGetConsentsList(
    int? studentId,
    String? entityType,
    Map<String, dynamic>? data,
    Function(SuccessResponse<List<ConsentsStudentsResponse>>) onSuccess,
    Function(ErrorResponse) onError,
  ) async {
    final response = await dataSource
        .makeRequest<List<ConsentsStudentsResponse>>(GetConsentsListRequest(
            studentId: studentId, entityType: entityType, data: data));

    response.fold((error) {
      onError(error);
    }, (success) {
      onSuccess(success);
    });
  }
}
