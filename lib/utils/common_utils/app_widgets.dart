import 'dart:developer';

import 'package:another_flushbar/flushbar.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';

/// to get main navigator key
final GlobalKey<NavigatorState> globalNavigatorKey =
    GlobalKey<NavigatorState>();

/// to get all app context
final BuildContext globalContext = globalNavigatorKey.currentState!.context;

showToast(String message) {
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

void printNavigationStack(BuildContext context) {
  final stack = AutoRouter.of(context).stack.reversed.toList();
  final buffer = StringBuffer();

  buffer.writeln();
  buffer.writeln(
      '--------------------------Navigation Stack--------------------------');
  buffer.writeln();

  for (int i = 0; i < stack.length; i++) {
    final indent = ' ' * (i + 1) * 2;
    buffer.writeln('$indent|_ ${stack[i].name}');
  }

  buffer.writeln();
  buffer.writeln(
      '--------------------------Navigation Stack--------------------------');

  log(buffer.toString());
}
