import 'package:base_flutter_bloc/base/src_bloc.dart';
import 'package:base_flutter_bloc/bloc/home/home_bloc.dart';
import 'package:base_flutter_bloc/bloc/learning/learning_bloc.dart';
import 'package:base_flutter_bloc/screens/learning/subject/subject_screen.dart';
import 'package:base_flutter_bloc/screens/learning/teacher/teacher_screen.dart';
import 'package:base_flutter_bloc/utils/screen_utils/flutter_screen_util.dart';
import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../remote/repository/user/response/academic_periods_response.dart';
import '../../remote/repository/user/response/student_relative_extended.dart';
import '../../utils/common_utils/common_utils.dart';
import '../../utils/constants/app_styles.dart';
import '../../utils/dropdown/custom_dropdown.dart';
import '../../utils/dropdown/dropdown_option_model.dart';
import '../../utils/screen_utils/keep_alive_widget.dart';
import '../../utils/stream_helper/menu_utils.dart';
import '../../utils/widgets/custom_decoration.dart';
import '../../utils/widgets/custom_tabs/custom_tab_button.dart';
import '../../utils/widgets/terminologies_utils.dart';

class LearningScreen extends BasePage {
  const LearningScreen({super.key});

  @override
  BasePageState<BasePage, BaseBloc<BaseEvent, BaseState>> get getState =>
      _LearningScreenState();
}

class _LearningScreenState extends BasePageState<LearningScreen, LearningBloc>
    with SingleTickerProviderStateMixin {
  final LearningBloc _bloc = LearningBloc();
  final MenuUtils menuUtils = MenuUtils();
  late TabController _tabController;

  List<Widget> screens(int? studentId) {
    List<Widget> tabScreens = [];
    if (menuUtils.isLearningSubjectsMenu(getBloc.isUserParent)) {
      tabScreens.add(StreamBuilder<AcademicPeriodResponse?>(
          stream: getBloc.currentPeriodStream,
          builder: (context, snapshot) {
            if (snapshot.hasData && snapshot.data != null) {
              return KeepAlivePage(
                  key: ValueKey(snapshot.data?.id),
                  child: SubjectScreen(
                      studentId: studentId, periodId: snapshot.data?.id));
            } else {
              return const SizedBox();
            }
          }));
    }
    if (menuUtils.isLearningTeachersMenu(getBloc.isUserParent)) {
      tabScreens.add(KeepAlivePage(child: TeacherScreen(studentId: studentId)));
    }
    if (menuUtils.isTimeTableMenu()) {
      tabScreens.add(const KeepAlivePage(
          child: /*TimeTableScreen(studentId)*/
              Center(child: Text('Time Table Screen'))));
    }
    return tabScreens;
  }

  List<String> get tabs {
    List<String> customTabs = [];

    if (menuUtils.isLearningSubjectsMenu(getBloc.isUserParent)) {
      customTabs.add(subjectsLiteral());
    }
    if (menuUtils.isLearningTeachersMenu(getBloc.isUserParent)) {
      customTabs.add(teachersLiteral());
    }
    if (menuUtils.isTimeTableMenu()) {
      customTabs.add(string('timetable.title_time_table_text'));
    }
    return customTabs;
  }

  Widget buildAcademicPeriodDropdownWidget() {
    return StreamBuilder<List<AcademicPeriodResponse>>(
        stream: appBloc.academicPeriodList.stream,
        builder: (context, snapshot) {
          if (snapshot.hasData && snapshot.data?.isNotEmpty == true) {
            AcademicPeriodResponse? selectedPeriod =
                getBloc.currentPeriod.value;
            DropDownOptionModel? selectedValue;
            if (selectedPeriod != null) {
              selectedValue = DropDownOptionModel(
                  key: selectedPeriod.id, value: selectedPeriod.description);
            }
            return CustomDropdown(
                hint: string('common_labels.label_academic_period'),
                items: getAcademicPeriods(snapshot.data ?? []),
                initialValue: selectedValue,
                onClick: (DropDownOptionModel? val) {
                  List<AcademicPeriodResponse> periods = snapshot.data ?? [];
                  AcademicPeriodResponse? clickPeriod = periods
                      .firstWhereOrNull((element) => element.id == val?.key);
                  if (clickPeriod != null) {
                    if (clickPeriod.id != getBloc.currentPeriod.value?.id) {
                      if (!getBloc.currentPeriod.isClosed) {
                        getBloc.currentPeriod.add(clickPeriod);
                      }
                    }
                  }
                });
          } else {
            return const SizedBox();
          }
        });
  }

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: tabs.length, vsync: this);
    _tabController.addListener(() {
      _handleTabChange(_tabController.index);
    });
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  bool get enableBackPressed => false;

  @override
  Widget buildWidget(BuildContext context) {
    if (tabs.isEmpty) {
      return Padding(
        padding: EdgeInsets.all(16.h),
        child: Center(
            child: Text(
          string("common_labels.label_not_accessible",
              {"menu": string("common_labels.appbar_title_learning")}),
          textAlign: TextAlign.center,
          style: styleMedium1,
        )),
      );
    } else {
      return genericBlocConsumer<HomeBloc, BaseState>(
        bloc: context.read<HomeBloc>(),
        builder: (state) {
          switch (state.data) {
            case StudentForRelativeExtended studentForRelativeExtended:
              List<Widget> tabScreens = screens(studentForRelativeExtended.id);
              return DefaultTabController(
                length: tabScreens.length,
                key: UniqueKey(),
                initialIndex: getBloc.currentIndex.value,
                child: Column(
                  children: [
                    buildTopView(),
                    Expanded(
                      child: TabBarView(
                        controller: _tabController,
                        children: List.generate(
                            tabScreens.length, (index) => tabScreens[index]),
                      ),
                    )
                  ],
                ),
              );
          }
        },
      );
      /*return StreamBuilder<StudentForRelativeExtended?>(
          stream: context.read<HomeBloc>().selectedStudentStream,
          builder: (context, snapshot) {
            List<Widget> tabScreens = screens(snapshot.data?.id);
            return DefaultTabController(
              length: tabScreens.length,
              key: UniqueKey(),
              initialIndex: getBloc.currentIndex.value,
              child: Column(
                children: [
                  buildTopView(),
                  Expanded(
                    child: TabBarView(
                      controller: _tabController,
                      children: List.generate(
                          tabScreens.length, (index) => tabScreens[index]),
                    ),
                  )
                ],
              ),
            );
          });*/
    }
  }

  @override
  LearningBloc get getBloc => _bloc;

  List<DropDownOptionModel> getAcademicPeriods(
      List<AcademicPeriodResponse> periods) {
    return periods
        .map((e) => DropDownOptionModel(key: e.id, value: e.description))
        .toList();
  }

  void _handleTabChange(int index) {
    if (!getBloc.currentIndex.isClosed) {
      getBloc.currentIndex.add(index);
    }
  }

  Widget buildTabs() {
    return CustomTabButton(
      tabs,
      tabController: _tabController,
      margin: EdgeInsetsDirectional.fromSTEB(12.h, 12.h, 12.h, 0.h),
      height: 40.h,
      onTap: (index) {
        _handleTabChange(index);
      },
    );
  }

  /// Tabs and dropdown for subjects tab
  Widget buildTopView() {
    return Container(
      margin: EdgeInsetsDirectional.only(bottom: 6.h),
      width: double.infinity,
      padding: EdgeInsetsDirectional.fromSTEB(12.h, 6.h, 0.h, 24.h),
      decoration: getAppBarShadowDecoration(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          buildTabs(),
          StreamBuilder<int>(
              stream: getBloc.currentIndexStream,
              builder: (context, snapshot) {
                if (snapshot.hasData && snapshot.data == 0) {
                  if (menuUtils.isLearningSubjectsMenu(getBloc.isUserParent)) {
                    return Container(
                      padding:
                          EdgeInsetsDirectional.fromSTEB(12.h, 14.h, 24.h, 0),
                      child: buildAcademicPeriodDropdownWidget(),
                    );
                  } else {
                    return const SizedBox();
                  }
                } else {
                  return const SizedBox();
                }
              })
        ],
      ),
    );
  }
}
