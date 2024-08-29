import 'package:base_flutter_bloc/utils/screen_utils/flutter_screen_util.dart';
import 'package:flutter/material.dart';

import '../../common_utils/common_utils.dart';
import '../../constants/app_theme.dart';

class ProgressView extends StatelessWidget {
  final Color? color;
  final double? size;

  const ProgressView({Key? key, this.color, this.size}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (isTablet()) {
      return SizedBox(
        width: 40.h,
        height: 40.h,
        child: CircularProgressIndicator(
          color: color ?? (themeOf().accentColor),
        ),
      );
    } else if (size != null) {
      return SizedBox(
        width: size,
        height: size,
        child: CircularProgressIndicator(
          color: color ?? (themeOf().accentColor),
        ),
      );
    } else {
      return CircularProgressIndicator(
        color: color ?? (themeOf().accentColor),
      );
    }
  }
}
