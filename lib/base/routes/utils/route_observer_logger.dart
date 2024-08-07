import 'dart:developer';

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';

class RouteObserverLogger extends AutoRouteObserver {
  @override
  void didPush(Route route, Route? previousRoute) {
    if (route.isFirst) {
      log('Launching app, redirecting to ${route.settings.name}');
    } else {
      if (route.settings.name != '/flushbarRoute') {
        log('Navigated to ${route.settings.name}');
      }
      if (previousRoute != null) {
        if (previousRoute.settings.name != '/flushbarRoute') {
          log('Previous Route was ${previousRoute.settings.name}');
        }
      }
    }
  }

  @override
  void didReplace({Route? newRoute, Route? oldRoute}) {
    log('Replaced ${oldRoute?.settings.name} to ${newRoute?.settings.name}');
  }

  @override
  void didPop(Route route, Route? previousRoute) {
    if (route.settings.name != '/flushbarRoute') {
      log('Popped ${route.settings.name}');
    }
    if (previousRoute != null) {
      if (previousRoute.settings.name != '/flushbarRoute') {
        log('Currently active route is ${previousRoute.settings.name}');
      }
    }
  }
}
