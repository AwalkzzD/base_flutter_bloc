import 'package:flutter/material.dart';

import '../constants/app_colors.dart';

class BulletView extends StatelessWidget {
  final double height;
  final double width;

  const BulletView({super.key, required this.height, required this.width});

  @override
  Widget build(BuildContext context) {
    return Container(
        height: height,
        width: width,
        // padding: const EdgeInsets.all(15),
        margin: const EdgeInsetsDirectional.fromSTEB(0, 2, 10, 0),
        decoration: BoxDecoration(
          color: primaryColor,
          border: Border.all(color: bulletBorderColor, width: 2),
          borderRadius: const BorderRadius.all(
            Radius.circular(20),
          ),
        ));
  }
}
