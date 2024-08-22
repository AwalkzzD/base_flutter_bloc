import 'package:base_flutter_bloc/base/routes/router/app_router.dart';
import 'package:base_flutter_bloc/base/src_bloc.dart';
import 'package:base_flutter_bloc/bloc/splash/splash_bloc.dart';
import 'package:base_flutter_bloc/bloc/splash/splash_bloc_event.dart';
import 'package:base_flutter_bloc/utils/common_utils/app_widgets.dart';
import 'package:base_flutter_bloc/utils/constants/app_colors.dart';
import 'package:base_flutter_bloc/utils/constants/app_images.dart';
import 'package:base_flutter_bloc/utils/stream_helper/common_enums.dart';
import 'package:base_flutter_bloc/utils/widgets/image_view.dart';
import 'package:flutter/material.dart';

import '../../base/routes/router_utils/custom_route_arguments.dart';

// @RoutePage()
class SplashScreen extends BasePage {
  const SplashScreen({super.key});

  @override
  BasePageState<BasePage, BaseBloc<BaseEvent, BaseState>> getState() =>
      _SplashScreenState();
}

class _SplashScreenState extends BasePageState<SplashScreen, SplashBloc> {
  final SplashBloc _bloc = SplashBloc();
  AppLifecycleListener? listener;
  bool didAuthenticate = false;

  @override
  void initState() {
    super.initState();
    precacheImage(Image.asset(AppImages.splashLogo).image, globalContext);
    getBloc.add(CheckUserLoginStatus());
    /*loadBiometricData();*/
    listener = AppLifecycleListener(
      onResume: () {
        if (!didAuthenticate) {
          getBloc.add(CheckUserLoginStatus());
          /*loadBiometricData(); */
        }
      },
    );
  }

  @override
  Widget buildWidget(BuildContext context) {
    return customBlocConsumer(onDataReturn: (state) {
      switch (state.data) {
        default:
          return Container(
              color: primaryColor,
              alignment: Alignment.center,
              child: const ImageView(
                height: 140,
                width: 140,
                image: AppImages.splashLogo,
                imageType: ImageType.asset,
              ));
      }
    }, onDataPerform: (state) {
      switch (state.data) {
        case bool isLoggeddIn:
          if (isLoggeddIn) {
            // _delayedNavigation(HomeRoute(fromScreen: ScreenType.splash));
            _delayedNavigation(
                route: AppRouter.homeRoute, screenType: ScreenType.splash);
          } else {
            showToast('Please login to continue.');
            _delayedNavigation(route: AppRouter.loginRoute);
            // _delayedNavigation(const LoginRoute());
          }
      }
    });
  }

  void _delayedNavigation({
    required String route,
    ScreenType? screenType,
  }) async {
    await Future.delayed(const Duration(seconds: 1), () {
      router.pushReplacementNamed(route,
          arguments: CustomRouteArguments(
            fromScreen: screenType ?? ScreenType.normal,
          ));

      /*router.pushNamedAndRemoveUntil(route, (route) => false,
          arguments: CustomRouteArguments(
            screenType: screenType ?? ScreenType.normal,
          ));*/

      /*Navigator.pushReplacementNamed(globalContext, route,
          arguments: CustomRouteArguments(
            screenType: screenType ?? ScreenType.normal,
          ));*/
    });
  }

  @override
  void dispose() {
    if (listener != null) {
      listener?.dispose();
    }
    super.dispose();
  }

  @override
  SplashBloc get getBloc => _bloc;
}
