import 'package:base_flutter_bloc/base/network/repository/remote_repository.dart';
import 'package:base_flutter_bloc/base/network/response/error/error_response.dart';
import 'package:base_flutter_bloc/base/network/response/success/success_response.dart';
import 'package:base_flutter_bloc/remote/repository/todo/request/get_session_tasks_request.dart';
import 'package:base_flutter_bloc/remote/repository/todo/response/session_task_list_response.dart';

import '../../../utils/remote/pagination_data.dart';
import '../../../utils/remote/pagination_utils.dart';

class TodoRepository extends RemoteRepository {
  TodoRepository(super.remoteDataSource);

  Future<void> apiGetSessionTasks(
    Map<String, dynamic>? data,
    Function(SuccessResponse<List<SessionTaskListResponse>>,
            PaginationData paginationData)
        onSuccess,
    Function(ErrorResponse) onError,
  ) async {
    final response =
        await dataSource.makeRequest<List<SessionTaskListResponse>>(
            GetSessionTasksRequest(data: data));

    response.fold((error) {
      onError(error);
    }, (success) {
      onSuccess(success, getPaginationHeader(success.rawResponse));
    });
  }
}
