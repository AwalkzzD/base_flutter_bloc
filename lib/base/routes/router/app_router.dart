import 'package:auto_route/auto_route.dart';
import 'package:base_flutter_bloc/base/routes/router/app_router.gr.dart';
import 'package:base_flutter_bloc/utils/common_utils/app_widgets.dart';
import 'package:flutter/material.dart';

@AutoRouterConfig(replaceInRouteName: 'Screen|Page,Route')
class AppRouter extends RootStackRouter {
  bool enableLogging;

  AppRouter({this.enableLogging = false});

  @override
  GlobalKey<NavigatorState> get navigatorKey => globalNavigatorKey;

  @override
  RouteType get defaultRouteType => const RouteType.cupertino();

  @override
  List<AutoRoute> get routes => [
        AutoRoute(page: SplashRoute.page, initial: true),
        AutoRoute(page: LoginRoute.page),
        AutoRoute(page: HomeRoute.page),
        AutoRoute(page: SettingsRoute.page),
        AutoRoute(page: AppDrawerWidget.page),
      ];

  @override
  List<AutoRouteGuard> get guards => [];
}
