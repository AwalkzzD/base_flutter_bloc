import 'package:base_flutter_bloc/base/component/base_bloc.dart';
import 'package:base_flutter_bloc/base/component/base_event.dart';
import 'package:base_flutter_bloc/base/component/base_state.dart';
import 'package:base_flutter_bloc/base/page/base_page.dart';
import 'package:base_flutter_bloc/bloc/home/home_bloc.dart';
import 'package:base_flutter_bloc/bloc/utils/bottom_bar/app_bottom_bar_bloc.dart';
import 'package:base_flutter_bloc/bloc/utils/bottom_bar/app_bottom_bar_bloc_event.dart';
import 'package:base_flutter_bloc/bloc/utils/bottom_bar/app_bottom_bar_bloc_state.dart';
import 'package:base_flutter_bloc/utils/auth/user_init_api.dart';
import 'package:base_flutter_bloc/utils/bottom_nav_bar/app_bottom_bar.dart';
import 'package:base_flutter_bloc/utils/bottom_nav_bar/r_nav_item.dart';
import 'package:base_flutter_bloc/utils/common_utils/app_widgets.dart';
import 'package:base_flutter_bloc/utils/common_utils/common_utils.dart';
import 'package:base_flutter_bloc/utils/screen_utils/flutter_screen_util.dart';
import 'package:base_flutter_bloc/utils/stream_helper/common_enums.dart';
import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../bloc/home/home_bloc_event.dart';
import '../../remote/repository/consents/response/consents_student_response.dart';
import '../../remote/repository/settings/response/app_settings_response.dart';
import '../../remote/repository/user/response/student_relative_extended.dart';
import '../../utils/appbar/appbar_divider_widget.dart';
import '../../utils/appbar/appbar_profile_view.dart';
import '../../utils/appbar/home_appbar.dart';
import '../../utils/appbar/trailing_buttons/barcode_appbar_button.dart';
import '../../utils/auth/user_common_api.dart';
import '../../utils/bottom_nav_bar/lazy_load_indexed_stack.dart';
import '../../utils/common_utils/shared_pref.dart';
import '../../utils/constants/app_colors.dart';
import '../../utils/enum_to_string/enum_to_string.dart';
import '../../utils/screen_utils/keep_alive_widget.dart';
import '../../utils/stream_helper/settings_utils.dart';
import '../../utils/widgets/dialogs/consent_dialog.dart';
import '../dashboard/dashboard_screen.dart';
import '../drawer/app_drawer_widget.dart';
import '../learning/learning_screen.dart';

class HomeScreen extends BasePage {
  final ScreenType fromScreen;

  const HomeScreen({super.key, required this.fromScreen});

  @override
  BasePageState<BasePage, BaseBloc<BaseEvent, BaseState>> get getState =>
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
    if (getBloc.isOtherUser == true) {
      screens = getBloc.otherUserScreens();
      bottomTabs = getBloc.otherUserTabs();
    } else {
      if (getBloc.isUserTeacher == true) {
        screens = getBloc.teacherScreens();
        bottomTabs = getBloc.teacherTabs();
      } else {
        screens = studentScreens();
        bottomTabs = getBloc.studentTabs();
      }
    }
    super.initState();
  }

  List<Widget> studentScreens() => [
        customBlocConsumer(
            onDataReturn: (state) {
              switch (state.data) {
                case StudentForRelativeExtended studentForRelativeExtended:
                  return KeepAlivePage(
                    child: DashboardScreen(
                      key: ObjectKey(getLanguage()),
                    ),
                  );
              }
            },
            onDataPerform: (state) {}),
        KeepAlivePage(child: LearningScreen(key: ObjectKey(getLanguage()))),
        KeepAlivePage(child: Container(color: black)),
        KeepAlivePage(child: Container(color: red)),
      ];

  @override
  Future<void> onReady() async {
    initAPIData();
    getBloc.add(GetSelectedStudentEvent());
  }

  @override
  Widget? get customAppBar => PreferredSize(
        preferredSize: Size.fromHeight(66.h),
        child: genericBlocConsumer<AppBottomBarBloc, AppBottomBarBlocState>(
          bloc: _appBottomBarBloc,
          builder: (state) => HomeAppbar.build(
              title: 'Home',
              isShadowApplied: state.tabIndex == 3,
              bottom: const AppBarDividerWidget(),
              onMenuPressed: () => openDrawer(),
              onSearchPressed: () {},
              trailing: [
                const BarcodeAppBarButton(),
                SizedBox(width: isTablet() ? 6.h : 0),
                state.tabIndex == 0 || state.tabIndex == 1
                    ? AppBarButtonProfileView(
                        student: getBloc.selectedStudent,
                        onStudentClick: (student) {
                          if (student != null) {
                            getBloc.add(SetSelectedStudentEvent(
                                studentForRelativeExtended: student));
                          }
                        },
                      )
                    : const SizedBox()
              ]),
          buildWhen: (previousIndexState, currentIndexState) =>
              previousIndexState.tabIndex != currentIndexState.tabIndex,
        ),
      );

  @override
  Widget buildWidget(BuildContext context) {
    return customBlocConsumer(
      onDataReturn: (state) {
        return genericBlocConsumer<AppBottomBarBloc, AppBottomBarBlocState>(
          bloc: _appBottomBarBloc,
          builder: (state) {
            return LazyLoadIndexedStack(
              index: state.tabIndex,
              preloadIndexes: const [],
              children: screens,
            );
          },
        );
      },
      onDataPerform: (state) {
        switch (state.data) {
          case AppSettingsResponse? appSettingsResponse:
            getBloc.add(CheckConsentsEvent());

          case Map<int, List<ConsentsStudentsResponse>>?
            unAnsweredRequiredConsents:
            hideLoader();
            if (unAnsweredRequiredConsents != null) {
              handleUnAnsweredRequiredConsents(unAnsweredRequiredConsents);
            }
        }
      },
    );
  }

  @override
  Widget? get customDrawer => SizedBox(
      width: isTablet() ? 0.65.sw : double.infinity,
      child: AppDrawerWidget(closeDrawerFunc: () => closeDrawer()));

  @override
  Widget? get customBottomNavigationBar =>
      genericBlocConsumer<AppBottomBarBloc, AppBottomBarBlocState>(
          bloc: _appBottomBarBloc,
          builder: (state) {
            return AppBottomBar(
                initialSelectedIndex: state.tabIndex,
                isUserTeacher: getBloc.isUserTeacher == true,
                isUserOther: getBloc.isOtherUser == true,
                navTabs: bottomTabs,
                onMenuClick: (data, index) {
                  if (index == 0) {
                    router.pop();
                    Future.delayed(const Duration(milliseconds: 500), () {
                      showToast('Navigate to Send Message Screen');
                    });
                  }
                  if (index == 1) {
                    router.pop();
                    Future.delayed(const Duration(milliseconds: 500), () {
                      showToast('Navigate to Apply For Leave Screen');
                    });
                  }
                },
                onTabSelected: (index) {
                  _appBottomBarBloc.add(TabChangeEvent(tabIndex: index));
                });
          });

  @override
  HomeBloc get getBloc => _bloc;

  @override
  bool get customBackPressed => true;

  @override
  void onBackPressed(bool didPop, BuildContext context) {
    if (!didPop) {
      if (isDrawerOpen()) {
        closeDrawer();
      } else {
        if (_appBottomBarBloc.currentIndex != 0) {
          _appBottomBarBloc.add(TabChangeEvent(tabIndex: 0));
        } else if (_appBottomBarBloc.currentIndex == 0) {
          SystemNavigator.pop();
        } else {
          router.maybePop();
        }
      }
    }
  }

  void initAPIData() {
    if (widget.fromScreen == ScreenType.normal) {
    } else if (widget.fromScreen == ScreenType.language) {
      loadTerminology();
    } else if (widget.fromScreen == ScreenType.login) {
      showLoader();
      loadQRSettings(() {
        checkConsents(() {
          hideLoader();
        });
      });
    } else if (widget.fromScreen == ScreenType.splash) {
      showLoader();
      initUserAPI((err) {}).then((response) {
        // getBloc.add(LoadQrSettingsEvent());
        loadQRSettings(() {
          checkConsents(() {
            hideLoader();
          });
        });
      });
    } else if (widget.fromScreen == ScreenType.drawer) {
      showLoader();
      loadGetParentChildAndEducationalPrograms((response) async {
        appBloc.refreshData();
        loadQRSettings(() {
          checkConsents(() {
            hideLoader();
          });
        });
      }, (err) {});
    } else {}
  }

  Future<void> loadQRSettings(Function() success) async {
    if (getBloc.isOtherUser == true) {
      success.call();
    } else {
      getBloc.loadStudentQRCodeSettings((settingResponse) {
        AppSettingsResponse? showQrCode = settingResponse.firstWhereOrNull(
            (element) =>
                element.setting ==
                EnumToString.convertToString(SettingsValue.ShowStudentQrCode));
        if (showQrCode != null) {
          String showQrCodeValue = showQrCode.value.toString();
          if (showQrCodeValue.toLowerCase() == "true") {
            appBloc.setShowStudentQrCode(true);
          } else {
            appBloc.setShowStudentQrCode(false);
          }
        }
        success.call();
      });
    }
  }

  /*
  *  Method will get required and not required consent
  *  Required consents will be shown in Dialog
  *  Not required consent will be shown in Home screen consent area
  * */
  void checkConsents(Function() onSuccess) {
    if (getBloc.isOtherUser == true) {
      onSuccess.call();
    } else {
      loadRequiredConsents(getBloc.selectedStudent.value?.id, true, () {
        loadRequiredConsents(getBloc.selectedStudent.value?.id, false, () {
          Map<int, List<ConsentsStudentsResponse>> unAnsweredRequiredConsents =
              appBloc.requiredUnAnsweredConsentsList.value;

          handleUnAnsweredRequiredConsents(unAnsweredRequiredConsents);
          onSuccess.call();
        }, (err) {});
      }, (err) {});
    }
  }

  void loadTerminology() {
    showLoader();
    getTerminologies((menus) {
      hideLoader();
    }, (error) {
      hideLoader();
      /*getBloc().showError(error, () {
        loadTerminology();
      });*/
    });
  }

  void handleUnAnsweredRequiredConsents(
      Map<int, List<ConsentsStudentsResponse>> unAnsweredRequiredConsents) {
    bool showRequiredDialog =
        unAnsweredRequiredConsents.values.any((value) => value.isNotEmpty);

    if (showRequiredDialog) {
      // if (getAppBloc()!.requiredUnAnsweredConsentsList.value.isNotEmpty) {
      /// Scenario 1 : Show dialog that navigates the user to Consent screen with forced consents list.
      bool barrierDismissible = appBloc.disallowClosingMandatoryConsentsDialog;
      ConsentDialog.showAlertDialog(
        context,
        barrierDismissible,
        onPositiveButtonClicked: () {
          router.pop();
          // todo: router.push(AppRouter.consentsRoute, arguments: CustomRouteArguments(contentViewType: ContentViewType.required ,selectedStudentId: getBloc.selectedStudent.value?.id ?? -1, something: null));
        },
      );
    }
  }
}
