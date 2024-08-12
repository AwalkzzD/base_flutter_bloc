import 'package:base_flutter_bloc/utils/screen_utils/flutter_screen_util.dart';
import 'package:base_flutter_bloc/utils/widgets/image_view.dart';
import 'package:flutter/material.dart';

class IconAppBar extends StatelessWidget {
  final Function(BuildContext)? onClick;
  final String? image;
  final Widget? icon;
  final ImageType? imageType;
  final Color? color;
  final double? width;
  final double? height;

  const IconAppBar(
      {this.onClick,
      this.image,
      this.imageType,
      this.icon,
      this.color,
      this.width,
      this.height,
      super.key});

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: () {
        onClick?.call(context);
      },
      icon: icon ??
          ImageView(
            image: image ?? "",
            imageType: ImageType.svg,
            height: height ?? 16.h,
            width: width ?? 16.h,
            color: color ?? Theme.of(context).appBarTheme.iconTheme?.color,
          ),
    );
  }
}
