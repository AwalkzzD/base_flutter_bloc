import 'package:base_flutter_bloc/base/src_bloc.dart';
import 'package:base_flutter_bloc/bloc/teacher/teacher_bloc.dart';
import 'package:base_flutter_bloc/bloc/teacher/teacher_bloc_event.dart';
import 'package:base_flutter_bloc/screens/learning/teacher/widget/teacher_info_dialog_widget.dart';
import 'package:base_flutter_bloc/screens/learning/teacher/widget/teacher_item_widget.dart';
import 'package:base_flutter_bloc/utils/screen_utils/flutter_screen_util.dart';
import 'package:flutter/material.dart';

import '../../../remote/repository/learning/response/teacher_list_response.dart';
import '../../../utils/common_utils/app_widgets.dart';
import '../../../utils/common_utils/common_utils.dart';
import '../../../utils/common_utils/shared_pref.dart';
import '../../../utils/paginable/paginable_gridview.dart';
import '../../../utils/paginable/widgets/paginate_error_widget.dart';
import '../../../utils/paginable/widgets/paginate_loading_indicator.dart';

class TeacherScreen extends BasePage {
  const TeacherScreen({
    super.key,
    this.studentId,
  });

  final int? studentId;

  @override
  BasePageState<BasePage, BaseBloc<BaseEvent, BaseState>> get getState =>
      _TeacherScreenState();
}

class _TeacherScreenState extends BasePageState<TeacherScreen, TeacherBloc> {
  final TeacherBloc _bloc = TeacherBloc();

  @override
  bool get enableBackPressed => false;

  @override
  void initState() {
    super.initState();
    getBloc.studentId = widget.studentId;
  }

  @override
  void onReady() {
    initData();
  }

  @override
  bool get isRefreshEnable => true;

  @override
  Future<void> onRefresh() {
    getBloc.add(LoadTeachersEvent(isPullToRefresh: true));
    return Future.value();
  }

  @override
  Widget buildWidget(BuildContext context) {
    return customBlocConsumer(
      onDataReturn: (state) {
        switch (state.data) {
          case List<TeacherListResponse> teacherListResponse:
            return PaginableGridView.builder(
              padding: EdgeInsetsDirectional.symmetric(
                  horizontal: 24.h, vertical: 16.h),
              shrinkWrap: true,
              isLastPage: getBloc.teacherPageData.isLastPage(),
              loadMore: () {
                getBloc.add(LoadTeachersEvent(isPagination: true));
                return Future.value();
              },
              errorIndicatorWidget: (exception, tryAgain) =>
                  PaginateErrorWidget(exception, tryAgain),
              progressIndicatorWidget: const PaginateLoadingIndicatorWidget(),
              itemCount: teacherListResponse.length,
              itemBuilder: (context, index) {
                return TeacherItemWidget(teacherListResponse[index], index,
                    onSubjectTap: onSubjectTap,
                    onAvailabilityTap: onTeacherAvailable);
              },
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: isTablet() ? 3 : 2,
                crossAxisSpacing: 12.h,
                mainAxisSpacing: 12.h,
                childAspectRatio: isTablet()
                    ? ((195 * getScaleFactor()).h) /
                        ((266 * getScaleFactor()).h)
                    : ((165 * getScaleFactor()).w) /
                        ((260 * getScaleFactor()).h),
              ),
            );
        }
      },
      onDataPerform: (state) {},
    );
  }

  @override
  TeacherBloc get getBloc => _bloc;

  void initData() {
    getBloc.add(LoadTeachersEvent());
  }

  void onTeacherAvailable(TeacherListResponse teacherResponse) {
    /*getBloc.fetchTeacherAvailablity(teacherResponse.id, true, (response){
      showDialog(
          context: globalContext,
          builder: (BuildContext context) {
            return TeacherInfoDialogWidget(
              onCloseTapped: () {},
              teacher: teacherResponse,
              availableHours: response,
            );
          });
    });*/
  }

  void onSubjectTap(TeacherListResponse teacherResponse) {
    showDialog(
        context: globalContext,
        builder: (BuildContext context) {
          return TeacherInfoDialogWidget(
            onCloseTapped: () {},
            teacher: teacherResponse,
            availableHours: const [],
          );
        });
  }
}
