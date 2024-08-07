import 'package:base_flutter_bloc/utils/constants/app_theme.dart';
import 'package:base_flutter_bloc/utils/screen_utils/flutter_screenutil.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class RNavItem {
  /// Icon when item is not selected
  final String iconPath;
  final String iconDisablePath;

  const RNavItem({
    required this.iconPath,
    required this.iconDisablePath,
  });
}

class RNavItemInner extends StatelessWidget {
  final String iconPath;
  final String iconDisablePath;
  final EdgeInsets? padding;
  final bool selected;
  final Color? selectedItemColor;
  final Color? unselectedItemColor;
  final Gradient? selectedItemGradient;
  final Gradient? unselectedItemGradient;
  final bool hide;
  final VoidCallback? onTap;

  const RNavItemInner({
    Key? key,
    required this.iconPath,
    required this.iconDisablePath,
    this.padding,
    this.selected = false,
    this.onTap,
    this.hide = false,
    this.selectedItemColor,
    this.selectedItemGradient,
    this.unselectedItemColor,
    this.unselectedItemGradient,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);

    var widget = Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        AnimatedSize(
            duration: const Duration(milliseconds: 300),
            child: SvgPicture.asset(
              selected ? iconPath : iconDisablePath,
              width: 24.h,
              height: 26.h,
              color: selected
                  ? themeOf().iconSelectedBottomBarColor
                  : themeOf().iconUnSelectedBottomBarColor,
            )),
        SizedBox(height: 5.h),
        AnimatedDefaultTextStyle(
          duration: const Duration(milliseconds: 150),
          style: (theme.textTheme.bodyMedium ?? const TextStyle()).copyWith(
            fontWeight: selected ? FontWeight.bold : FontWeight.normal,
            fontSize: selected ? 11 : 10,
          ),
          child: (selected)
              ? Container(
                  height: 5.h,
                  width: 5.h,
                  decoration: BoxDecoration(
                      color: selected
                          ? (themeOf().lightMode()
                              ? themeOf().accentColor
                              : Colors.white)
                          : const Color(0xFF526775),
                      borderRadius: BorderRadius.circular(30)),
                )
              : SizedBox(
                  height: 5.h,
                  width: 5.h,
                ),
        ),
      ],
    );

    return Padding(
      padding: EdgeInsets.zero,
      child: AnimatedSize(
        duration: const Duration(milliseconds: 100),
        alignment: Alignment.center,
        child: SizedBox(
          height: hide ? 0.0 : null,
          child: InkResponse(
            onTap: onTap,
            child: widget,
          ),
        ),
      ),
    );
  }
}
