import 'package:flutter/material.dart';

import '../constants/app_images.dart';
import '../constants/app_styles.dart';
import '../constants/app_theme.dart';
import 'common_appbar.dart';
import 'icon_appbar.dart';

class AppbarBackButtonNoShadow {
  static Widget build({
    required String? title,
    required Function()? onBackPressed,
    String leadingIcon = AppImages.icAppBarBack,
    Widget? leading,
    List<Widget>? trailing,
    TextStyle? textStyle,
  }) {
    return CommonAppBar(
      isShadowApplied: false,
      borderRadius: BorderRadius.zero,
      leading: leading ??
          IconAppBar(
            onClick: (context) {
              onBackPressed?.call();
            },
            image: leadingIcon,
            color: themeOf().iconColor,
          ),
      title: title != null
          ? Text(
              title,
              textAlign: TextAlign.start,
              style: getTitleStyle(textStyle),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            )
          : const SizedBox(),
      trailing: trailing,
    );
  }

  static TextStyle getTitleStyle(TextStyle? textStyle) {
    return textStyle ??
        styleMediumMedium.copyWith(
            fontWeight: FontWeight.w600, color: themeOf().appBarTextColor);
  }
}
