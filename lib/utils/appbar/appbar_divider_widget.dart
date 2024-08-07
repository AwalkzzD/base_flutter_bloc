import 'package:base_flutter_bloc/utils/constants/app_theme.dart';
import 'package:flutter/material.dart';

class AppBarDividerWidget extends StatefulWidget {
  const AppBarDividerWidget({super.key});

  @override
  State<AppBarDividerWidget> createState() => _AppBarDividerWidgetState();
}

class _AppBarDividerWidgetState extends State<AppBarDividerWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: themeOf().dividerColor,
      margin: const EdgeInsets.only(left: 16, right: 12),
      height: 0.5,
    );
  }
}
