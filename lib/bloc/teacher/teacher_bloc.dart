import 'package:base_flutter_bloc/base/component/base_bloc.dart';
import 'package:base_flutter_bloc/bloc/learning/learning_provider.dart';
import 'package:base_flutter_bloc/bloc/teacher/teacher_bloc_event.dart';
import 'package:base_flutter_bloc/utils/common_utils/app_widgets.dart';

import '../../base/component/base_state.dart';
import '../../remote/repository/learning/request/utils/teacher_list_request_params.dart';
import '../../remote/repository/learning/response/teacher_list_response.dart';
import '../../utils/common_utils/common_utils.dart';
import '../../utils/remote/pagination_data.dart';
import '../../utils/remote/pagination_utils.dart';
import '../../utils/widgets/terminologies_utils.dart';

class TeacherBloc extends BaseBloc {
  PaginationData teacherPageData = getPaginationHeader(null);
  List<TeacherListResponse> teacherList = List.empty(growable: true);
  int? studentId;

  TeacherBloc() {
    on<TeacherBlocEvent>((event, emit) async {
      switch (event) {
        case LoadTeachersEvent loadTeachersEvent:
          if (!loadTeachersEvent.isPagination &&
              !loadTeachersEvent.isPullToRefresh) {
            emit(const LoadingState());
            teacherPageData = getPaginationHeader(null);
          }
          Map<String, dynamic>? data = TeacherListResourceParameters(
                  pageNumber: loadTeachersEvent.isPullToRefresh
                      ? 1
                      : teacherPageData.currentPage + 1)
              .toMap();

          await LearningProvider.learningRepository.apiGetTeachers(
            studentId,
            data,
            (response, paginationData) {
              if (!loadTeachersEvent.isPagination &&
                  !loadTeachersEvent.isPullToRefresh) {
                // emit(const EmptyDataState('Loading'));
              }
              teacherPageData = paginationData;
              if (teacherPageData.currentPage == 1) {
                teacherList.addAll(response.data);
                if (teacherList.isEmpty) {
                  emit(EmptyDataState(string("warning.warning_empty_teachers",
                      {"teachers": teachersLiteral()})));
                } else {
                  emit(DataState(teacherList));
                }
              } else {
                teacherList = [...state.data, ...response.data];
                emit(DataState(teacherList));
              }
            },
            (error) {
              if (loadTeachersEvent.isPullToRefresh) {
                showToast(error.errorMsg);
              }
              if (loadTeachersEvent.isPagination) {
                throw Exception(error.errorMsg);
              }
              if (!loadTeachersEvent.isPagination &&
                  !loadTeachersEvent.isPullToRefresh) {
                emit(ErrorRetryState(error.errorMsg, () {
                  add(LoadTeachersEvent());
                }));
              }
            },
          );
      }
    });
  }
}
