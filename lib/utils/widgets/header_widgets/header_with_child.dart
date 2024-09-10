import 'package:base_flutter_bloc/utils/screen_utils/flutter_screen_util.dart';
import 'package:flutter/material.dart';

import 'custom_header_widget.dart';

class HeaderWithChild extends StatelessWidget {
  final MainAxisAlignment? mainAxisAlignment;
  final CrossAxisAlignment? crossAxisAlignment;
  final MainAxisSize? mainAxisSize;
  final String title;
  final TextStyle? customTextStyle;
  final TextAlign? textAlign;
  final Color? textColor;
  final FontWeight? fontWeight;
  final double? fontSize;
  final double? heightSpace;
  final Widget? child;

  const HeaderWithChild(this.title, this.child,
      {this.mainAxisAlignment,
      this.mainAxisSize,
      this.crossAxisAlignment,
      this.fontSize,
      this.textColor,
      this.textAlign,
      this.fontWeight,
      this.customTextStyle,
      this.heightSpace,
      super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: mainAxisAlignment ?? MainAxisAlignment.start,
      mainAxisSize: mainAxisSize ?? MainAxisSize.max,
      crossAxisAlignment: crossAxisAlignment ?? CrossAxisAlignment.start,
      children: [
        title.isNotEmpty == true
            ? CustomerHeader(title,
                textAlign: textAlign,
                textColor: textColor,
                fontWeight: fontWeight,
                fontSize: fontSize,
                customTextStyle: customTextStyle)
            : const SizedBox(),
        SizedBox(height: heightSpace ?? 10.h),
        child ?? const SizedBox()
      ],
    );
  }
}
