import 'package:base_flutter_bloc/base/component/base_bloc.dart';
import 'package:base_flutter_bloc/base/component/base_event.dart';
import 'package:base_flutter_bloc/base/component/base_state.dart';
import 'package:base_flutter_bloc/base/page/base_page.dart';
import 'package:base_flutter_bloc/bloc/language/language_bloc.dart';
import 'package:base_flutter_bloc/utils/constants/app_styles.dart';
import 'package:base_flutter_bloc/utils/screen_utils/flutter_screenutil.dart';
import 'package:flutter/material.dart';

import '../../../utils/appbar/backbutton_appbar.dart';
import '../../../utils/common_utils/common_utils.dart';
import '../../../utils/common_utils/shared_pref.dart';
import '../../../utils/constants/app_colors.dart';
import '../../../utils/constants/app_images.dart';
import '../../../utils/constants/app_theme.dart';
import '../../../utils/localization/language_model.dart';
import '../../../utils/localization/locationzation_utils.dart';
import '../../../utils/widgets/common_widgets.dart';
import '../../../utils/widgets/image_view.dart';

class LanguageScreen extends BasePage {
  const LanguageScreen({super.key});

  @override
  BasePageState<BasePage, BaseBloc<BaseEvent, BaseState>> getState() =>
      _LanguageScreenState();
}

class _LanguageScreenState extends BasePageState<LanguageScreen, LanguageBloc> {
  final LanguageBloc _bloc = LanguageBloc();

  @override
  void onReady() {
    getDefaultLanguageList().forEach((element) {
      if (getLanguage() == element.languageCode) {
        // getBloc.languageSelected.value = element;
      }
    });
  }

  @override
  Widget? get customAppBar => AppBarBackButton.build(
        onBackPressed: () {
          Navigator.pop(context);
        },
        title: string("settings_screen.label_app_language"),
      );

  @override
  Widget buildWidget(BuildContext context) {
    var a = getBloc.selectedLanguage;
    return Column(
      children: [
        Expanded(
          child: StreamBuilder<LanguageModel>(
            stream: a,
            builder: (BuildContext context, AsyncSnapshot snapshot) {
              if (snapshot.hasData) {
                List<LanguageModel> languages = getBloc().languageList;
                return ListView.builder(
                  padding: EdgeInsets.fromLTRB(0, 10.h, 0.h, 10.h),
                  itemCount: languages.length,
                  itemBuilder: (BuildContext context, int index) {
                    LanguageModel data = languages[index];
                    var isSelected = (data.languageTitle ==
                        getBloc.languageSelected.value.languageTitle);
                    return buildLanguageItem(data, isSelected, () {
                      getBloc().languageSelected.value =
                          getBloc().languageList[index];
                    });
                  },
                );
              } else {
                return const SizedBox();
              }
            },
          ),
        ),
        buildSubmitButton()
      ],
    );
  }

  @override
  LanguageBloc get getBloc => _bloc;

  /// -----------------------------------------------------------------------------------------------------------------------

  Widget buildSubmitButton() {
    return InkWell(
      onTap: () {
        /*updateProfileLanguage(
            getBloc.languageSelected.value.languageCode ?? "en-GB");*/
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
          string('label.label_submit'),
          textAlign: TextAlign.center,
          style: TextStyle(
              fontSize: 16.sp,
              fontWeight: FontWeight.w500,
              fontFamily: fontFamilyRoboto,
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
