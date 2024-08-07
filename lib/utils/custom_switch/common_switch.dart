import 'package:base_flutter_bloc/utils/screen_utils/flutter_screenutil.dart';
import 'package:flutter/material.dart';

import '../constants/app_styles.dart';
import '../constants/app_theme.dart';
import 'common_switch_widget.dart';

class CommonSwitch {
  static Widget build({
    required String title,
    required Stream<bool> switchStream,
    required Function(bool) onValueChanged,
    TextStyle? titleStyle,
  }) {
    return Padding(
      padding: EdgeInsetsDirectional.fromSTEB(20.h, 0.h, 20.h, 0.h),
      child: Container(
        padding: EdgeInsetsDirectional.fromSTEB(14.h, 8.h, 10.h, 8.h),
        decoration: BoxDecoration(
            color: themeOf().cardBgColor,
            border: Border.all(color: themeOf().cardBorderColor),
            borderRadius: BorderRadius.circular(10)),
        child: Row(
          children: [
            Expanded(
              child: Text(title,
                  style: titleStyle ??
                      styleMedium1.copyWith(
                          color: themeOf().textSubSecondaryColor)),
            ),
            Padding(
                padding: EdgeInsetsDirectional.fromSTEB(12.h, 4.h, 12.h, 4.h),
                child: StreamBuilder<bool>(
                    stream: switchStream,
                    builder: (context, snapshot) {
                      return CommonSwitchWidget(
                        width: 38.h,
                        height: 22.h,
                        thumbSize: 18.h,
                        padding: 2.h,
                        value: snapshot.data ?? true,
                        onToggle: onValueChanged,
                      );
                    })),
          ],
        ),
      ),
    );
  }

  static TextStyle getTitleStyle(TextStyle? textStyle) {
    return textStyle ?? styleMediumMedium.copyWith(fontWeight: FontWeight.w600);
  }
}
