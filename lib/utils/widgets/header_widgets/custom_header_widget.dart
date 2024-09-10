import 'package:flutter/material.dart';

import '../../constants/app_styles.dart';
import '../../constants/app_theme.dart';

class CustomerHeader extends StatelessWidget {
  final String title;
  final TextStyle? customTextStyle;
  final TextAlign? textAlign;
  final Color? textColor;
  final FontWeight? fontWeight;
  final double? fontSize;

  const CustomerHeader(this.title,
      {this.fontSize,
      this.textColor,
      this.textAlign,
      this.fontWeight,
      this.customTextStyle,
      super.key});

  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      textAlign: textAlign ?? TextAlign.start,
      style: customTextStyle ??
          TextStyle(
              fontSize: fontSize ?? fSmall4,
              fontWeight: fontWeight ?? FontWeight.w600,
              fontFamily: fontFamilyPoppins,
              color: textColor ?? themeOf().textFieldHeaderColor),
    );
  }
}
