import 'package:flutter/material.dart';

import '../constants/app_theme.dart';

class GradientOverlay extends StatelessWidget {
  const GradientOverlay({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: double.infinity,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: const Alignment(0.0, 0.9),
          stops: const [0.0, 0.9],
          colors: [
            Colors.transparent,
            themeOf().textPrimaryColor.withOpacity(0.7),
          ],
        ),
      ),
    );
  }
}
