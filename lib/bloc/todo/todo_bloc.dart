import 'package:base_flutter_bloc/base/src_bloc.dart';
import 'package:base_flutter_bloc/bloc/todo/todo_bloc_event.dart';
import 'package:base_flutter_bloc/bloc/todo/todo_provider.dart';
import 'package:base_flutter_bloc/utils/common_utils/app_widgets.dart';
import 'package:rxdart/rxdart.dart';

import '../../remote/repository/todo/request/utils/sessions_task_request_params.dart';
import '../../remote/repository/todo/response/session_task_list_response.dart';
import '../../utils/remote/pagination_data.dart';
import '../../utils/remote/pagination_utils.dart';

class TodoBloc extends BaseBloc<TodoBlocEvent, BaseState> {
  late BehaviorSubject<DateTime> dateTime;

  get dateTimeStream => dateTime.stream;

  late BehaviorSubject<List<SessionTaskListResponse>> tasksList;

  get tasksListStream => tasksList.stream;

  PaginationData categoryPageData = getPaginationHeader(null);

  TodoBloc() {
    dateTime = BehaviorSubject<DateTime>.seeded(DateTime.now());
    tasksList = BehaviorSubject<List<SessionTaskListResponse>>.seeded([]);
  }

  Future<void> loadSessionsTask(int? studentId,
      {bool isPagination = false, bool isPullToRefresh = false}) async {
    if (!isPagination && !isPullToRefresh) {
      categoryPageData = getPaginationHeader(null);
    }
    SessionsTaskResourceParameters requestParameters =
        SessionsTaskResourceParameters(
            pageNumber: isPullToRefresh ? 1 : categoryPageData.currentPage + 1,
            date: dateTime.value.toIso8601String(),
            studentId: studentId);
    Map<String, dynamic>? data = requestParameters.toMap();
    TodoProvider.todoRepository.apiGetSessionTasks(data,
        (messageListResponse, paginationData) {
      if (!isPagination && !isPullToRefresh) {}
      categoryPageData = paginationData;
      if (categoryPageData.totalCount == 0) {
        /*showEmpty(string("dashboard.label_empty_to_do_task"));*/
      } else {
        if (!tasksList.isClosed) {
          if (categoryPageData.currentPage == 1) {
            tasksList.add(messageListResponse.data);
          } else {
            List<SessionTaskListResponse> oldMessageList = tasksList.value;
            oldMessageList.addAll(messageListResponse.data);
            tasksList.add(oldMessageList);
          }
        }
      }
    }, (error) {
      if (isPullToRefresh) {
        showToast(error.errorMsg);
      }
      if (isPagination) {
        throw Exception(error.errorMsg);
      }
      if (!isPagination && !isPullToRefresh) {}
    });
  }
}
