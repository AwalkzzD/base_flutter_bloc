import 'dart:developer';

import 'package:base_flutter_bloc/base/routes/router/app_router.dart';
import 'package:base_flutter_bloc/base/routes/router_utils/custom_route_arguments.dart';
import 'package:base_flutter_bloc/base/src_bloc.dart';
import 'package:base_flutter_bloc/bloc/profile/profile_bloc.dart';
import 'package:base_flutter_bloc/remote/repository/profile/response/user_profile_response.dart';
import 'package:base_flutter_bloc/utils/screen_utils/flutter_screen_util.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';

import '../../bloc/profile/profile_bloc_event.dart';
import '../../utils/appbar/back_button_appbar.dart';
import '../../utils/appbar/common_profile_view.dart';
import '../../utils/appbar/trailing_buttons/barcode_appbar_button.dart';
import '../../utils/common_utils/common_utils.dart';
import '../../utils/constants/app_images.dart';
import '../../utils/constants/app_styles.dart';
import '../../utils/constants/app_theme.dart';
import '../../utils/custom_switch/common_switch.dart';
import '../../utils/dropdown/custom_dropdown.dart';
import '../../utils/dropdown/dropdown_option_model.dart';
import '../../utils/widgets/header_widgets/custom_header_trailing_widget.dart';
import '../../utils/widgets/header_widgets/custom_header_widget.dart';
import '../../utils/widgets/header_widgets/header_with_child.dart';
import '../../utils/widgets/image_view.dart';
import '../../utils/widgets/strings_utils.dart';
import '../../utils/widgets/terminologies_utils.dart';

class ProfileScreen extends BasePage {
  const ProfileScreen({super.key});

  @override
  BasePageState<BasePage, BaseBloc<BaseEvent, BaseState>> get getState =>
      _ProfileScreenState();
}

class _ProfileScreenState extends BasePageState<ProfileScreen, ProfileBloc> {
  final ProfileBloc _bloc = ProfileBloc();

  final String placeHolderText = "--";

  TextEditingController studentCodeController = TextEditingController();

  List<String> hobbies = ["Sport", "Exercises"];

  @override
  void onReady() {
    getBloc.add(LoadUserProfilePrefEvent());
    super.onReady();
  }

  @override
  Widget? get customAppBar => AppBarBackButton.build(
        onBackPressed: () => router.pop(),
        title: string("profile.title_my_profile"),
        trailing: [
          const BarcodeAppBarButton(),
        ],
      );

  @override
  Widget buildWidget(BuildContext context) {
    return customBlocConsumer(
      bloc: getBloc,
      onDataReturn: (state) {
        switch (state.data) {
          case UserProfileResponse userProfileResponse:
            return SingleChildScrollView(
                child: Column(
              children: [
                SizedBox(height: 12.h),
                buildProfileHeader(userProfileResponse),
                buildBasicData(userProfileResponse),
                buildSecurityPreference(userProfileResponse),
                buildHideBirthDaySwitch(userProfileResponse),
                buildContactInfo(userProfileResponse),
                SizedBox(height: 24.h),
              ],
            ));
          default:
            return Container(color: Colors.brown);
        }
      },
      onDataPerform: (state) {
        switch (state.data) {
          case UserProfileResponse userProfileResponse:
            if (userProfileResponse.hideBirthday != null) {
              if (!getBloc.isHideMyBirthdayOn.isClosed) {
                getBloc.isHideMyBirthdayOn
                    .add(userProfileResponse.hideBirthday ?? false);
              }
            }
          default:
            log('default');
        }
      },
    );
  }

  @override
  ProfileBloc get getBloc => _bloc;

  Widget buildProfileHeader(UserProfileResponse? profile) {
    return Container(
      padding: EdgeInsetsDirectional.fromSTEB(24.h, 24.h, 24.h, 0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          IntrinsicHeight(
            child: Row(
              children: <Widget>[
                Align(
                  alignment: Alignment.topRight,
                  child: CommonProfileView(
                      image: profile?.image ?? "",
                      size: 80.h,
                      boxFit: BoxFit.cover,
                      borderColor: themeOf().appBarTextColor,
                      text: getFullName(profile?.givenName, profile?.surname)),
                ),
                Expanded(
                  child: Container(
                    alignment: Alignment.topLeft,
                    padding: EdgeInsetsDirectional.symmetric(horizontal: 15.h),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("${string("common_labels.label_hello")},",
                            style: styleMedium3Bold.copyWith(
                                color: themeOf().accentColor)),
                        Text(getFullName(profile?.givenName, profile?.surname),
                            style: styleMedium3Bold.copyWith(
                                color: themeOf().accentColor)),
                        SizedBox(height: 8.w),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget buildBasicData(UserProfileResponse? profile) {
    return Padding(
      padding: EdgeInsetsDirectional.all(24.h),
      child: Column(
        mainAxisSize: MainAxisSize.max,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CustomerHeader(
            string("profile.label_basic_data"),
            customTextStyle: styleMedium1SemiBold.copyWith(
                color: themeOf().textPrimaryHeader),
          ),
          SizedBox(height: 12.h),
          Container(
            padding: EdgeInsetsDirectional.all(20.h),
            decoration: BoxDecoration(
              color: themeOf().cardBgColor,
              borderRadius: const BorderRadius.only(
                  bottomLeft: Radius.circular(20),
                  bottomRight: Radius.circular(20)),
              boxShadow: [
                BoxShadow(
                  color: themeOf().dropShadowColor,
                  spreadRadius: 2,
                  blurRadius: 20,
                  offset: const Offset(5, 5),
                ),
              ],
            ),
            child: Column(
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Expanded(
                          child: buildEntryFields(
                              true,
                              string("profile.label_first_name"),
                              profile?.givenName ?? placeHolderText),
                        ),
                        SizedBox(width: 12.w),
                        Expanded(
                          child: buildEntryFields(
                              true,
                              string("profile.label_last_name"),
                              profile?.surname ?? placeHolderText),
                        ),
                      ],
                    ),
                    SizedBox(height: 12.h),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          child: buildEntryFields(
                              true,
                              string("profile.label_user_name"),
                              profile?.userName ?? placeHolderText),
                        ),
                        SizedBox(width: 12.w),
                        Expanded(
                          child: buildEntryFields(
                              true,
                              string("profile.label_internal_system_code"),
                              profile?.entity?.id?.toString() ??
                                  placeHolderText),
                        ),
                      ],
                    ),
                  ],
                ),
                SizedBox(height: 12.h),
                buildEntryFields(
                    true,
                    string("profile.label_external_provider_email"),
                    profile?.email ?? placeHolderText),
                SizedBox(height: 12.h),
                StreamBuilder<List<DropDownOptionModel>>(
                    stream: getBloc.languages,
                    builder: (context, snapshot) {
                      if (snapshot.hasData &&
                          snapshot.data?.isNotEmpty == true) {
                        return buildDropDown(
                            string("profile.label_preferred_language"),
                            string("profile.label_please_select"),
                            getBloc.findSelectedLanguage(
                                profile?.languagePreference),
                            snapshot.data ?? [], (value) {
                          getBloc.selectedLanguage = value;
                          /*updateProfileLanguage(
                              getBloc().selectedLanguage?.key);*/
                        });
                      } else {
                        return const SizedBox();
                      }
                    }),
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget buildEntryFields(bool isDisable, String title, String? value) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        HeaderWithChild(
          title,
          buildEntryField(value),
          heightSpace: 8.h,
          customTextStyle: styleSmall3SemiBold.copyWith(
              color: isDisable
                  ? themeOf().textPrimaryColor
                  : themeOf().textPrimaryHeader),
        ),
        Divider(color: themeOf().textFieldBorderColor)
      ],
    );
  }

  Widget buildEntryField(String? text) {
    return Text(
      text ?? placeHolderText,
      textAlign: TextAlign.start,
      style: styleSmall.copyWith(color: themeOf().disableTextColor),
    );
  }

  Widget buildDropDown<T>(String title, String hint, T? initialValue,
      List<T> items, Function(T?) onClick) {
    return HeaderWithChild(
      title,
      CustomDropdown(
          hint: hint,
          items: items,
          initialValue: initialValue,
          isExpanded: true,
          isDense: true,
          menuItemStyleData: MenuItemStyleData(
            padding: EdgeInsetsDirectional.only(start: 8.h, end: 8.h),
          ),
          dropdownStyleData: DropdownStyleData(
            padding: const EdgeInsetsDirectional.all(0),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
            ),
          ),
          buttonStyleData: ButtonStyleData(
            height: isTablet() ? 38.h : 35.h,
            padding: EdgeInsetsDirectional.only(
                start: 0, end: 12.h, top: 0, bottom: 4.h),
            decoration: BoxDecoration(
              border: Border(
                bottom: BorderSide(color: themeOf().dropdownBorderColor),
              ),
            ),
          ),
          showUnderline: true,
          textStyle: styleSmall3.copyWith(
            color: themeOf().textPrimaryColor,
          ),
          dropDownTextStyle: styleSmall3.copyWith(
            color: themeOf().textPrimaryColor,
          ),
          onClick: onClick),
      heightSpace: 0,
      customTextStyle:
          styleSmall3SemiBold.copyWith(color: themeOf().textPrimaryHeader),
    );
  }

  Widget buildSecurityPreference(UserProfileResponse? profile) {
    return Padding(
      padding: EdgeInsetsDirectional.fromSTEB(24.h, 0, 24.h, 24.h),
      child: Column(
        mainAxisSize: MainAxisSize.max,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CustomerHeader(
            string("profile.label_security_preferences"),
            customTextStyle: styleMedium1SemiBold.copyWith(
                color: themeOf().textPrimaryHeader),
          ),
          SizedBox(height: 12.h),
          Container(
            padding: EdgeInsetsDirectional.all(20.h),
            decoration: BoxDecoration(
              color: themeOf().cardBgColor,
              borderRadius: const BorderRadius.only(
                  bottomLeft: Radius.circular(20),
                  bottomRight: Radius.circular(20)),
              boxShadow: [
                BoxShadow(
                  color: themeOf().dropShadowColor,
                  spreadRadius: 2,
                  blurRadius: 20,
                  offset: const Offset(5, 5),
                ),
              ],
            ),
            child: Column(
              mainAxisSize: MainAxisSize.max,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                InkWell(
                    onTap: () {
                      showEditEmailForPasswordRecoveryDialog(
                          profile?.contact?.email ?? "");
                    },
                    child: buildEntryFields(
                        false,
                        string("profile.label_email_for_password_recovery"),
                        profile?.contact?.email ?? placeHolderText)),
                SizedBox(height: 12.h),
                StreamBuilder<List<DropDownOptionModel>>(
                    stream: getBloc.securityMethodsStream,
                    builder: (context, snapshot) {
                      if (snapshot.hasData &&
                          snapshot.data?.isNotEmpty == true) {
                        return buildDropDown(
                            string("profile.label_preferred_contact_method"),
                            string("profile.label_please_select"),
                            getBloc.findSelectedSecurityMethod(
                                profile?.contactMethodPreference),
                            snapshot.data ?? [], (value) {
                          getBloc.selectedSecurityMethod = value;
                          /*updateProfileContactMethod(
                              getBloc().selectedSecurityMethod?.value ?? "");*/
                        });
                      } else {
                        return const SizedBox();
                      }
                    }),
              ],
            ),
          )
        ],
      ),
    );
  }

  void showEditEmailForPasswordRecoveryDialog(String email) {}

  Widget buildHideBirthDaySwitch(UserProfileResponse? profile) {
    return CommonSwitch.build(
      title: string("profile.label_hide_my_birthday"),
      switchStream: getBloc.isHideMyBirthdayOn.stream,
      onValueChanged: (val) {
        /*updateProfileHideBirthDay(val);*/
      },
    );
  }

  Widget buildContactInfo(UserProfileResponse? profile) {
    return Padding(
      padding: EdgeInsetsDirectional.all(24.h),
      child: Column(
        mainAxisSize: MainAxisSize.max,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CustomHeaderWithTrailing(
            contactDetailsLiteral(),
            customTextStyle: styleMedium1SemiBold.copyWith(
                color: themeOf().textPrimaryHeader),
            trailingIcon: InkWell(
              onTap: () async {
                final result = await router.pushNamed(
                    AppRouter.contactInfoRoute,
                    arguments: CustomRouteArguments(profile: profile));
                if (result != null) {
                  refreshProfile();
                }
              },
              child: ImageView(
                image: AppImages.icEditIcon,
                imageType: ImageType.svg,
                width: 18.h,
                height: 18.h,
                color: themeOf().lightMode() ? null : themeOf().textColor1,
              ),
            ),
          ),
          SizedBox(
            height: 12.h,
          ),
          Container(
            padding: EdgeInsetsDirectional.all(20.h),
            decoration: BoxDecoration(
              color: themeOf().cardBgColor,
              borderRadius: const BorderRadius.only(
                  bottomLeft: Radius.circular(20),
                  bottomRight: Radius.circular(20)),
              boxShadow: [
                BoxShadow(
                  color: themeOf().dropShadowColor,
                  spreadRadius: 2,
                  blurRadius: 20,
                  offset: const Offset(5, 5),
                ),
              ],
            ),
            child: Column(
              mainAxisSize: MainAxisSize.max,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                buildEntryFields(true, string("profile.label_address"),
                    profile?.contact?.address ?? placeHolderText),
                SizedBox(height: 12.h),
                buildEntryFields(true, string("profile.label_city"),
                    profile?.contact?.city ?? placeHolderText),
                SizedBox(height: 12.h),
                buildEntryFields(true, string("profile.label_post_code"),
                    profile?.contact?.postCode ?? placeHolderText),
                SizedBox(height: 12.h),
                buildEntryFields(true, string("profile.label_area_state"),
                    profile?.contact?.area ?? placeHolderText),
                SizedBox(height: 12.h),
                buildEntryFields(true, string("profile.label_mobile_phone"),
                    profile?.contact?.mobilePhone ?? placeHolderText),
                SizedBox(height: 12.h),
                buildEntryFields(true, string("profile.label_home_phone"),
                    profile?.contact?.homePhone ?? placeHolderText),
                SizedBox(height: 12.h),
                buildEntryFields(true, string("profile.label_contact_email"),
                    profile?.contact?.email ?? placeHolderText),
              ],
            ),
          )
        ],
      ),
    );
  }

  void refreshProfile() {
    getBloc.add(LoadUserProfileEvent(isRefresh: true));
  }
}
