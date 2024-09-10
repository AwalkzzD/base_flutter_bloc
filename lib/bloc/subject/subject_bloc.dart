import 'package:base_flutter_bloc/base/component/base_bloc.dart';
import 'package:base_flutter_bloc/bloc/learning/learning_provider.dart';
import 'package:base_flutter_bloc/bloc/subject/subject_bloc_event.dart';
import 'package:base_flutter_bloc/utils/common_utils/app_widgets.dart';

import '../../base/component/base_state.dart';
import '../../remote/repository/learning/request/utils/learning_subjects_request_params.dart';
import '../../remote/repository/learning/response/learning_student_response.dart';
import '../../utils/common_utils/common_utils.dart';
import '../../utils/remote/pagination_data.dart';
import '../../utils/remote/pagination_utils.dart';
import '../../utils/widgets/terminologies_utils.dart';

class SubjectBloc extends BaseBloc {
  List<LearningStudentResponse> subjectList = List.empty(growable: true);
  PaginationData subjectPageData = getPaginationHeader(null);
  String searchText = "";
  int? studentId;

  SubjectBloc() {
    on<SubjectBlocEvent>((event, emit) async {
      switch (event) {
        case GetLearningSubjectsEvent getLearningSubjectsEvent:
          if (!getLearningSubjectsEvent.isPagination &&
              !getLearningSubjectsEvent.isPullToRefresh) {
            emit(const LoadingState());
            subjectPageData = getPaginationHeader(null);
          }

          await LearningProvider.learningRepository.apiGetLearningSubjects(
            getLearningSubjectsEvent.periodId,
            studentId,
            LearningSubjectsResourceParameters(
              search: searchText,
              pageNumber: getLearningSubjectsEvent.isPullToRefresh
                  ? 1
                  : subjectPageData.currentPage + 1,
            ).toMap(),
            (response, paginationData) {
              if (!getLearningSubjectsEvent.isPagination &&
                  !getLearningSubjectsEvent.isPullToRefresh) {
                // emit(const EmptyDataState('Loading'));
              }
              subjectPageData = paginationData;
              if (subjectPageData.currentPage == 1) {
                subjectList.addAll(response.data);
                if (subjectList.isEmpty) {
                  emit(EmptyDataState(string("warning.warning_empty_subjects",
                      {"subjects": subjectsLiteral()})));
                } else {
                  emit(DataState(response.data));
                }
              } else {
                subjectList = [...state.data, ...response.data];
                emit(DataState(subjectList));
              }
            },
            (error) {
              if (getLearningSubjectsEvent.isPullToRefresh) {
                showToast(error.errorMsg);
              }
              if (getLearningSubjectsEvent.isPagination) {
                throw Exception(error.errorMsg);
              }
              if (!getLearningSubjectsEvent.isPagination &&
                  !getLearningSubjectsEvent.isPullToRefresh) {
                emit(ErrorRetryState(error.errorMsg, () {
                  add(GetLearningSubjectsEvent(
                      periodId: getLearningSubjectsEvent.periodId));
                }));
              }
            },
          );
      }
    });
  }
}
