import 'package:base_flutter_bloc/base/src_bloc.dart';
import 'package:base_flutter_bloc/bloc/subject/subject_bloc.dart';
import 'package:base_flutter_bloc/bloc/subject/subject_bloc_event.dart';
import 'package:base_flutter_bloc/screens/learning/subject/widget/subject_item_widget.dart';
import 'package:base_flutter_bloc/utils/common_utils/app_widgets.dart';
import 'package:base_flutter_bloc/utils/screen_utils/flutter_screen_util.dart';
import 'package:flutter/material.dart';

import '../../../remote/repository/learning/response/learning_student_response.dart';
import '../../../utils/common_utils/common_utils.dart';
import '../../../utils/common_utils/shared_pref.dart';
import '../../../utils/paginable/paginable_gridview.dart';
import '../../../utils/paginable/widgets/paginate_error_widget.dart';
import '../../../utils/paginable/widgets/paginate_loading_indicator.dart';
import '../../../utils/widgets/custom_search_field/custom_search_field.dart';

class SubjectScreen extends BasePage {
  const SubjectScreen({
    super.key,
    this.studentId,
    this.periodId,
  });

  final int? periodId;
  final int? studentId;

  @override
  BasePageState<BasePage, BaseBloc<BaseEvent, BaseState>> get getState =>
      _SubjectScreenState();
}

class _SubjectScreenState extends BasePageState<SubjectScreen, SubjectBloc> {
  final SubjectBloc _bloc = SubjectBloc();
  final TextEditingController searchController = TextEditingController();
  final FocusNode searchFocusNode = FocusNode();

  @override
  bool get enableBackPressed => false;

  @override
  void initState() {
    getBloc.studentId = widget.studentId;
    super.initState();
  }

  @override
  void onReady() {
    initData();
  }

  @override
  bool get isRefreshEnable => true;

  @override
  Future<void> onRefresh() {
    getBloc.add(GetLearningSubjectsEvent(
        periodId: widget.periodId, isPullToRefresh: true));
    return super.onRefresh();
  }

  @override
  Widget buildWidget(BuildContext context) {
    return Column(
      children: [
        //buildSearch(),
        Expanded(
          child: buildSubjectGrid(),
        ),
      ],
    );
  }

  @override
  SubjectBloc get getBloc => _bloc;

  void initData() {
    getBloc.add(GetLearningSubjectsEvent(periodId: widget.periodId));
  }

  Widget buildSubjectGrid() {
    return customBlocConsumer(
      onDataReturn: (state) {
        switch (state.data) {
          case List<LearningStudentResponse> learningStudentResponseList:
            return PaginableGridView.builder(
              padding: EdgeInsetsDirectional.symmetric(
                  horizontal: 24.h, vertical: 12.h),
              shrinkWrap: true,
              isLastPage: getBloc.subjectPageData.isLastPage(),
              loadMore: () {
                getBloc.add(GetLearningSubjectsEvent(
                    periodId: widget.periodId, isPagination: true));
                return Future.value();
              },
              errorIndicatorWidget: (exception, tryAgain) =>
                  PaginateErrorWidget(exception, tryAgain),
              progressIndicatorWidget: const PaginateLoadingIndicatorWidget(),
              itemCount: learningStudentResponseList.length,
              itemBuilder: (context, index) {
                return SubjectItemWidget(
                    learningStudentResponseList[index], index,
                    onTapped: (subjectData) {
                  showToast('Navigate to Subject Detail Screen');
                  /*Navigator.of(context).push(SubjectDetailsScreen.route(
                      widget.studentId, widget.periodId, subjectData));*/
                });
              },
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: isTablet() ? 3 : 2,
                crossAxisSpacing: 12.h,
                mainAxisSpacing: 12.h,
                childAspectRatio: isTablet()
                    ? ((195 * getScaleFactor()).h) /
                        ((235 * getScaleFactor()).h)
                    : ((165 * getScaleFactor()).w) /
                        ((235 * getScaleFactor()).h),
              ),
            );
          default:
            return Container(color: Colors.black);
        }
      },
      onDataPerform: (state) {},
    );
    /*return StreamBuilder<List<LearningStudentResponse>>(
        stream: getBloc.subjectListStream,
        builder: (context, snapshot) {
          if (snapshot.hasData && snapshot.data != null) {
            return PaginableGridView.builder(
              padding: EdgeInsetsDirectional.symmetric(
                  horizontal: 24.h, vertical: 12.h),
              shrinkWrap: true,
              isLastPage: getBloc.subjectPageData.isLastPage(),
              loadMore: () {
                getBloc.add(GetLearningSubjectsEvent(
                    periodId: widget.periodId, isPagination: true));
                return Future.value();
              },
              errorIndicatorWidget: (exception, tryAgain) =>
                  PaginateErrorWidget(exception, tryAgain),
              progressIndicatorWidget: const PaginateLoadingIndicatorWidget(),
              itemCount: snapshot.data?.length ?? 0,
              itemBuilder: (context, index) {
                return const SizedBox();
                */ /*return SubjectItemWidget(snapshot.data?[index], index,
                    onTapped: (subjectData) {
                  Navigator.of(context).push(SubjectDetailsScreen.route(
                      widget.studentId, widget.periodId, subjectData));
                });*/ /*
              },
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: isTablet() ? 3 : 2,
                crossAxisSpacing: 12.h,
                mainAxisSpacing: 12.h,
                childAspectRatio: isTablet()
                    ? ((195 * getScaleFactor()).h) /
                        ((235 * getScaleFactor()).h)
                    : ((165 * getScaleFactor()).w) /
                        ((235 * getScaleFactor()).h),
              ),
            );
          } else {
            return const SizedBox();
          }
        });*/
  }

  Widget buildSearch() {
    return Padding(
      padding:
          EdgeInsetsDirectional.symmetric(horizontal: 24.h, vertical: 12.h),
      child: CustomSearchField(
        controller: searchController,
        focusNode: searchFocusNode,
        onSearch: (value) {
          getBloc.searchText = value;
          /*getBloc.loadSubjects(widget.periodId, ).then((value) {
            Future.delayed(const Duration(milliseconds: 300), () {
              FocusScope.of(context).requestFocus(searchFocusNode);
            });
          });*/
        },
        onCancel: () {
          getBloc.searchText = '';
          searchController.clear();
          /*getBloc().loadSubjects(widget.periodId);*/
        },
      ),
    );
  }
}
