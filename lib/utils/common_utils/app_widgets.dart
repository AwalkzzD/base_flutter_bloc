import 'package:another_flushbar/flushbar.dart';
import 'package:flutter/material.dart';

/// to get main navigator key
final GlobalKey<NavigatorState> globalNavigatorKey =
    GlobalKey<NavigatorState>();

/// to get all app context
final BuildContext globalContext = globalNavigatorKey.currentState!.context;

showToast(String message) {
  /*ScaffoldMessenger.of(globalContext).showSnackBar(
      SnackBar(
        content: Text(message,
            maxLines: 3, style: const TextStyle(color: Colors.white)),
        duration: const Duration(seconds: 3),
      ),
      snackBarAnimationStyle: AnimationStyle());*/
  Flushbar(
    margin: const EdgeInsets.all(10.0),
    borderRadius: BorderRadius.circular(10.0),
    flushbarPosition: FlushbarPosition.BOTTOM,
    flushbarStyle: FlushbarStyle.FLOATING,
    isDismissible: true,
    duration: const Duration(seconds: 5),
    messageText:
        Text(message, maxLines: 3, style: const TextStyle(color: Colors.white)),
  ).show(globalContext);
}
