import 'package:base_flutter_bloc/base/routes/router/app_router.dart';
import 'package:base_flutter_bloc/base/routes/router_utils/custom_route_arguments.dart';
import 'package:base_flutter_bloc/base/src_bloc.dart';
import 'package:base_flutter_bloc/bloc/utils/drawer/app_drawer_bloc.dart';
import 'package:base_flutter_bloc/remote/repository/settings/response/mobile_license_menu.dart';
import 'package:base_flutter_bloc/remote/repository/user/response/academic_periods_response.dart';
import 'package:base_flutter_bloc/remote/repository/user/response/institute_response.dart';
import 'package:base_flutter_bloc/remote/repository/user/response/user_response.dart';
import 'package:base_flutter_bloc/utils/appbar/common_profile_view.dart';
import 'package:base_flutter_bloc/utils/auth/request_properties.dart';
import 'package:base_flutter_bloc/utils/common_utils/app_widgets.dart';
import 'package:base_flutter_bloc/utils/common_utils/common_utils.dart';
import 'package:base_flutter_bloc/utils/common_utils/shared_pref.dart';
import 'package:base_flutter_bloc/utils/constants/app_images.dart';
import 'package:base_flutter_bloc/utils/constants/app_theme.dart';
import 'package:base_flutter_bloc/utils/screen_utils/flutter_screen_util.dart';
import 'package:base_flutter_bloc/utils/stream_helper/common_enums.dart';
import 'package:base_flutter_bloc/utils/stream_helper/menu_utils.dart';
import 'package:base_flutter_bloc/utils/widgets/image_view.dart';
import 'package:base_flutter_bloc/utils/widgets/strings_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../auth/auth_utils.dart';
import '../constants/app_styles.dart';
import '../widgets/terminologies_utils.dart';

class AppDrawerWidget extends BasePage {
  final Function() closeDrawerFunc;

  const AppDrawerWidget({super.key, required this.closeDrawerFunc});

  @override
  BasePageState<BasePage, BaseBloc<BaseEvent, BaseState>> getState() =>
      _AppDrawerWidgetState();
}

/// ---------------------------------------------------------------------------------------------

class _AppDrawerWidgetState
    extends BasePageState<AppDrawerWidget, AppDrawerBloc> {
  final AppDrawerBloc _bloc = AppDrawerBloc();

  final MenuUtils menuUtils = MenuUtils();

  @override
  bool get enableBackPressed => false;

  @override
  SystemUiOverlayStyle getSystemUIOverlayStyle() {
    return themeOf().uiOverlayStyleDrawer();
  }

  @override
  Widget buildWidget(BuildContext context) {
    return SafeArea(
      child: Container(
        decoration: BoxDecoration(
            image: DecorationImage(
          fit: BoxFit.fill,
          image: AssetImage(
            themeOf().lightMode()
                ? AppImages.bgDrawerLight
                : AppImages.bgDrawerDark,
          ),
        )),
        child: Column(
          children: [
            buildInstituteWidget(),
            buildOptionsView(),
            buildProfileWidget()
          ],
        ),
      ),
    );
  }

  Future<void> setPeriod(AcademicPeriodResponse academicPeriodResponse) async {
    RequestProperties? requestProperties = getRequestProperties();

    if (requestProperties?.periodCode != academicPeriodResponse.id.toString()) {
      await requestProperties
          ?.initializePeriodCode(academicPeriodResponse.id.toString());
      saveRequestProperties(requestProperties);

      appBloc.academicPeriod.add(academicPeriodResponse);
      saveAcademicPeriod(academicPeriodResponse);
      if (!globalContext.mounted) return;

      globalRouter.pop();
      // Navigator.pop(globalContext);

      globalRouter.pushReplacementNamed(AppRouter.homeRoute,
          arguments: CustomRouteArguments(fromScreen: ScreenType.drawer));
      /*Navigator.of(globalContext)
          .pushReplacement(HomeScreen.route(screenType: ScreenType.Drawer));*/
    }
  }

  Widget buildProfileWidget() {
    return StreamBuilder<UserResponse?>(
        stream: appBloc.user.stream,
        builder: (context, snapshot) {
          if (snapshot.hasData && snapshot.data != null) {
            UserResponse? userResponse = snapshot.data;
            return Container(
              margin: EdgeInsetsDirectional.only(top: 40.h),
              child: Stack(
                clipBehavior: Clip.none,
                children: [
                  PositionedDirectional(
                    top: -55.h,
                    start: 0,
                    end: 0,
                    child: ImageView(
                      image: themeOf().lightMode()
                          ? AppImages.bgDrawerProfileLight
                          : AppImages.bgDrawerProfileDark,
                      imageType: ImageType.asset,
                      boxFit: BoxFit.fitWidth,
                    ),
                  ),
                  Container(
                      color: themeOf().bottomBarColor,
                      padding: EdgeInsetsDirectional.only(
                          start: 24.h, end: 24.h, bottom: 40.h),
                      child: Row(
                        children: [
                          CommonProfileView(
                            image: userResponse?.image ?? "",
                            text: getFullName(
                                userResponse?.givenName, userResponse?.surname),
                            size: 56.h,
                            boxFit: BoxFit.cover,
                            borderRadius: 10,
                            borderColor: themeOf().appBarTextColor,
                          ),
                          SizedBox(
                            width: 15.w,
                          ),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  getFullName(userResponse?.givenName,
                                      userResponse?.surname),
                                  style: styleSmall4SemiBold.copyWith(
                                      color: themeOf().lightMode()
                                          ? themeOf().accentColor
                                          : Colors.white),
                                ),
                                SizedBox(
                                  height: 8.h,
                                ),
                                InkWell(
                                  onTap: () {
                                    /*Navigator.pop(globalContext);
                                    Navigator.push(
                                        globalContext, ProfileScreen.route());*/
                                  },
                                  child: Container(
                                      padding: EdgeInsets.symmetric(
                                          horizontal: 10.h, vertical: 6.h),
                                      decoration: BoxDecoration(
                                          color: themeOf().cardBgColor,
                                          border: Border.all(
                                              color: themeOf().cardBorderColor,
                                              width: 1),
                                          borderRadius: const BorderRadius.all(
                                              Radius.circular(6))),
                                      child: Text(
                                        string(
                                            'profile.title_my_profile_all_caps'),
                                        style: styleSmall3Medium.copyWith(
                                            color:
                                                themeOf().textSecondaryColor),
                                      )),
                                )
                              ],
                            ),
                          ),
                          Container(
                            margin: EdgeInsetsDirectional.only(
                                start: 10.h, top: 10.h, bottom: 10.h),
                            child: IconButton(
                              onPressed: logout,
                              icon: ImageView(
                                image: AppImages.icLogout,
                                imageType: ImageType.svg,
                                width: 20.h,
                                height: 20.h,
                                color: themeOf().iconColor,
                              ),
                            ),
                          )
                        ],
                      )),
                ],
              ),
            );
          } else {
            return const SizedBox();
          }
        });
  }

  Widget buildInstituteWidget() {
    return StreamBuilder<InstituteResponse?>(
        stream: appBloc.institute.stream,
        builder: (context, snapshot) {
          if (snapshot.hasData && snapshot.data != null) {
            InstituteResponse? companyResponse = snapshot.data;
            return Container(
                padding: EdgeInsetsDirectional.only(
                    start: 24.h, top: 12.h, end: 24.h),
                margin: EdgeInsetsDirectional.only(top: 20.h),
                decoration: BoxDecoration(
                  color: themeOf().lightMode()
                      ? themeOf().primaryColor.withOpacity(0.5)
                      : themeOf().bottomBarColor,
                ),
                child: Padding(
                  padding: EdgeInsetsDirectional.only(bottom: 16.h),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      CommonProfileView(
                        image: getBase64Image(companyResponse?.image ?? ""),
                        text: "${companyResponse?.description}",
                        size: 40.h,
                        borderColor: themeOf().appBarTextColor,
                        boxFit: BoxFit.cover,
                      ),
                      SizedBox(
                        width: 15.h,
                      ),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "${companyResponse?.description}",
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                              style: styleSmall4Regular,
                            ),
                            SizedBox(height: 6.h),
                            StreamBuilder<List<AcademicPeriodResponse>>(
                                stream: appBloc.academicPeriodList.stream,
                                builder: (context, snapshot) {
                                  if (snapshot.hasData &&
                                      snapshot.data != null) {
                                    return StreamBuilder<
                                            AcademicPeriodResponse?>(
                                        stream: appBloc.academicPeriod.stream,
                                        builder: (context, selectedSnapshot) {
                                          return Container(
                                            height: 30.h * getScaleFactor(),
                                            decoration: BoxDecoration(
                                              color: themeOf().lightMode()
                                                  ? const Color(0xFFA73D40)
                                                  : themeOf().dropdownBgColor,
                                              borderRadius:
                                                  BorderRadius.circular(4),
                                              border: Border.all(
                                                color: themeOf().lightMode()
                                                    ? const Color(0xFFBC7072)
                                                    : themeOf()
                                                        .dropdownBorderColor,
                                              ),
                                            ),
                                            padding: EdgeInsets.symmetric(
                                                horizontal: 8.h),
                                            child: DropdownButton<
                                                AcademicPeriodResponse>(
                                              padding: EdgeInsets.zero,
                                              value: selectedSnapshot.data,
                                              style: styleSmall2.copyWith(
                                                  color: themeOf().lightMode()
                                                      ? Colors.white
                                                      : themeOf()
                                                          .textPrimaryColor),
                                              underline: Container(),
                                              dropdownColor: themeOf()
                                                      .lightMode()
                                                  ? themeOf().primaryColor
                                                  : themeOf().dropdownBgColor,
                                              icon: ImageView(
                                                  image: AppImages
                                                      .icDrawerDateDropDown,
                                                  imageType: ImageType.svg,
                                                  width: 10.h,
                                                  height: 6.h,
                                                  color: Colors.white),
                                              items: snapshot.data?.map(
                                                  (AcademicPeriodResponse
                                                      value) {
                                                return DropdownMenuItem<
                                                    AcademicPeriodResponse>(
                                                  value: value,
                                                  child: Container(
                                                    margin:
                                                        EdgeInsetsDirectional
                                                            .only(end: 8.h),
                                                    child: Text(
                                                      value.description
                                                          .toString(),
                                                      style:
                                                          styleSmall3MediumWhite,
                                                    ),
                                                  ),
                                                );
                                              }).toList(),
                                              onChanged:
                                                  (AcademicPeriodResponse?
                                                      value) {
                                                if (value != null) {
                                                  setPeriod(value);
                                                }
                                              },
                                              onTap: () {
                                                // no-op
                                              },
                                            ),
                                          );
                                        });
                                  } else {
                                    return const SizedBox();
                                  }
                                }),
                          ],
                        ),
                      ),
                      Container(
                        margin: EdgeInsetsDirectional.only(start: 10.h),
                        padding: EdgeInsetsDirectional.fromSTEB(
                            10.h, 8.h, 0.h, 10.h),
                        child: InkWell(
                          onTap: () {
                            router.pop();
                          },
                          child: ImageView(
                            image: AppImages.icDrawerClose,
                            imageType: ImageType.svg,
                            width: 16.h,
                            height: 16.h,
                          ),
                        ),
                      )
                    ],
                  ),
                ));
          } else {
            return const SizedBox();
          }
        });
  }

  Widget buildOptionsView() {
    return StreamBuilder<MobileLicenseMenuResponse?>(
        stream: appBloc.mobileMenu,
        builder: (context, snapshot) {
          return Expanded(
            child: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.max,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: getBloc.isUserTeacher == true
                    ? drawerTeacherOptionsWidgets()
                    : drawerStudentsOptionsWidgets(),
              ),
            ),
          );
        });
  }

  Widget drawerTileWidget(String label, String iconPath, Function() onTileTap) {
    return InkWell(
      onTap: onTileTap,
      child: Container(
        width: double.infinity,
        padding: EdgeInsetsDirectional.only(
            top: 14.h, end: 24.h, start: 24.h, bottom: 14.h),
        child: Row(
          children: [
            SvgPicture.asset(
              iconPath,
              width: 20.h,
              height: 20.h,
            ),
            SizedBox(
              width: 24.h,
            ),
            Flexible(
              child: Text(
                label,
                style: styleMediumRegular,
              ),
            ),
          ],
        ),
      ),
    );
  }

  List<Widget> drawerStudentsOptionsWidgets() {
    return [
      SizedBox(height: 12.h),
      menuUtils.isAnnouncementsMenu()
          ? drawerTileWidget(string("announcements.label_announcements"),
              AppImages.icOpAnnouncement, () {
              /*Navigator.pop(context);
        Navigator.of(context).push(AnnouncementsScreen.route());*/
            })
          : const SizedBox(),
      /*menuUtils.isCalenderMenu() ? drawerTileWidget(string("common_labels.label_calendar"), AppImages.icOpCalendar, () {
        Navigator.pop(context);
        Navigator.of(context).pushAndRemoveUntil(
          HomeScreen.route(),
          (route) => false,
        );
      }) : const SizedBox(),*/
      menuUtils.isTimeTableMenu()
          ? drawerTileWidget(string("timetable.title_time_table_text"),
              AppImages.icOpTimetable, () {
              /*Navigator.pop(context);
        Navigator.of(context).push(TimeTableScreen.route(true));*/
            })
          : const SizedBox(),
      menuUtils.isAssessmentMenu()
          ? drawerTileWidget(
              string(
                  "assessment_and_assignment.title_assessments_and_assignments"),
              AppImages.icOpAssessments, () {
              /*Navigator.pop(context);
        Navigator.of(context).push(AssessmentAndAssignmentScreen.route());*/
            })
          : const SizedBox(),
      menuUtils.isAttendanceMenu()
          ? drawerTileWidget(
              string("attendance.title_attendance"), AppImages.icOpAttendance,
              () {
              /*Navigator.pop(context);
        Navigator.of(context).push(AttendanceScreen.route());*/
            })
          : const SizedBox(),
      menuUtils.isHomeWorkMenu()
          ? drawerTileWidget(
              string("homework.title_homework"), AppImages.icOpHomework, () {
              /*Navigator.pop(context);
        Navigator.of(context).push(HomeworkScreen.route());*/
            })
          : const SizedBox(),
      menuUtils.isPaymentBarcodeMenu()
          ? drawerTileWidget(string('payments_barcode.label_payments_barcode'),
              AppImages.icBarcode, () {
              /*Navigator.pop(context);
        Navigator.push(context, PaymentsBarcodeScreen.route());*/
            })
          : const SizedBox(),
      drawerTileWidget(
          string("settings_screen.label_settings"), AppImages.icOpSetting, () {
        widget.closeDrawerFunc();
        router.pushNamed(AppRouter.settingsRoute);
      }),
      drawerTileWidget(
          string("about_us.label_about_app"), AppImages.icOpAboutUs, () {
        /*Navigator.pop(context);
        Navigator.push(context, AboutUsScreen.route(true));*/
      }),
      /*drawerTileWidget(string('help_resource.title_help_resource'), AppImages.icOpHelpResources, () {
        Navigator.pop(context);
        Navigator.push(context, HelpAndResourceScreen.route());
      }),*/
    ];
  }

  List<Widget> drawerTeacherOptionsWidgets() {
    return [
      SizedBox(height: 12.h),
      menuUtils.isAnnouncementsMenu()
          ? drawerTileWidget(string("announcements.label_announcements"),
              AppImages.icOpAnnouncement, () {
              /*Navigator.pop(context);
        Navigator.of(context).push(AnnouncementsScreen.route());*/
            })
          : const SizedBox(),
      menuUtils.isTimeTableMenu()
          ? drawerTileWidget(string("timetable.title_time_table_text"),
              AppImages.icOpTimetable, () {
              // Navigator.pop(context);
              // Navigator.of(context).push(TimeTableScreen.route(true));
            })
          : const SizedBox(),
      buildTeacherAttendance(),
      menuUtils.isTeacherHomeWorkMenu()
          ? drawerTileWidget(
              string("teacher_classwork.title"), AppImages.icOpHomework, () {
              // Navigator.pop(context);
              // Navigator.of(context).push(TeacherClassworkScreen.route());
            })
          : const SizedBox(),
      menuUtils.isPaymentBarcodeMenu()
          ? drawerTileWidget(string('payments_barcode.label_payments_barcode'),
              AppImages.icBarcode, () {
              // Navigator.pop(context);
              // Navigator.push(context, PaymentsBarcodeScreen.route());
            })
          : const SizedBox(),
      drawerTileWidget(
          string("settings_screen.label_settings"), AppImages.icOpSetting, () {
        // Navigator.pop(context);
        // Navigator.of(context).push(SettingScreen.route());
      }),
      drawerTileWidget(
          string("about_us.label_about_app"), AppImages.icOpAboutUs, () {
        // Navigator.pop(context);
        // Navigator.push(context, AboutUsScreen.route(true));
      }),
      /*drawerTileWidget(string('help_resource.title_help_resource'), AppImages.icOpHelpResources, () {
            Navigator.pop(context);
            Navigator.push(context, HelpAndResourceScreen.route());
      }),*/
    ];
  }

  Widget buildTeacherAttendance() {
    if (menuUtils.isTeacherAttendanceMenu() &&
        menuUtils.isTeacherServiceAttendanceMenu()) {
      return drawerTileWidget(
          string("attendance.title_attendance"), AppImages.icOpAttendance, () {
        // Navigator.pop(context);
        // Navigator.of(context).push(TeachersAttendanceScreen.route(menuUtils.isTeacherAttendanceMenu(), menuUtils.isTeacherServiceAttendanceMenu()));
      });
    } else if (menuUtils.isTeacherAttendanceMenu()) {
      return drawerTileWidget(
          string('teacher_attendance.label_courses_attendance',
              {"subject": subjectLiteral()}),
          AppImages.icOpAttendance, () {
        // Navigator.pop(context);
        // Navigator.of(context).push(TeachersCoursesAttendanceScreen.route());
      });
    }
    if (menuUtils.isTeacherServiceAttendanceMenu()) {
      return drawerTileWidget(
          string("teacher_attendance.label_services_attendance"),
          AppImages.icOpAttendance, () {
        // Navigator.pop(context);
        // Navigator.of(context).push(TeacherServicesAttendanceScreen.route());
      });
    } else {
      return const SizedBox();
    }
  }

  void logout() {
    showLoader();
    doLogout();
    /*apiNotificationUnRegister((response){
      getBloc().hideLoadingDialog();
      doLogout();
    },(error){
      getBloc().hideLoadingDialog();
      doLogout();
    });*/
  }

  @override
  AppDrawerBloc get getBloc => _bloc;
}
