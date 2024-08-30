import 'package:base_flutter_bloc/base/component/base_bloc.dart';
import 'package:base_flutter_bloc/base/component/base_event.dart';
import 'package:base_flutter_bloc/base/component/base_state.dart';
import 'package:base_flutter_bloc/base/page/base_page.dart';
import 'package:base_flutter_bloc/base/routes/router/app_router.dart';
import 'package:base_flutter_bloc/bloc/language/language_bloc.dart';
import 'package:base_flutter_bloc/bloc/language/language_bloc_event.dart';
import 'package:base_flutter_bloc/utils/constants/app_styles.dart';
import 'package:base_flutter_bloc/utils/screen_utils/flutter_screen_util.dart';
import 'package:flutter/material.dart';

import '../../../base/routes/router_utils/custom_route_arguments.dart';
import '../../../utils/appbar/back_button_appbar.dart';
import '../../../utils/common_utils/common_utils.dart';
import '../../../utils/common_utils/shared_pref.dart';
import '../../../utils/constants/app_colors.dart';
import '../../../utils/constants/app_images.dart';
import '../../../utils/constants/app_theme.dart';
import '../../../utils/localization/language_model.dart';
import '../../../utils/localization/localization_utils.dart';
import '../../../utils/stream_helper/common_enums.dart';
import '../../../utils/widgets/common_widgets.dart';
import '../../../utils/widgets/image_view.dart';

class LanguageScreen extends BasePage {
  const LanguageScreen({super.key});

  @override
  BasePageState<BasePage, BaseBloc<BaseEvent, BaseState>> get getState =>
      _LanguageScreenState();
}

class _LanguageScreenState extends BasePageState<LanguageScreen, LanguageBloc> {
  final LanguageBloc _bloc = LanguageBloc();

  @override
  void initState() {
    // printNavigationStack();
    getBloc.add(LoadAllLanguagesEvent());
    getDefaultLanguageList().forEach((element) {
      if (getLanguage() == element.languageCode) {
        getBloc.add(ChangeLanguageEvent(language: element));
      }
    });
    super.initState();
  }

  @override
  Widget? get customAppBar => AppBarBackButton.build(
        onBackPressed: () => router.pop(),
        title: string("settings_screen.label_app_language"),
      );

  @override
  Widget buildWidget(BuildContext context) {
    return customBlocConsumer(
      onDataReturn: (state) {
        switch (state.data) {
          case LanguageModel languageModel:
            return Column(
              children: [
                Expanded(
                  child: (getBloc.languageList != null)
                      ? ListView.builder(
                          padding: EdgeInsets.fromLTRB(0, 10.h, 0.h, 10.h),
                          itemCount: getBloc.languageList?.length,
                          itemBuilder: (BuildContext context, int index) {
                            LanguageModel data = getBloc.languageList![index];
                            var isSelected = (data.languageTitle ==
                                getBloc.selectedLanguage?.languageTitle);
                            return buildLanguageItem(data, isSelected, () {
                              setState(() {
                                getBloc.add(ChangeLanguageEvent(
                                    language: getBloc.languageList![index]));
                              });
                            });
                          },
                        )
                      : const SizedBox(),
                ),
                buildSubmitButton()
              ],
            );
        }
      },
      onDataPerform: (state) {},
    );
  }

  @override
  LanguageBloc get getBloc => _bloc;

  Widget buildSubmitButton() {
    return InkWell(
      onTap: () {
        changeLanguage(getBloc.selectedLanguage?.languageCode ?? "en-GB");
        router.pushNamedAndRemoveUntil(
            AppRouter.homeRoute,
            arguments: CustomRouteArguments(fromScreen: ScreenType.language),
            (route) => false);
      },
      child: Container(
        padding: EdgeInsetsDirectional.fromSTEB(24.h, 18.h, 24.h, 18.h),
        margin:
            EdgeInsetsDirectional.symmetric(horizontal: 24.h, vertical: 16.h),
        decoration: BoxDecoration(
            gradient: getCommonGradient(),
            borderRadius: BorderRadius.circular(5)),
        width: MediaQuery.of(context).size.width,
        child: Text(
          string('common_labels.label_submit'),
          textAlign: TextAlign.center,
          style: TextStyle(
              fontSize: 16.sp,
              fontWeight: FontWeight.w500,
              fontFamily: fontFamilyPoppins,
              color: white),
        ),
      ),
    );
  }

  Widget buildLanguageItem(
      LanguageModel data, bool isSelected, VoidCallback onClick) {
    return InkWell(
      onTap: onClick,
      child: Container(
        margin:
            EdgeInsetsDirectional.symmetric(horizontal: 24.h, vertical: 12.h),
        padding: EdgeInsetsDirectional.fromSTEB(14.h, 6.h, 10.h, 6.h),
        decoration: BoxDecoration(
            color: themeOf().cardBgColor,
            border: Border.all(color: themeOf().cardBorderColor),
            borderRadius: BorderRadius.circular(10)),
        child: Row(
          children: [
            Expanded(
              child: Text(
                data.languageTitle ?? "",
                style: styleMedium1.copyWith(color: themeOf().textPrimaryColor),
              ),
            ),
            Padding(
              padding: EdgeInsetsDirectional.fromSTEB(12.h, 12.h, 6.h, 12.h),
              child: ImageView(
                  height: 24.h,
                  width: 24.h,
                  image: isSelected
                      ? AppImages.icActiveRadioIconPng
                      : AppImages.icInActiveRadioIcon,
                  color: isSelected
                      ? null
                      : (themeOf().lightMode() ? null : themeOf().cardBgColor),
                  imageType: isSelected ? ImageType.asset : ImageType.svg),
            ),
          ],
        ),
      ),
    );
  }

  void updateProfileLanguage(String language) {
    changeLanguage(language);
    // Navigator.of(context).pushAndRemoveUntil(HomeScreen.route(screenType: ScreenType.Language), (Route<dynamic> route) => false);

    /*UpdatePreferencesResourceParameters resourceParameters = UpdatePreferencesResourceParameters(
        languagePreference: language
    );
    Map<String, dynamic> data = resourceParameters.toMap();
    getBloc().loadUpdateUserProfilePref(data, (response) {

      Navigator.of(context).pushAndRemoveUntil(HomeScreen.route(screenType: ScreenType.Language), (Route<dynamic> route) => false);
    });*/
  }
}
