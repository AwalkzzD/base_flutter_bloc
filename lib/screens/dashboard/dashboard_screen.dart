import 'package:base_flutter_bloc/base/src_bloc.dart';
import 'package:base_flutter_bloc/bloc/dashboard/dashboard_bloc.dart';
import 'package:base_flutter_bloc/bloc/dashboard/dashboard_bloc_event.dart';
import 'package:base_flutter_bloc/bloc/home/home_bloc.dart';
import 'package:base_flutter_bloc/screens/dashboard/plans/plans_screen.dart';
import 'package:base_flutter_bloc/screens/dashboard/todo/todo_screen.dart';
import 'package:base_flutter_bloc/screens/dashboard/widget_items/announcement_central_item_widget.dart';
import 'package:base_flutter_bloc/screens/dashboard/widget_items/unanswered_consent_item.dart';
import 'package:base_flutter_bloc/utils/common_utils/app_widgets.dart';
import 'package:base_flutter_bloc/utils/screen_utils/flutter_screen_util.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:persistent_header_adaptive/persistent_header_adaptive.dart';

import '../../remote/repository/announcements/announcement_central/response/detail/announcement_detail_response.dart';
import '../../remote/repository/consents/response/consents_student_response.dart';
import '../../remote/repository/user/response/student_relative_extended.dart';
import '../../utils/common_utils/common_utils.dart';
import '../../utils/common_utils/shared_pref.dart';
import '../../utils/paginable/paginable_listview.dart';
import '../../utils/paginable/widgets/paginate_error_widget.dart';
import '../../utils/paginable/widgets/paginate_loading_indicator.dart';
import '../../utils/screen_utils/keep_alive_widget.dart';
import '../../utils/widgets/custom_tabs/custom_tab_indicator.dart';

class DashboardScreen extends BasePage {
  const DashboardScreen({super.key});

  @override
  BasePageState<BasePage, BaseBloc<BaseEvent, BaseState>> get getState =>
      _DashboardScreenState();
}

class _DashboardScreenState
    extends BasePageState<DashboardScreen, DashboardBloc> {
  final DashboardBloc _bloc = DashboardBloc();
  late HomeBloc homeBloc;

  List<Widget> screens = [];
  List<Widget> tabs = [];

  @override
  bool get enableBackPressed => false;

  @override
  void initState() {
    homeBloc = context.read<HomeBloc>();
    super.initState();
    initTabs();
  }

  @override
  void onReady() {
    getBloc.add(LoadAnnouncementsCentralEvent());
  }

  @override
  Widget buildWidget(BuildContext context) {
    return CustomScrollView(slivers: [
      AdaptiveHeightSliverPersistentHeader(
        floating: true,
        needRepaint: true,
        child: buildAnnouncements(),
      ),
      if (appBloc.notRequiredUnAnsweredConsentsList.value.isNotEmpty)
        AdaptiveHeightSliverPersistentHeader(
          floating: true,
          needRepaint: true,
          child: buildUnAnsweredNotRequiredConsents(),
        ),
      SliverFillRemaining(child: buildCalenderView())
    ]);
  }

  @override
  DashboardBloc get getBloc => _bloc;

  List<int> getDashboardMenuElements() {
    List<int> elements = [];
    String value = getDashboardElements();
    if (value.isNotEmpty) {
      elements = value.split(',').map(int.parse).toList();
    }
    return elements;
  }

  bool isMyPlanVisible() {
    bool flag = true;
    List<int> elements = getDashboardMenuElements();
    if (elements.isNotEmpty) {
      if (homeBloc.isUserStudent == true) {
        if (elements.contains(1)) {
          flag = false;
        }
      }
      if (homeBloc.isUserParent == true) {
        if (elements.contains(1)) {
          flag = false;
        }
      }
    }
    return flag;
  }

  bool isMyTodoVisible() {
    bool flag = true;
    List<int> elements = getDashboardMenuElements();
    if (elements.isNotEmpty) {
      if (homeBloc.isUserStudent == true) {
        if (elements.contains(6)) {
          flag = false;
        }
      }
      if (homeBloc.isUserParent == true) {
        if (elements.contains(6)) {
          // Todos
          flag = false;
        }
      }
    }
    return flag;
  }

  void initTabs() {
    // tabs
    if (isMyPlanVisible()) {
      tabs.add(Tab(height: 46.h, text: string('dashboard.label_my_plan')));
    }
    if (isMyTodoVisible()) {
      tabs.add(Tab(height: 46.h, text: string('dashboard.label_to_do')));
    }

    // screens
    if (isMyPlanVisible()) {
      screens.add(buildPlanScreen());
    }
    if (isMyTodoVisible()) {
      screens.add(buildToDoScreen());
    }
  }

  Widget buildPlanScreen() {
    return homeBloc.isUserParent == true
        ? StreamBuilder<StudentForRelativeExtended?>(
            stream: homeBloc.selectedStudent.stream,
            builder: (context, snapshot) {
              return KeepAlivePage(
                  key: ValueKey(snapshot.data?.id),
                  child: PlanScreen(studentId: snapshot.data?.id));
            })
        : const KeepAlivePage(child: PlanScreen());
  }

  Widget buildToDoScreen() {
    return homeBloc.isUserTeacher == true
        ? const KeepAlivePage(child: TodoScreen())
        : StreamBuilder<StudentForRelativeExtended?>(
            stream: homeBloc.selectedStudent.stream,
            builder: (context, snapshot) {
              return KeepAlivePage(
                  key: ValueKey(snapshot.data?.id),
                  child: TodoScreen(studentId: snapshot.data?.id));
            });
  }

  Widget buildAnnouncements() {
    if (getBloc.isOtherUser == true) {
      return const SizedBox();
    } else {
      return customBlocConsumer(
          onDataReturn: (state) {
            switch (state.data) {
              case List<AnnouncementDetailResponse> announcementDetailList:
                if (announcementDetailList.isNotEmpty) {
                  return buildAnnouncementList(data: announcementDetailList);
                } else {
                  return const SizedBox();
                }
            }
          },
          onDataPerform: (state) {});
    }
  }

  Widget buildAnnouncementList({List<AnnouncementDetailResponse>? data}) {
    return ConstrainedBox(
      constraints: BoxConstraints(
        minHeight: 80.h * getScaleFactorHeight(),
        maxHeight: 130.h * getScaleFactorHeight(),
      ),
      child: Container(
          color: Theme.of(context).appBarTheme.backgroundColor,
          padding:
              EdgeInsetsDirectional.only(start: 24.h, bottom: 0.h, top: 16.h),
          child: PaginableListView.separated(
              scrollDirection: Axis.horizontal,
              isLastPage: getBloc.pageData.isLastPage(),
              loadMore: () {
                return getBloc.loadAnnouncementsCentral(
                    isPagination: true,
                    onSuccess: (response) {
                      getBloc.announcementCentralList.add(response);
                    },
                    onError: (error) {
                      showToast(error.errorMsg);
                    });
              },
              errorIndicatorWidget: (exception, tryAgain) =>
                  PaginateErrorWidget(exception, tryAgain),
              progressIndicatorWidget: const PaginateLoadingIndicatorWidget(),
              itemCount: data?.length ?? 0,
              itemBuilder: (context, index) {
                return AnnouncementCentralItemWidget(
                  data: data?[index],
                );
              },
              separatorBuilder: (BuildContext context, int index) {
                return SizedBox(height: 12.h);
              })),
    );
  }

  Widget buildCalenderView() {
    if (getBloc.isOtherUser == true) {
      return buildPlanScreen();
    } else {
      return DefaultTabController(
        length: tabs.length,
        child: Column(
          children: [
            CustomTabIndicator(tabs),
            Expanded(
              child: TabBarView(
                children: screens
                    .map((widget) => KeepAlivePage(child: widget))
                    .toList(),
              ),
            ),
          ],
        ),
      );
    }
  }

  Widget buildUnAnsweredNotRequiredConsents() {
    return StreamBuilder<Map<int, List<ConsentsStudentsResponse>>>(
        stream: appBloc.unAnsweredNotRequiredConsentsListStream,
        builder: (context, snapshot) {
          if (snapshot.hasData && snapshot.data?.isNotEmpty == true) {
            return buildUnAnsweredNotRequiredConsentsList(snapshot.data ?? {});
          } else {
            return const SizedBox();
          }
        });
  }

  Widget buildUnAnsweredNotRequiredConsentsList(
      Map<int, List<ConsentsStudentsResponse>> data) {
    return Container(
      color: Theme.of(context).appBarTheme.backgroundColor,
      child: ListView.builder(
        shrinkWrap: true,
        itemCount: data.length,
        itemBuilder: (context, index) {
          int userId = data.keys.elementAt(index);
          List<ConsentsStudentsResponse> consentsList =
              data.values.elementAt(index);
          if (consentsList.isNotEmpty) {
            return UnansweredConsentItem(
              userId: userId,
              consentsList: consentsList,
              onConsentTap: (value) async {
                /*final result = await Navigator.of(context).push(
                    ConsentsScreen.route(
                        ConsentViewType.NotRequired, userId, value));
                if (result != null) {
                  //todo refresh
                }*/
              },
            );
          } else {
            return const SizedBox();
          }
        },
      ),
    );
  }
}
