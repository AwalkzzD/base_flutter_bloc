import 'dart:io';

import 'package:base_flutter_bloc/base/routes/router_utils/custom_route_arguments.dart';
import 'package:base_flutter_bloc/base/src_bloc.dart';
import 'package:base_flutter_bloc/bloc/cards/cards_bloc.dart';
import 'package:base_flutter_bloc/bloc/cards/cards_bloc_event.dart';
import 'package:base_flutter_bloc/utils/screen_utils/flutter_screen_util.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../base/routes/router/app_router.dart';
import '../../bloc/home/home_bloc.dart';
import '../../remote/repository/cards_repository/response/card_data_response.dart';
import '../../utils/appbar/appbar_profile_view.dart';
import '../../utils/appbar/back_button_appbar.dart';
import '../../utils/appbar/common_profile_view.dart';
import '../../utils/common_utils/common_utils.dart';
import '../../utils/constants/app_colors.dart';
import '../../utils/constants/app_images.dart';
import '../../utils/constants/app_styles.dart';
import '../../utils/constants/app_theme.dart';
import '../../utils/date/date_util.dart';
import '../../utils/widgets/common_widgets.dart';
import '../../utils/widgets/custom_html_view/custom_html_view.dart';
import '../../utils/widgets/divider_widget.dart';
import '../../utils/widgets/gradient_button.dart';
import '../../utils/widgets/header_widgets/header_with_child.dart';
import '../../utils/widgets/image_view.dart';
import '../../utils/widgets/rounded_border_cached_imageview.dart';

class CardsScreen extends BasePage {
  const CardsScreen({super.key});

  @override
  BasePageState<BasePage, BaseBloc<BaseEvent, BaseState>> get getState =>
      _CardsScreenState();
}

class _CardsScreenState extends BasePageState<CardsScreen, CardsBloc> {
  final CardsBloc _bloc = CardsBloc();

  late HomeBloc homeBloc;

  @override
  void initState() {
    homeBloc = context.read<HomeBloc>();
    super.initState();
  }

  @override
  void onReady() {
    loadCardSettings();
    super.onReady();
  }

  @override
  Widget? get customAppBar => AppBarBackButton.build(
        onBackPressed: () => router.pop(),
        title: string("cards.label_cards"),
        trailing: [
          AppBarButtonProfileView(
            student: homeBloc.selectedStudent,
            studentsList: homeBloc.getStudentsListWithParent(),
            onStudentClick: (student) {
              if (student != null) {
                homeBloc.setStudent(student);
                loadCardSettings();
              }
            },
          )
        ],
      );

  @override
  Widget buildWidget(BuildContext context) {
    return customBlocConsumer(
      onDataReturn: (state) {
        switch (state.data) {
          case CardDataResponse cardDataResponse:
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                    child: SingleChildScrollView(
                        child: Column(
                  children: [
                    buildInstituteCard(cardDataResponse),
                    buildCustomText(),
                    buildCardsWidgets(cardDataResponse),
                    buildAddToWallet()
                  ],
                ))),
              ],
            );
        }
      },
      onDataPerform: (state) {},
    );
  }

  @override
  CardsBloc get getBloc => _bloc;

  void loadCardSettings() {
    getBloc.add(
        LoadCardSettingsEvent(selectedStudent: homeBloc.selectedStudent.value));
  }

  Widget buildCardsWidgets(CardDataResponse? data) {
    return Column(
      children: [
        buildStudentCard(data),
        SizedBox(height: 16.h),
        getBloc.cardQrCode != null
            ? buildQrCodeCard(
                string('cards.label_member_card'), getBloc.cardQrCode ?? "")
            : const SizedBox(),
        getBloc.benefitsCardQrCode != null
            ? buildQrCodeCard(string('cards.label_benefits_card'),
                getBloc.benefitsCardQrCode ?? "")
            : const SizedBox(),
        SizedBox(height: 16.h),
      ],
    );
  }

  Widget buildInstituteCard(CardDataResponse? data) {
    return Row(
      children: [
        Container(
          padding: EdgeInsetsDirectional.fromSTEB(20.h, 20.h, 0, 0),
          child: Align(
            alignment: Alignment.topLeft,
            child: getBloc.instituteImg != null
                ? CommonProfileView(
                    image: getBase64Image(getBloc.instituteImg),
                    text: getBloc.instituteName ?? "",
                    size: 120.h,
                    boxFit: BoxFit.contain,
                    borderColor: themeOf().appBarTextColor,
                    borderWidth: 2,
                    borderRadius: 10,
                  )
                : const SizedBox(),
          ),
        ),
        Expanded(
          child: IntrinsicHeight(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Expanded(
                  child: Container(
                    alignment: Alignment.topLeft,
                    padding: EdgeInsetsDirectional.fromSTEB(
                        getBloc.instituteImg != null ? 20.h : 0,
                        getBloc.instituteImg == null ? 20.h : 0,
                        20.h,
                        0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        /*Text(
                          data?.description ?? "",
                          textAlign: TextAlign.start,
                          style: styleMedium1Bold.copyWith(color: themeOf().textPrimaryHeader),
                        ),*/
                        getBloc.instituteName != null
                            ? Text(
                                getBloc.instituteName ?? "",
                                textAlign: TextAlign.start,
                                style: styleSmall4.copyWith(
                                    color: themeOf().textPrimaryColor),
                              )
                            : const SizedBox(),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        )
      ],
    );
  }

  Widget buildCustomText() {
    if (getBloc.customText != null && getBloc.customText?.isNotEmpty == true) {
      return Container(
        color: getBloc.customBgColor ?? Colors.transparent,
        padding: EdgeInsetsDirectional.fromSTEB(20.h, 8.h, 20.h, 0),
        child: CustomHtmlView(getBloc.customText ?? ""),
      );
    } else {
      return const SizedBox();
    }
  }

  Widget buildStudentCard(CardDataResponse? data) {
    return Padding(
      padding: EdgeInsetsDirectional.fromSTEB(24.h, 30.h, 24.h, 0),
      child: Container(
        padding: EdgeInsetsDirectional.fromSTEB(20.h, 20.h, 20.h, 20.h),
        decoration: BoxDecoration(
          border: Border.all(color: themeOf().borderColor, width: 1),
          borderRadius: BorderRadius.all(Radius.circular(10.h)),
        ),
        child: Column(
          children: [
            IntrinsicHeight(
              child: Row(
                children: <Widget>[
                  getBloc.userImg != null
                      ? Align(
                          alignment: Alignment.topRight,
                          child: CommonProfileView(
                            image: getBase64Image(getBloc.userImg),
                            text: data?.cardHolder?.name ?? "",
                            boxFit: BoxFit.cover,
                            size: 80.h,
                            borderColor: themeOf().appBarTextColor,
                          ),
                        )
                      : const SizedBox(),
                  Expanded(
                    child: Container(
                      padding: EdgeInsetsDirectional.only(
                          start: getBloc.userImg != null ? 10.h : 0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          buildUserData(
                              AppImages.icPersonal, getBloc.usersName),
                          buildUserData(AppImages.icEmail, getBloc.userEmail),
                          buildUserData(AppImages.icCall, getBloc.phones),
                          buildUserData("", getBloc.pinCode),
                          buildUserData("", getBloc.globalRegistrationNumber),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: getBloc.educationalPrograms != null ? 8.h : 16.h,
            ),
            buildUserData("", getBloc.educationalPrograms),
            SizedBox(
              height: getBloc.educationalPrograms != null ? 8.h : 0.h,
            ),
            const DividerWidget(verticalMargin: 0),
            getBloc.cardExpirationDate != null
                ? buildLabelFields(
                    string('cards.label_card_expiration'),
                    SPDateUtils.format(getBloc.cardExpirationDate,
                            SPDateUtils.FORMAT_DD_MM_YYYY) ??
                        "")
                : const SizedBox(),
            getBloc.cardCode != null
                ? buildLabelFields(
                    string('cards.label_card_number'), getBloc.cardCode ?? "")
                : const SizedBox(),
          ],
        ),
      ),
    );
  }

  Widget buildUserData(String imagePath, String? data) {
    if (data != null) {
      return Container(
        padding: EdgeInsetsDirectional.only(bottom: 6.h),
        child: Row(
          mainAxisSize: MainAxisSize.max,
          children: [
            imagePath.isNotEmpty
                ? Padding(
                    padding: EdgeInsetsDirectional.only(end: 10.h),
                    child: ImageView(
                      image: imagePath,
                      imageType: ImageType.svg,
                      width: 16.h,
                      height: 16.h,
                      color: themeOf().textPrimaryHeader,
                    ),
                  )
                : const SizedBox(),
            Flexible(
              child: Text(
                data,
                style: styleSmall3Medium.copyWith(
                    color: themeOf().textSecondaryColor),
              ),
            ),
          ],
        ),
      );
    } else {
      return const SizedBox();
    }
  }

  Widget buildQrCodeCard(String title, String value) {
    return Padding(
      padding: EdgeInsetsDirectional.fromSTEB(24.h, 13.h, 24.h, 13.h),
      child: Container(
        padding: EdgeInsetsDirectional.fromSTEB(20.h, 15.h, 20.h, 15.h),
        decoration: BoxDecoration(
          border: Border.all(color: themeOf().qrCodeBorderColor, width: 1),
          borderRadius: const BorderRadius.all(Radius.circular(10)),
        ),
        child: Row(
          children: [
            Expanded(
              child: Text(
                title,
                textAlign: TextAlign.start,
                style: styleSmall4SemiBold.copyWith(
                    color: themeOf().textPrimaryHeader),
              ),
            ),
            InkWell(
              onTap: () {
                router.pushNamed(AppRouter.qrImageRoute,
                    arguments: CustomRouteArguments(
                        qrImageScreenTitle: title, qrImageScreenValue: value));
              },
              child: RoundedBorderCachedImageView(
                imageUrl: getBase64Image(value),
                height: 60.h,
                width: 60.h,
                borderColor: themeOf().qrCodeBorderColor,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildLabelFields(String title, String value) {
    return Padding(
      padding: EdgeInsets.only(top: 16.h),
      child: HeaderWithChild(
        title,
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              value.isEmpty ? "--" : value,
              style: styleMedium1.copyWith(color: themeOf().textSecondaryColor),
            ),
            SizedBox(
              height: 8.h,
            ),
            Divider(height: 1, color: themeOf().borderColor)
          ],
        ),
      ),
    );
  }

  Widget buildAddToWallet() {
    if (getBloc.isUserTeacher == false) {
      return Container(
        margin: EdgeInsetsDirectional.only(bottom: 16.h),
        padding: EdgeInsetsDirectional.fromSTEB(24.h, 0, 24.h, 15.h),
        child: GradientButton(
          width: double.infinity,
          height: 44.h,
          gradient: getCommonGradient(),
          onPressed: () {},
          // onPressed: addCardToWallet,
          borderRadius: BorderRadius.circular(10),
          child: Text(
            Platform.isAndroid
                ? string("common_labels.label_add_to_google_wallet")
                : string("common_labels.label_add_to_apple_wallet"),
            style: styleMedium1Bold.copyWith(
              color: white,
            ),
          ),
        ),
      );
    } else {
      return const SizedBox();
    }
  }

/*void addCardToWallet() {
    getBloc.addCardToWallet((response) async {
      if (Platform.isAndroid) {
        if (response.isNotEmpty) {
          String pass = response.replaceAll('"', '');
          openUrl(pass);
        }
      }
      if (Platform.isIOS) {
        if (response.isNotEmpty) {
          String pass = response.replaceAll('"', '');
          bool isAvailable = await applePassKit.isPassLibraryAvailable();
          bool canAddPasses = await applePassKit.canAddPasses();
          if (isAvailable && canAddPasses) {
            Uint8List byte = base64Decode(pass);
            await applePassKit.addPass(byte);
          }
        }
      }
    });
  }*/
}
