import 'package:base_flutter_bloc/base/component/base_bloc.dart';
import 'package:base_flutter_bloc/base/component/base_event.dart';
import 'package:base_flutter_bloc/base/component/base_state.dart';
import 'package:base_flutter_bloc/base/page/base_page.dart';
import 'package:base_flutter_bloc/base/routes/router_utils/custom_route_arguments.dart';
import 'package:base_flutter_bloc/bloc/settings/settings_bloc.dart';
import 'package:base_flutter_bloc/bloc/settings/settings_bloc_event.dart';
import 'package:base_flutter_bloc/utils/common_utils/common_utils.dart';
import 'package:base_flutter_bloc/utils/screen_utils/flutter_screen_util.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_switch/flutter_switch.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../base/routes/router/app_router.dart';
import '../../bloc/theme/theme_bloc_event.dart';
import '../../remote/utils/api_endpoints.dart';
import '../../utils/appbar/back_button_appbar.dart';
import '../../utils/common_utils/shared_pref.dart';
import '../../utils/constants/app_images.dart';
import '../../utils/constants/app_styles.dart';
import '../../utils/constants/app_theme.dart';
import '../../utils/custom_switch/common_switch.dart';
import '../../utils/widgets/image_view.dart';

class SettingsScreen extends BasePage {
  const SettingsScreen({super.key});

  /*static Route<dynamic> route() {
    return CustomPageRoute(builder: (context) => const SettingsScreen());
  }*/

  @override
  BasePageState<BasePage, BaseBloc<BaseEvent, BaseState>> getState() =>
      _SettingsScreenState();
}

class _SettingsScreenState extends BasePageState<SettingsScreen, SettingsBloc> {
  final SettingsBloc _bloc = SettingsBloc();

  @override
  void onReady() {
    initData();
    super.onReady();
  }

  @override
  Widget? get customAppBar => AppBarBackButton.build(
      onBackPressed: () => router.pop(),
      title: string("settings_screen.label_settings"),
      trailing: []);

  @override
  Widget buildWidget(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: settingOptionList(),
        )
      ],
    );
  }

  @override
  SettingsBloc get getBloc => _bloc;

  /// ------------------------------------------------------------------------------------------------------------------------

  Widget settingOptionList() {
    return ListView(
      children: [
        SizedBox(height: 14.h),
        customBlocConsumer(
          onDataReturn: (BaseState<dynamic> state) {
            return settingSwitchTile(
                "settings_screen.label_hide_my_birthday".tr());
          },
          onDataPerform: (BaseState<dynamic> state) {
            hideLoader();
          },
        ),
        settingThemeSwitchTile(),
        settingTile(
            AppImages.icLanguage, "settings_screen.label_app_language".tr(),
            () {
          router.pushNamed(AppRouter.languageRoute);
        }),
        settingTile(AppImages.icNavigation,
            "settings_screen.label_navigation_preferences".tr(), () {
          // Navigator.push(context, NavigationPreferenceScreen.route());
        }),
        settingTile(AppImages.icAboutUs, "settings_screen.label_about_us".tr(),
            () {
          router.pushNamed(AppRouter.aboutUsRoute,
              arguments: CustomRouteArguments(fromRoute: false));
        }),
        settingTile(
            AppImages.icLicense, "settings_screen.label_license_and_terms".tr(),
            () async {
          await launchUrl(Uri.parse(ApiEndpoints.licenseAndTerms));
        }),
        settingTile(
            AppImages.icContactUs, "settings_screen.label_contact_us".tr(), () {
          router.pushNamed(AppRouter.contactUsRoute);
        }),
        /*settingTile(AppImages.icChangePassword,
            "settings_screen.label_change_password".tr(), () {}),*/
        // settingBioMetricSwitchTile(
        //     AppImages.icScreenLock,
        //     "settings_screen.label_screen_lock".tr(),
        //     "settings_screen.label_biometric_and_screen_locks".tr()),
        SizedBox(height: 14.h),
      ],
    );
  }

  settingTile(String settingIcon, String settingTittle, VoidCallback onClick) {
    return InkWell(
      onTap: onClick,
      child: Padding(
        padding: EdgeInsetsDirectional.fromSTEB(20.h, 10.h, 20.h, 10.h),
        child: Container(
          padding: EdgeInsetsDirectional.fromSTEB(14.h, 6.h, 10.h, 6.h),
          decoration: BoxDecoration(
              color: themeOf().cardBgColor,
              border: Border.all(color: themeOf().cardBorderColor),
              borderRadius: BorderRadius.circular(10)),
          child: Row(
            children: [
              Padding(
                padding: EdgeInsetsDirectional.fromSTEB(12.h, 12.h, 12.h, 12.h),
                child: ImageView(
                    height: 20.h,
                    width: 20.h,
                    image: settingIcon,
                    color: themeOf().iconColor,
                    imageType: ImageType.svg),
              ),
              Expanded(
                child: Text(
                  settingTittle,
                  style:
                      styleMedium1.copyWith(color: themeOf().textPrimaryColor),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  settingThemeSwitchTile() {
    return Padding(
      padding: EdgeInsetsDirectional.fromSTEB(20.h, 10.h, 20.h, 10.h),
      child: Container(
        padding: EdgeInsetsDirectional.fromSTEB(14.h, 4.h, 10.h, 4.h),
        decoration: BoxDecoration(
            color: themeOf().cardBgColor,
            border: Border.all(color: themeOf().cardBorderColor),
            borderRadius: BorderRadius.circular(10)),
        child: Row(
          children: [
            Expanded(
              child: Text(
                string("settings_screen.label_theme"),
                style: styleMedium1.copyWith(color: themeOf().textPrimaryColor),
              ),
            ),
            Padding(
              padding: EdgeInsetsDirectional.fromSTEB(12.h, 12.h, 12.h, 12.h),
              child: FlutterSwitch(
                width: 45.h,
                height: 25.h,
                toggleSize: 23.h,
                value: themeBloc.state.isDarkMode,
                padding: 0,
                activeColor: themeOf().activeSwitchBgColor,
                activeSwitchBorder: Border.all(
                  color: themeOf().activeSwitchBorderBgColor,
                ),
                inactiveColor: themeOf().inActiveSwitchBgColor,
                inactiveSwitchBorder: Border.all(
                  color: themeOf().inActiveSwitchBorderBgColor,
                ),
                activeIcon: const ImageView(
                    image: AppImages.icActiveIcon, imageType: ImageType.svg),
                inactiveIcon: const ImageView(
                    image: AppImages.icInActiveIcon, imageType: ImageType.svg),
                toggleColor: themeBloc.state.isDarkMode
                    ? themeOf().inActiveSwitchToggleColor
                    : themeOf().activeSwitchToggleColor,
                showOnOff: false,
                onToggle: (val) {
                  setState(() {
                    setThemeMode(isDark: val);
                    if (val) {
                      themeBloc.add(ToggleDarkThemeEvent());
                    } else {
                      themeBloc.add(ToggleLightThemeEvent());
                    }
                  });
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget settingSwitchTile(String settingTittle) {
    return CommonSwitch.build(
      title: settingTittle,
      switchStream: getBloc.isHideMyBirthdayOn.stream,
      onValueChanged: (val) {
        // updateProfileHideBirthDay(val);
      },
    );
  }

  void initData() {
    showLoader();
    getBloc.add(GetUserProfileEvent());
  }
}
