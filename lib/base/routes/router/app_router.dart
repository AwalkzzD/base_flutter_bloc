import 'package:base_flutter_bloc/base/routes/router_utils/custom_route_arguments.dart';
import 'package:base_flutter_bloc/screens/about_us/about_us_screen.dart';
import 'package:base_flutter_bloc/screens/announcements/announcements_screen.dart';
import 'package:base_flutter_bloc/screens/cards/cards_screen.dart';
import 'package:base_flutter_bloc/screens/contact_us/contact_us_screen.dart';
import 'package:base_flutter_bloc/screens/dashboard/dashboard_screen.dart';
import 'package:base_flutter_bloc/screens/full_image_viewer/image_full_screen.dart';
import 'package:base_flutter_bloc/screens/home/home_screen.dart';
import 'package:base_flutter_bloc/screens/learning/learning_screen.dart';
import 'package:base_flutter_bloc/screens/learning/subject/subject_screen.dart';
import 'package:base_flutter_bloc/screens/login/login_screen.dart';
import 'package:base_flutter_bloc/screens/payments_barcode/payments_barcode_screen.dart';
import 'package:base_flutter_bloc/screens/profile/contact_info/contact_info_screen.dart';
import 'package:base_flutter_bloc/screens/profile/profile_screen.dart';
import 'package:base_flutter_bloc/screens/settings/language/language_screen.dart';
import 'package:base_flutter_bloc/screens/settings/settings_screen.dart';
import 'package:base_flutter_bloc/screens/splash/splash_screen.dart';
import 'package:base_flutter_bloc/utils/widgets/custom_page_route.dart';
import 'package:flutter/material.dart';

import '../../../screens/drawer/app_drawer_widget.dart';

class AppRouter {
  AppRouter._();

  /*
   * generateRoute method generates route to the specific page.
   * It takes RouteSettings object as input parameter, and based on settings.name and generates
   * a new route to the screen.
   *
   * It can also take arguments passed in navigator object, like
   * var screenData = settings.arguments as String;
   * and pass to the screen in page route builder.
   * */
  static Route<dynamic> generateRoute(RouteSettings settings) {
    CustomRouteArguments arguments = CustomRouteArguments();
    if (settings.arguments != null) {
      arguments = settings.arguments as CustomRouteArguments;
    }
    switch (settings.name) {
      /// Home Screen Route
      case homeRoute:
        return buildRoute(screen: HomeScreen(fromScreen: arguments.fromScreen));

      /// Login Screen Route
      case loginRoute:
        return buildRoute(screen: const LoginScreen());

      /// App Drawer Route
      case appDrawerRoute:
        return buildRoute(
            screen: AppDrawerWidget(
                closeDrawerFunc: arguments.onCloseDrawer ?? () {}));

      /// Splash Screen Route
      case splashRoute:
        return buildRoute(screen: const SplashScreen());

      /// Settings Screen Route
      case settingsRoute:
        return buildRoute(screen: const SettingsScreen());

      /// Language Screen Route
      case languageRoute:
        return buildRoute(screen: const LanguageScreen());

      /// Dashboard Screen Route
      case dashboardRoute:
        return buildRoute(screen: const DashboardScreen());

      /// About Us Screen Route
      case aboutUsRoute:
        return buildRoute(
            screen: AboutUsScreen(fromRoute: arguments.fromRoute));

      /// Announcements Screen Route
      case announcementsRoute:
        return buildRoute(screen: const AnnouncementsScreen());

      /// Contact Us Screen Route
      case contactUsRoute:
        return buildRoute(screen: const ContactUsScreen());

      /// Payments Barcode Screen Route
      case paymentsBarcodeRoute:
        return buildRoute(screen: const PaymentsBarcodeScreen());

      /// Profile Screen Route
      case profileRoute:
        return buildRoute(screen: const ProfileScreen());

      /// Contact Info Screen Route
      case contactInfoRoute:
        return buildRoute(
            screen: ContactInfoScreen(profile: arguments.profile));

      /// Cards Screen Route
      case cardsRoute:
        return buildRoute(screen: const CardsScreen());

      /// Qr Image Screen Route
      case qrImageRoute:
        return buildRoute(
            screen: ImageFullScreen(
          value: arguments.qrImageScreenValue ?? '',
          title: arguments.qrImageScreenTitle ?? '',
        ));

      /// Learning Screen Route
      case learningRoute:
        return buildRoute(screen: const LearningScreen());

      /// Subject Screen Route
      case subjectRoute:
        return buildRoute(
          screen: SubjectScreen(
            studentId: arguments.studentId,
            periodId: arguments.periodId,
          ),
        );

      /// Default Route
      default:
        return buildRoute(screen: const SplashScreen());
    }
  }

  /*
  * util method to return page route
  * if isCupertino is true, it generates Cupertino Page Route, else it generates Material Page Route
  * */
  static PageRoute buildRoute({
    required Widget screen,
    RouteSettings? routeSettings,
    bool isCupertino = false,
  }) {
    return (isCupertino == true)
        ? CustomCupertinoPageRoute(
            builder: (_) => screen, settings: routeSettings)
        : CustomPageRoute(builder: (_) => screen, settings: routeSettings);
    // return ;
  }

  /*
   * errorRoute method to generate route to No Page Found Screen, when navigation error occurs.
   * errorRoute is called when an unknown route is passed to navigator object.
   * */
  static Route<dynamic> errorRoute(RouteSettings settings) {
    return CustomPageRoute(
        builder: (_) => const Scaffold(
              body: Center(
                child: Text('Page not found!'),
              ),
            ));
  }

  /// -----------------------------------------------App Routes----------------------------------------------- ///

  /*
  * Custom static route names for all pages in the app
  * */
  static const String splashRoute = '/splash';
  static const String loginRoute = '/login';
  static const String homeRoute = '/home';
  static const String appDrawerRoute = '/appDrawer';
  static const String settingsRoute = '/settings';
  static const String languageRoute = '/language';
  static const String dashboardRoute = '/dashboard';
  static const String aboutUsRoute = '/about_us';
  static const String announcementsRoute = '/announcements';
  static const String contactUsRoute = '/contact_us';
  static const String paymentsBarcodeRoute = '/payments_barcode';
  static const String profileRoute = '/profile';
  static const String contactInfoRoute = '/contact_info';
  static const String cardsRoute = '/cards';
  static const String qrImageRoute = '/qr_image_screen';
  static const String learningRoute = '/learning';
  static const String subjectRoute = '/subject';
}
