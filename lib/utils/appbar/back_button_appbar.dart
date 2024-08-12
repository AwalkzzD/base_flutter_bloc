import 'package:flutter/material.dart';

import '../constants/app_images.dart';
import '../constants/app_styles.dart';
import '../constants/app_theme.dart';
import 'common_appbar.dart';
import 'icon_appbar.dart';

class AppBarBackButton {
  static Widget build({
    required String? title,
    required Function()? onBackPressed,
    String leadingIcon = AppImages.icAppBarBack,
    String? subTitle,
    List<Widget>? trailing,
    TextStyle? textStyle,
  }) {
    return CommonAppBar(
      leading: IconAppBar(
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
              overflow: TextOverflow.ellipsis,
              maxLines: 1,
              style: getTitleStyle(subTitle, textStyle),
            )
          : const SizedBox(),
      subtitle: subTitle != null
          ? Text(
              subTitle,
              textAlign: TextAlign.start,
              overflow: TextOverflow.ellipsis,
              maxLines: 1,
              style: getSubTitleStyle(textStyle),
            )
          : null,
      trailing: trailing,
    );
  }

  static TextStyle getTitleStyle(String? subTitle, TextStyle? textStyle) {
    if (subTitle == null) {
      return textStyle ??
          styleMediumMedium.copyWith(
              fontWeight: FontWeight.w600, color: themeOf().appBarTextColor);
    } else {
      return textStyle ??
          styleSmall4.copyWith(
              fontWeight: FontWeight.w600, color: themeOf().appBarTextColor);
    }
  }

  static TextStyle getSubTitleStyle(TextStyle? textStyle) {
    return textStyle ??
        styleSmall3.copyWith(
            fontWeight: FontWeight.w600, color: themeOf().appBarTextColor);
  }
}
