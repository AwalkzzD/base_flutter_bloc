import 'package:base_flutter_bloc/utils/screen_utils/flutter_screen_util.dart';
import 'package:flutter/material.dart';

import '../../constants/app_styles.dart';
import '../../constants/app_theme.dart';
import 'circle_tab_indicator.dart';

class CustomTabIndicator extends StatelessWidget {
  final List<Widget> tabs;
  final EdgeInsetsDirectional? margin;
  final Function(int)? onTap;
  final TabController? tabController;

  const CustomTabIndicator(this.tabs,
      {this.tabController, this.onTap, this.margin, super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      margin: margin ?? EdgeInsetsDirectional.only(bottom: 6.h),
      decoration: BoxDecoration(
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
      ),
      child: TabBar(
        isScrollable: true,
        controller: tabController,
        tabAlignment: TabAlignment.center,
        tabs: tabs,
        dividerColor: Colors.transparent,
        onTap: onTap,
        indicator: RoundedRectangleTabIndicator(
            color: themeOf().tabSelectedIndicatorColor, width: 26.h, height: 3),
        indicatorColor: themeOf().tabSelectedIndicatorColor,
        labelStyle: styleMedium1.copyWith(
            color: themeOf().tabSelectedIndicatorColor,
            fontWeight: FontWeight.w500),
        unselectedLabelStyle: styleMedium1.copyWith(
            color: themeOf().tabUnSelectedIndicatorColor,
            fontWeight: FontWeight.normal),
        labelPadding: EdgeInsets.symmetric(horizontal: 20.w),
      ),
    );
  }
}
