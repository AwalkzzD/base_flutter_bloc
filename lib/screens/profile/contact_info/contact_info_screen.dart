import 'package:base_flutter_bloc/base/src_bloc.dart';
import 'package:base_flutter_bloc/bloc/contact_info/contact_info_bloc.dart';
import 'package:base_flutter_bloc/bloc/contact_info/contact_info_bloc_event.dart';
import 'package:base_flutter_bloc/utils/screen_utils/flutter_screen_util.dart';
import 'package:flutter/material.dart';

import '../../../remote/repository/profile/request/update_contact_request_params.dart';
import '../../../remote/repository/profile/response/user_profile_response.dart';
import '../../../utils/appbar/back_button_appbar.dart';
import '../../../utils/common_utils/common_utils.dart';
import '../../../utils/constants/app_colors.dart';
import '../../../utils/constants/app_images.dart';
import '../../../utils/constants/app_styles.dart';
import '../../../utils/constants/app_theme.dart';
import '../../../utils/widgets/checkbox_widget/custom_image_check_box.dart';
import '../../../utils/widgets/common_widgets.dart';
import '../../../utils/widgets/divider_widget.dart';
import '../../../utils/widgets/header_widgets/header_with_child.dart';
import '../../../utils/widgets/image_view.dart';
import '../../../utils/widgets/terminologies_utils.dart';

class ContactInfoScreen extends BasePage {
  const ContactInfoScreen({super.key, this.profile});

  final UserProfileResponse? profile;

  @override
  BasePageState<BasePage, BaseBloc<BaseEvent, BaseState>> get getState =>
      _ContactInfoScreenState();
}

class _ContactInfoScreenState
    extends BasePageState<ContactInfoScreen, ContactInfoBloc> {
  final ContactInfoBloc _bloc = ContactInfoBloc();

  bool isUpdateDataRequest = false;

  TextEditingController addressController = TextEditingController();
  FocusNode addressFocusNode = FocusNode();

  TextEditingController cityController = TextEditingController();
  FocusNode cityFocusNode = FocusNode();

  TextEditingController postCodeController = TextEditingController();
  FocusNode postCodeFocusNode = FocusNode();

  TextEditingController areaStateController = TextEditingController();
  FocusNode areaStateFocusNode = FocusNode();

  TextEditingController mobileNumberController = TextEditingController();
  FocusNode mobileNumberFocusNode = FocusNode();

  TextEditingController homeNumberController = TextEditingController();
  FocusNode homeNumberFocusNode = FocusNode();

  TextEditingController emailController = TextEditingController();
  FocusNode emailFocusNode = FocusNode();

  TextEditingController taxIdController = TextEditingController();
  FocusNode taxIdFocusNode = FocusNode();

  TextEditingController studentCodeController = TextEditingController();
  FocusNode studentCodeFocusNode = FocusNode();

  final GlobalKey<FormState> _formKey = GlobalKey();

  @override
  void onReady() {
    super.onReady();
    addressController.text = widget.profile?.contact?.address ?? "";
    cityController.text = widget.profile?.contact?.city ?? "";
    postCodeController.text = widget.profile?.contact?.postCode ?? "";
    areaStateController.text = widget.profile?.contact?.area ?? "";
    mobileNumberController.text = widget.profile?.contact?.mobilePhone ?? "";
    homeNumberController.text = widget.profile?.contact?.homePhone ?? "";
    emailController.text = widget.profile?.contact?.email ?? "";
    taxIdController.text = widget.profile?.contact?.taxId ?? "";
    studentCodeController.text = widget.profile?.entity?.id.toString() ?? "";
  }

  @override
  Widget? get customAppBar => AppBarBackButton.build(
      onBackPressed: () => router.pop(), title: contactDetailsLiteral());

  @override
  Widget buildWidget(BuildContext context) {
    /*return BlocConsumer(
      bloc: getBloc,
      builder: (context, state) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Flexible(child: SingleChildScrollView(child: contactInfoWidgets())),
          ],
        );
      },
      listener: (context, state) {
        if (state is String) {
          router.pop("true");
        }
      },
    );*/
    return customBlocConsumer(
      onInitialReturn: (state) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Flexible(child: SingleChildScrollView(child: contactInfoWidgets())),
          ],
        );
      },
      onDataReturn: (state) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Flexible(child: SingleChildScrollView(child: contactInfoWidgets())),
          ],
        );
      },
      onDataPerform: (state) {
        switch (state.data) {
          case String response:
            router.pop("true");
        }
      },
    );
  }

  Widget contactInfoWidgets() {
    return Form(
      key: _formKey,
      child: Column(
        mainAxisSize: MainAxisSize.max,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: 12.h,
          ),
          buildEntryFields(
              string("profile.label_address"),
              string("common_labels.hint_type_here"),
              TextInputAction.next,
              addressController,
              addressFocusNode),
          buildEntryFields(
              string("profile.label_city"),
              string("common_labels.hint_type_here"),
              TextInputAction.next,
              cityController,
              cityFocusNode),
          buildEntryFields(
              string("profile.label_post_code"),
              string("common_labels.hint_type_here"),
              TextInputAction.next,
              postCodeController,
              postCodeFocusNode),
          buildEntryFields(
              string("profile.label_area_state"),
              string("common_labels.hint_type_here"),
              TextInputAction.next,
              areaStateController,
              areaStateFocusNode),
          buildEntryFields(
              string("profile.label_mobile_phone"),
              string("common_labels.hint_type_here"),
              TextInputAction.next,
              mobileNumberController,
              mobileNumberFocusNode),
          buildEntryFields(
              string("profile.label_home_phone"),
              string("common_labels.hint_type_here"),
              TextInputAction.next,
              homeNumberController,
              homeNumberFocusNode),
          buildEntryFields(
              string("profile.label_contact_email"),
              string("common_labels.hint_type_here"),
              TextInputAction.next,
              emailController,
              emailFocusNode),
          buildEntryFields(
              string("profile.label_tax_id"),
              string("common_labels.hint_type_here"),
              TextInputAction.done,
              taxIdController,
              taxIdFocusNode),
          buildLabelFields(
              string(
                  "profile.label_student_code", {"student": studentLiteral()}),
              widget.profile?.entity?.id.toString()),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 24.h),
            child: DividerWidget(
              verticalMargin: 0,
              color: themeOf().dividerColor,
            ),
          ),
          updateConformationWidget(),
          getButtons(),
          SizedBox(
            height: 24.h,
          ),
        ],
      ),
    );
  }

  @override
  ContactInfoBloc get getBloc => _bloc;

  Widget buildEntryFields(String title, String hint, TextInputAction action,
      TextEditingController controller, FocusNode focusNode) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 24.h, vertical: 12.h),
      child: HeaderWithChild(
          title, getEntryField(hint, action, controller, focusNode)),
    );
  }

  Widget buildLabelFields(String title, String? value) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 24.h, vertical: 12.h),
      child: HeaderWithChild(
        title,
        Text(
          value ?? "",
          textAlign: TextAlign.start,
          style: styleSmall.copyWith(color: themeOf().hintTextColor),
        ),
        customTextStyle:
            styleSmall4SemiBold.copyWith(color: themeOf().disableTextColor),
      ),
    );
  }

  Widget getEntryField(String hintText, TextInputAction? action,
      TextEditingController textController, FocusNode focusNode) {
    return TextFormField(
      controller: textController,
      focusNode: focusNode,
      keyboardType: TextInputType.text,
      textInputAction: action ?? TextInputAction.done,
      style: styleSmall,
      cursorColor: themeOf().textPrimaryColor,
      decoration: InputDecoration(
        isDense: true,
        enabledBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: themeOf().underlineColor)),
        focusedBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: themeOf().underlineColor)),
        border: UnderlineInputBorder(
            borderSide: BorderSide(color: themeOf().underlineColor)),
        contentPadding: EdgeInsets.fromLTRB(0, 0, 0, 8.h),
        hintText: hintText,
        hintStyle: styleSmall.copyWith(color: themeOf().textSecondaryColor),
      ),
    );
  }

  Widget updateConformationWidget() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 24.h, vertical: 12.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            string("profile.update_conformation_text"),
            textAlign: TextAlign.start,
            style: styleSmall2NormalItalic.copyWith(
                color: themeOf().disableTextColor),
          ),
          SizedBox(height: 12.h),
          CustomImageCheckbox(
            title: string("profile.label_update_data_request"),
            titleStyle: styleSmall2SemiBold.copyWith(color: gray5AColor),
            activeImage: ImageView(
              image: AppImages.icCheckBoxChecked,
              imageType: ImageType.svg,
              height: 18.h,
              width: 18.h,
            ),
            inactiveImage: ImageView(
              image: AppImages.icCheckBoxUnChecked,
              imageType: ImageType.svg,
              height: 18.h,
              width: 18.h,
              color: themeOf().disableTextColor,
            ),
            initialValue: isUpdateDataRequest,
            onChanged: (value) {
              isUpdateDataRequest = value;
            },
          )
        ],
      ),
    );
  }

  Widget getButtons() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 24.h, vertical: 12.h),
      child: Row(
        children: [
          Expanded(child: closeButton()),
          SizedBox(width: 12.w),
          Expanded(child: submitButton()),
        ],
      ),
    );
  }

  Widget submitButton() {
    return InkWell(
      onTap: onSubmit,
      child: Container(
        padding: EdgeInsets.fromLTRB(24.h, 10.h, 24.h, 10.h),
        decoration: BoxDecoration(
          gradient: getCommonGradient(),
          borderRadius: BorderRadius.circular(5),
          border: Border.all(
            color: Colors.transparent,
            width: 2.0,
          ),
        ),
        width: MediaQuery.of(context).size.width,
        child: Text(
          string("common_labels.label_save"),
          textAlign: TextAlign.center,
          style: styleMediumRegular,
        ),
      ),
    );
  }

  Widget closeButton() {
    return InkWell(
      onTap: () => router.pop(),
      child: Container(
        padding: EdgeInsets.fromLTRB(24.h, 9.h, 24.h, 9.h),
        decoration: BoxDecoration(
            border: Border.all(
              color: buttonGradientBgColor,
              width: 2.0,
            ),
            color: buttonInnerBgColor,
            borderRadius: BorderRadius.circular(5)),
        width: MediaQuery.of(context).size.width,
        child: Text(
          string("common_labels.label_close"),
          textAlign: TextAlign.center,
          style: styleMedium1Bold.copyWith(color: primaryColor),
        ),
      ),
    );
  }

  void onSubmit() {
    String address = addressController.text.trim();
    String city = cityController.text.trim();
    String postCode = postCodeController.text.trim();
    String area = areaStateController.text.trim();
    String mobileNo = mobileNumberController.text.trim();
    String homeNo = homeNumberController.text.trim();
    String email = emailController.text.trim();
    String taxId = taxIdController.text.trim();

    getBloc.add(
      LoadUpdateUserProfileContactEvent(
        data: UpdateContactResourceParameters(
          address: address,
          city: city,
          postCode: postCode,
          area: area,
          mobilePhone: mobileNo,
          homePhone: homeNo,
          email: email,
          taxId: taxId,
        ).toMap(),
      ),
    );
  }
}
