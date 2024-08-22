import 'package:base_flutter_bloc/utils/screen_utils/flutter_screen_util.dart';
import 'package:flutter/material.dart';

import '../../common_utils/shared_pref.dart';
import '../../constants/app_styles.dart';
import '../../constants/app_theme.dart';
import '../buttons_tabbar.dart';

class CustomTabButton extends StatelessWidget {
  final List<String> tabs;
  final EdgeInsetsDirectional? contentPadding;
  final double? height;
  final Function(int)? onTap;
  final EdgeInsetsDirectional? margin;
  final TabController? tabController;

  const CustomTabButton(this.tabs,
      {this.onTap,
      this.tabController,
      this.height,
      this.margin,
      this.contentPadding,
      super.key});

  @override
  Widget build(BuildContext context) {
    return ButtonsTabBar(
        controller: tabController,
        unselectedBorderColor: themeOf().tabButtonTextUnSelectedBorderColor,
        borderColor: themeOf().tabButtonTextSelectedBorderColor,
        contentPadding: contentPadding ??
            EdgeInsetsDirectional.symmetric(horizontal: 20.h, vertical: 2.h),
        buttonMargin: margin ??
            EdgeInsetsDirectional.symmetric(horizontal: 12.h, vertical: 12.h),
        borderWidth: 1,
        height: (height ?? 52.h) * getScaleFactorHeight(),
        decoration: BoxDecoration(
            gradient: themeOf().tabButtonSelectedIndicatorColor,
            borderRadius: BorderRadius.circular(5)),
        unselectedDecoration: BoxDecoration(
            gradient: themeOf().tabButtonUnSelectedIndicatorColor,
            borderRadius: BorderRadius.circular(5)),
        unselectedLabelStyle:
            styleSmall3.copyWith(color: themeOf().tabButtonTextUnSelectedColor),
        labelStyle:
            styleSmall3.copyWith(color: themeOf().tabButtonTextSelectedColor),
        onTap: onTap,
        tabs: List.generate(tabs.length, (index) => Tab(text: tabs[index])));
  }
}
