import 'package:base_flutter_bloc/base/src_bloc.dart';
import 'package:base_flutter_bloc/bloc/about_us/about_us_bloc.dart';
import 'package:base_flutter_bloc/utils/screen_utils/flutter_screen_util.dart';
import 'package:flutter/material.dart';

import '../../utils/appbar/back_button_appbar.dart';
import '../../utils/common_utils/common_utils.dart';
import '../../utils/constants/app_styles.dart';
import '../../utils/constants/app_theme.dart';
import '../../utils/widgets/custom_html_view/custom_html_view.dart';

class AboutUsScreen extends BasePage {
  final bool fromRoute;

  const AboutUsScreen({super.key, required this.fromRoute});

  @override
  BasePageState<BasePage, BaseBloc<BaseEvent, BaseState>> get getState =>
      _AboutUsScreenState();
}

class _AboutUsScreenState extends BasePageState<AboutUsScreen, AboutUsBloc> {
  final AboutUsBloc _bloc = AboutUsBloc();

  String contentAboutUs =
      "Classter.com, founded in 2015, is a global pioneer, offering a Cloud based SaaS that incorporates all-in-one: a student information (SIS), a school management (SMS) and a learning management (LMS) system. The platform offers an end-to-end cloud management solution that can be used by any educational institution, from kindergarten and primary schools to colleges and universities or even by dance and music academies. Classter invests in Adaptive Learning and A.I. technologies to support any type of academic institution and any type of academic system. &#x0a;Since 2015, the company has managed to build an extensive network of business partners and resellers in more than 10 countries in Europe, Middle East and America. Classter is currently used by over 200 educational accounts worldwide, with over 300.000 active students, teachers and parents in the platform. &#x0a;Fully integrated with Office 365, Google G-Suite, Moodle LMS and many other systems, this robust single-platform covers the entire management needs of any institution by offering a wide range of features. It provides the power to effectively manage admissions, sales, registration, timetabling, academic, learning, finance, payments, transportation and library operations with measurable results to establish strong communication and collaboration channels with teachers, students and parents, candidates and alumni. Accessible via web or mobile, Classter incorporates best practices into processes impacting school culture and mindset positively. &#x0a;Classter is a service provided by VERTITECH SA a software development company financially backed with a seed capital by Odyssey Venture Partners and Jeremie fund.";
  String contentAboutVision =
      "The strategic objective of our company is to develop vertical and industry-wide (sectoral) software, suitable for specific market segments, especially in the educational industry. Vertitech is committed to serve as an innovative solution provider for the global education market and to become one of the world's leading providers of high-quality school management systems.&#x0a;To meet our vision, it is of paramount importance for us to ensure that our software has a high perceived value and deliver superior customer experience. Our customers lie at the heart of our business strategy, and we are fully committed to promoting and maximizing their success. &#x0a;Innovation: Generate innovative and new ideas that will change the world of education. &#x0a;Commitment: Committed to delivering high-value service to our customers. &#x0a;Excellence: Evolve our products using direct customer feedback channels. &#x0a;Dependable and Reliable: Offer a complete end-to-end solution, not only software, and also provide/deliver excellent support to our clients and their customers. &#x0a;Agility: Provide our clients with the highest quality solutions at the lowest possible price. &#x0a;Community: Have a positive influence on our community, inside and outside the education club/sector. &#x0a;Empowerment: Empower and inspire our valued internal customers: our employees. &#x0a;Value: Create value for our shareholders via a rapid global expansion and successful business implementation.";

  @override
  Widget? get customAppBar => AppBarBackButton.build(
        onBackPressed: () => router.pop(),
        title: widget.fromRoute
            ? string("about_us.label_about_app")
            : string("settings_screen.label_about_us"),
      );

  @override
  Widget buildWidget(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: EdgeInsets.fromLTRB(24.h, 15.h, 21.h, 15.h),
        child: Column(
          children: [
            CustomHtmlView(contentAboutUs,
                textColor: themeOf().htmlTextColor,
                textBackgroundColor: themeOf().htmlTextBackgroundColor),
            SizedBox(
              height: 16.h,
            ),
            Center(
                child: Text(
              string("about_us.label_our_values"),
              style: fMedium1NormalTextColor.copyWith(
                  color: themeOf().textPrimaryHeader),
            )),
            SizedBox(
              height: 12.h,
            ),
            CustomHtmlView(contentAboutVision,
                textColor: themeOf().htmlTextColor,
                textBackgroundColor: themeOf().htmlTextBackgroundColor),
          ],
        ),
      ),
    );
  }

  @override
  AboutUsBloc get getBloc => _bloc;
}
