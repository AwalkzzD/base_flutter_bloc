import 'package:base_flutter_bloc/utils/screen_utils/flutter_screenutil.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

/// Toggle button for the bottom sheet
class SheetToggleButton extends StatelessWidget {
  final VoidCallback? onTap;
  final String imagePath;

  const SheetToggleButton({Key? key, required this.imagePath, this.onTap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
        child: InkResponse(
      onTap: onTap,
      child: Container(
        width: 56.h,
        height: 56.h,
        decoration: const BoxDecoration(
          shape: BoxShape.circle,
        ),
        child: SvgPicture.asset(
          imagePath,
          width: 46.h,
          height: 46.h,
        ),
      ),
    ));
  }
}
