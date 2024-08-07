import 'dart:developer';

import 'package:auto_route/auto_route.dart';
import 'package:base_flutter_bloc/base/component/base_bloc.dart';
import 'package:base_flutter_bloc/base/component/base_event.dart';
import 'package:base_flutter_bloc/base/component/base_state.dart';
import 'package:base_flutter_bloc/base/page/base_page.dart';
import 'package:base_flutter_bloc/bloc/home/home_bloc.dart';
import 'package:base_flutter_bloc/bloc/utils/bottom_bar/app_bottom_bar_bloc.dart';
import 'package:base_flutter_bloc/bloc/utils/bottom_bar/app_bottom_bar_bloc_event.dart';
import 'package:base_flutter_bloc/bloc/utils/bottom_bar/app_bottom_bar_bloc_state.dart';
import 'package:base_flutter_bloc/utils/appbar/appbar_divider_widget.dart';
import 'package:base_flutter_bloc/utils/appbar/appbar_profile_view.dart';
import 'package:base_flutter_bloc/utils/appbar/home_appbar.dart';
import 'package:base_flutter_bloc/utils/appbar/trailing_buttons/barcode_appbar_button.dart';
import 'package:base_flutter_bloc/utils/bottom_nav_bar/app_bottom_bar.dart';
import 'package:base_flutter_bloc/utils/bottom_nav_bar/lazy_load_indexed_stack.dart';
import 'package:base_flutter_bloc/utils/bottom_nav_bar/r_nav_item.dart';
import 'package:base_flutter_bloc/utils/common_utils/app_widgets.dart';
import 'package:base_flutter_bloc/utils/common_utils/common_utils.dart';
import 'package:base_flutter_bloc/utils/drawer/app_drawer_widget.dart';
import 'package:base_flutter_bloc/utils/screen_utils/flutter_screenutil.dart';
import 'package:base_flutter_bloc/utils/stream_helper/common_enums.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

@RoutePage()
class HomeScreen extends BasePage {
  final ScreenType fromScreen;

  const HomeScreen({super.key, required this.fromScreen});

  @override
  BasePageState<BasePage, BaseBloc<BaseEvent, BaseState>> getState() =>
      _HomeScreenState();
}

class _HomeScreenState extends BasePageState<HomeScreen, HomeBloc> {
  final HomeBloc _bloc = HomeBloc();

  late final AppBottomBarBloc _appBottomBarBloc;
  List<Widget> screens = [];
  List<RNavItem> bottomTabs = [];

  @override
  void initState() {
    _appBottomBarBloc = context.read<AppBottomBarBloc>();
    if (getBloc.isOtherUser() == true) {
      screens = getBloc.otherUserScreens();
      bottomTabs = getBloc.otherUserTabs();
    } else {
      if (getBloc.isUserTeacher() == true) {
        screens = getBloc.teacherScreens();
        bottomTabs = getBloc.teacherTabs();
      } else {
        screens = getBloc.studentScreens();
        bottomTabs = getBloc.studentTabs();
      }
    }
    super.initState();
  }

  @override
  Widget? get customAppBar => PreferredSize(
      preferredSize: Size.fromHeight(66.h),
      child: BlocConsumer<AppBottomBarBloc, AppBottomBarBlocState>(
        bloc: _appBottomBarBloc,
        buildWhen: (previousIndexState, currentIndexState) {
          return previousIndexState.tabIndex != currentIndexState.tabIndex;
        },
        builder: (context, state) {
          return HomeAppbar.build(
              title: 'Home',
              isShadowApplied: state.tabIndex == 3,
              bottom: const AppBarDividerWidget(),
              onMenuPressed: () {
                openDrawer();
              },
              onSearchPressed: () {},
              trailing: [
                const BarcodeAppBarButton(),
                SizedBox(width: isTablet() ? 6.h : 0),
                state.tabIndex == 0 || state.tabIndex == 1
                    ? AppBarButtonProfileView(
                        student: getBloc.selectedStudent,
                        onStudentClick: (student) {
                          if (student != null) {
                            getBloc.setStudent(student);
                          }
                        },
                      )
                    : const SizedBox()
              ]);
        },
        listener: (context, state) {},
      ));

  @override
  Widget buildWidget(BuildContext context) {
    return genericBlocConsumer<AppBottomBarBloc, AppBottomBarBlocState>(
      bloc: _appBottomBarBloc,
      builder: (state) {
        return LazyLoadIndexedStack(
          index: state.tabIndex ?? 0,
          preloadIndexes: const [],
          children: screens,
        );
      },
    );
  }

  @override
  Widget? get customDrawer {
    return SizedBox(
        width: isTablet() ? 0.65.sw : double.infinity,
        child: const AppDrawerWidget());
  }

  @override
  Widget? get customBottomNavigationBar =>
      genericBlocConsumer<AppBottomBarBloc, AppBottomBarBlocState>(
          bloc: _appBottomBarBloc,
          builder: (state) {
            return AppBottomBar(
                initialSelectedIndex: state.tabIndex,
                isUserTeacher: getBloc.isUserTeacher() == true,
                isUserOther: getBloc.isOtherUser() == true,
                navTabs: bottomTabs,
                onMenuClick: (data, index) {
                  if (index == 0) {
                    Navigator.of(context).pop();
                    Future.delayed(const Duration(milliseconds: 500), () {
                      showToast('Navigate to Send Message Screen');
                    });
                  }
                  if (index == 1) {
                    Navigator.of(context).pop();
                    Future.delayed(const Duration(milliseconds: 500), () {
                      showToast('Navigate to Apply For Leave Screen');
                    });
                  }
                },
                onTabSelected: (index) {
                  log('Current Index is -> $index');
                  _appBottomBarBloc.add(TabChangeEvent(tabIndex: index));
                });
          });

  /*BlocBuilder(
        bloc: _appBottomBarBloc,
        buildWhen: (previousIndexState, currentIndexState) {
          return previousIndexState.tabIndex != currentIndexState.tabIndex;
        },
        builder: (BuildContext context, state) {

        },
      );*/

  @override
  HomeBloc get getBloc => _bloc;

/*  @override
  PageRouteInfo? get backButtonInterceptorRoute => const HomeRoute();

  @override
  Function()? get onCustomBackPress => () {
        log('Custom Back Press Event');
      };*/
}
