import 'package:base_flutter_bloc/base/src_bloc.dart';
import 'package:base_flutter_bloc/bloc/contact_us/contact_us_bloc.dart';
import 'package:base_flutter_bloc/utils/screen_utils/flutter_screen_util.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../remote/utils/api_endpoints.dart';
import '../../utils/appbar/back_button_appbar.dart';
import '../../utils/common_utils/common_utils.dart';
import '../../utils/constants/app_images.dart';
import '../../utils/constants/app_styles.dart';
import '../../utils/constants/app_theme.dart';
import '../../utils/widgets/divider_widget.dart';
import '../../utils/widgets/image_view.dart';

class ContactUsScreen extends BasePage {
  const ContactUsScreen({super.key});

  @override
  BasePageState<BasePage, BaseBloc<BaseEvent, BaseState>> get getState =>
      _ContactUsScreenState();
}

class _ContactUsScreenState
    extends BasePageState<ContactUsScreen, ContactUsBloc> {
  final ContactUsBloc _bloc = ContactUsBloc();

  @override
  Widget? get customAppBar => AppBarBackButton.build(
      onBackPressed: () => router.pop(),
      title: string('settings_screen.label_contact_us'));

  @override
  Widget buildWidget(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 23.h, horizontal: 21.h),
      child: Column(
        children: [
          buildContactUsTile(AppImages.icCall, ApiEndpoints.infoContactPhone,
              () {
            _launchPhone(ApiEndpoints.infoContactPhone.replaceAll(" ", ""));
          }),
          SizedBox(height: 12.h),
          buildContactUsTile(AppImages.icMail, ApiEndpoints.infoContactEmail,
              () {
            _launchEmail(ApiEndpoints.infoContactEmail);
          }),
          SizedBox(height: 30.h),
          DividerWidget(verticalMargin: 12.h, color: themeOf().dividerColor),
          SizedBox(height: 30.h),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              buildSocialIcons(AppImages.icFacebook, () {
                tryOpenFacebook();
              }),
              SizedBox(width: 20.h),
              buildSocialIcons(AppImages.icYoutube, () {
                tryOpenYoutube();
              }),
              SizedBox(width: 20.h),
              buildSocialIcons(AppImages.icLinkedIn, () {
                tryOpenLinkedIn();
              }),
              SizedBox(width: 20.h),
              buildSocialIcons(AppImages.icTwitter, () {
                tryOpenTwitter();
              })
            ],
          )
        ],
      ),
    );
  }

  Widget buildContactUsTile(
      String tileIcon, String tileTittle, VoidCallback onClick) {
    return InkWell(
      onTap: onClick,
      child: Container(
        padding: EdgeInsets.fromLTRB(13.h, 12.h, 20.h, 12.h),
        decoration: BoxDecoration(
            color: themeOf().cardBgColor,
            border: Border.all(color: themeOf().cardBorderColor),
            borderRadius: BorderRadius.circular(10)),
        child: Row(
          children: [
            Expanded(
              child: Text(
                tileTittle,
                style: styleSmall3SemiBold.copyWith(
                    color: themeOf().textPrimaryColor),
              ),
            ),
            ImageView(
                height: 16.h,
                width: 16.h,
                image: tileIcon,
                color: themeOf().iconColor,
                imageType: ImageType.svg),
          ],
        ),
      ),
    );
  }

  Widget buildSocialIcons(String socialIcon, VoidCallback onClick) {
    return InkWell(
        onTap: onClick,
        child: ImageView(
            height: 42.h,
            width: 42.h,
            image: socialIcon,
            imageType: ImageType.svg));
  }

  void _launchPhone(String phoneNumber) async {
    final Uri url = Uri.parse('tel:$phoneNumber');
    if (await canLaunchUrl(url)) {
      await launchUrl(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  void _launchEmail(String email) async {
    final Uri emailLaunchUri = Uri(
      scheme: 'mailto',
      path: email,
    );

    if (await canLaunchUrl(emailLaunchUri)) {
      await launchUrl(emailLaunchUri);
    } else {
      throw 'Could not launch $emailLaunchUri';
    }
  }

  Future<void> tryOpenFacebook() async {
    final fbAppExists = await canLaunchUrl(Uri.parse('fb://'));
    if (fbAppExists) {
      await launchUrl(Uri.parse(ApiEndpoints.infoFbPageApp));
    } else {
      await launchUrl(Uri.parse(ApiEndpoints.infoFbPageWeb));
    }
  }

  Future<void> tryOpenTwitter() async {
    final twitterAppExists = await canLaunchUrl(Uri.parse('twitter://'));
    if (twitterAppExists) {
      await launchUrl(Uri.parse(ApiEndpoints.infoTwitterApp));
    } else {
      await launchUrl(Uri.parse(ApiEndpoints.infoTwitterWeb));
    }
  }

  Future<void> tryOpenYoutube() async {
    await launchUrl(Uri.parse(ApiEndpoints.infoYoutubeWeb));
  }

  Future<void> tryOpenLinkedIn() async {
    await launchUrl(Uri.parse(ApiEndpoints.infoLinkedInWeb));
  }

  @override
  ContactUsBloc get getBloc => _bloc;
}
