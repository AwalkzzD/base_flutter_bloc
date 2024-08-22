import 'dart:ui';

import 'package:base_flutter_bloc/utils/screen_utils/flutter_screen_util.dart';
import 'package:flutter/material.dart';

import '../../constants/app_theme.dart';

class OverlayCustomLoader extends StatelessWidget {
  const OverlayCustomLoader({super.key});

  @override
  Widget build(BuildContext context) {
    return BackdropFilter(
      filter: ImageFilter.blur(
        sigmaX: 4.5,
        sigmaY: 4.5,
      ),
      child: Center(
        child: Container(
          decoration: BoxDecoration(
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.5),
                  spreadRadius: 5,
                  blurRadius: 7,
                  offset: const Offset(0, 3),
                ),
              ],
              color: themeOf().progressBgColor,
              borderRadius: BorderRadius.circular(12)),
          width: 150,
          height: 150,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CircularProgressIndicator(color: themeOf().accentColor),
              SizedBox(height: 20.h),
              Text(
                'Loading',
                style: TextStyle(color: themeOf().textPrimaryColor),
                textAlign: TextAlign.center,
              )
            ],
          ),
        ),
      ),
    );
  }
}
