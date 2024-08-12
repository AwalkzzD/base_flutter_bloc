import 'package:base_flutter_bloc/utils/constants/app_theme.dart';
import 'package:base_flutter_bloc/utils/screen_utils/flutter_screen_util.dart';
import 'package:flutter/material.dart';

class CommonAppBar extends StatelessWidget implements PreferredSizeWidget {
  const CommonAppBar(
      {super.key,
      this.leading,
      this.trailing,
      this.title,
      this.subtitle,
      this.height,
      this.borderRadius,
      this.elevation,
      this.bottom = const SizedBox(),
      this.trailingSize,
      this.centerTitle = false,
      this.isShadowApplied = true,
      this.backgroundColor});

  final Widget? leading;
  final List<Widget>? trailing;
  final double? height;
  final Widget? title;
  final Widget? subtitle;
  final BorderRadiusGeometry? borderRadius;
  final double? elevation;
  final Widget bottom;
  final bool centerTitle;
  final bool isShadowApplied;
  final Color? backgroundColor;
  final double? trailingSize;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        padding: EdgeInsetsDirectional.only(start: 9.h, end: 12.h),
        decoration: BoxDecoration(
            borderRadius: borderRadius ??
                const BorderRadius.only(
                  bottomLeft: Radius.circular(30),
                  bottomRight: Radius.circular(30),
                ),
            boxShadow: !isShadowApplied
                ? []
                : [
                    BoxShadow(
                      color: themeOf().dropShadowColor,
                      spreadRadius: 2,
                      blurRadius: 2,
                      offset: const Offset(0, 4),
                    ),
                  ],
            color: backgroundColor ??
                Theme.of(context).appBarTheme.backgroundColor),
        child: Column(
          mainAxisSize: MainAxisSize.max,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Expanded(
              child: Stack(
                alignment: AlignmentDirectional.centerStart,
                children: [
                  Align(
                      alignment: Alignment.center,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          leading ?? const SizedBox(),
                          centerTitle ? const Spacer() : const SizedBox(),
                          Expanded(
                            child: Container(
                                padding: EdgeInsetsDirectional.symmetric(
                                    horizontal: 8.h),
                                child: buildContent()),
                          ),
                          SizedBox(
                            width: 10.w,
                          ),
                          (trailing != null && trailing?.isNotEmpty == true)
                              ? getTrailingListWidgets(trailing!)
                              : const SizedBox(),
                        ],
                      )),
                ],
              ),
            ),
            Align(alignment: AlignmentDirectional.bottomCenter, child: bottom)
          ],
        ),
      ),
    );
  }

  Widget buildContent() {
    if (title != null && subtitle != null) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [title ?? const SizedBox(), subtitle ?? const SizedBox()],
      );
    } else {
      return title ?? const SizedBox();
    }
  }

  Widget getTrailingListWidgets(List<Widget> widgets) {
    return Row(
        children: widgets
            .map((item) => Padding(
                  padding: EdgeInsetsDirectional.only(start: trailingSize ?? 0),
                  child: item,
                ))
            .toList());
  }

  @override
  Size get preferredSize => Size(double.infinity, height ?? 66.h);
}
