import 'package:flutter/material.dart';

import '../constants/app_theme.dart';

BoxDecoration getAppBarShadowDecoration() {
  return BoxDecoration(
    color: themeOf().appBarColor,
    borderRadius: const BorderRadius.only(
      bottomLeft: Radius.circular(30),
      bottomRight: Radius.circular(30),
    ),
    boxShadow: [
      BoxShadow(
        color: themeOf().dropShadowColor,
        spreadRadius: 2,
        blurRadius: 2,
        offset: const Offset(0, 4),
      ),
    ],
  );
}

BoxDecoration getListviewItemDecoration() {
  return BoxDecoration(
    color: themeOf().cardBgColor,
    borderRadius: const BorderRadius.only(
        topRight: Radius.circular(0),
        topLeft: Radius.circular(0),
        bottomLeft: Radius.circular(20),
        bottomRight: Radius.circular(20)),
    boxShadow: [
      BoxShadow(
        color: themeOf().cardDropShadowColor,
        spreadRadius: 1,
        blurRadius: 5,
        offset: const Offset(5, 5),
      ),
    ],
  );
}

BoxDecoration getBorderDecoration(
    {BorderRadiusGeometry? borderRadiusGeometry}) {
  return BoxDecoration(
      color: themeOf().textFieldBgColor,
      borderRadius: borderRadiusGeometry ?? BorderRadius.circular(6),
      border: Border.all(color: themeOf().textFieldBorderColor));
}
