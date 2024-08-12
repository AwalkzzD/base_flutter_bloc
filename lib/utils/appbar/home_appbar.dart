import 'package:base_flutter_bloc/utils/appbar/common_appbar.dart';
import 'package:base_flutter_bloc/utils/appbar/icon_appbar.dart';
import 'package:base_flutter_bloc/utils/constants/app_images.dart';
import 'package:flutter/material.dart';

class HomeAppbar {
  static Widget build({
    required String? title,
    String leadingIcon = AppImages.icAppBarMenu,
    TextStyle? textStyle,
    required Function()? onMenuPressed,
    required Function()? onSearchPressed,
    bool isShadowApplied = false,
    Widget bottom = const SizedBox(),
    List<Widget>? trailing,
  }) {
    return CommonAppBar(
      isShadowApplied: isShadowApplied,
      borderRadius: !isShadowApplied ? BorderRadius.zero : null,
      leading: IconAppBar(
        onClick: (context) {
          onMenuPressed?.call();
        },
        image: leadingIcon,
      ),
      title: title != null
          ? Text(
              title,
              textAlign: TextAlign.start,
              overflow: TextOverflow.ellipsis,
              maxLines: 1,
              style: getTitleStyle(textStyle),
            )
          : const SizedBox(),
      trailing: trailing,
      bottom: !isShadowApplied ? bottom : const SizedBox(),
    );
  }

  static TextStyle getTitleStyle(TextStyle? textStyle) {
    return textStyle ?? const TextStyle();
  }
}
