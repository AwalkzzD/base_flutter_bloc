import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../constants/app_colors.dart';
import '../../constants/app_styles.dart';

class CustomHeaderWithTrailing extends StatelessWidget {
  final String title;
  final TextStyle? customTextStyle;
  final TextAlign? textAlign;
  final Color? textColor;
  final FontWeight? fontWeight;
  final double? fontSize;
  final Widget? trailingIcon;

  const CustomHeaderWithTrailing(this.title,
      {this.fontSize,
      this.textColor,
      this.textAlign,
      this.fontWeight,
      this.customTextStyle,
      this.trailingIcon,
      super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Text(
            title,
            textAlign: textAlign ?? TextAlign.start,
            style: customTextStyle ??
                TextStyle(
                    fontSize: fontSize ?? fSmall4,
                    fontWeight: fontWeight ?? FontWeight.w600,
                    color: textColor ?? primaryColor),
          ),
        ),
        trailingIcon ?? const SizedBox()
      ],
    );
  }
}
