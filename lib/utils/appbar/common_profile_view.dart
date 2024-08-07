import 'package:base_flutter_bloc/utils/constants/app_theme.dart';
import 'package:base_flutter_bloc/utils/widgets/image_view.dart';
import 'package:base_flutter_bloc/utils/widgets/rounded_border_cached_imageview.dart';
import 'package:flutter/material.dart';

extension on String {
  String initials() {
    String result = "";
    List<String> words = split(" ");
    for (var element in words) {
      if (element.trim().isNotEmpty && result.length < 2) {
        result += element[0].trim();
      }
    }

    return result.trim().toUpperCase();
  }
}

class CommonProfileView extends StatelessWidget {
  final double? height;
  final String image;
  final String text;
  final Color? backgroundColor;
  final double size;
  final double borderRadius;
  final double borderWidth;
  final Color? borderColor;
  final BoxFit? boxFit;
  final ImageShape? imageShape;

  const CommonProfileView(
      {Key? key,
      required this.image,
      required this.text,
      this.backgroundColor,
      this.size = 30,
      this.height,
      this.borderRadius = 8,
      this.borderWidth = 2,
      this.borderColor,
      this.boxFit,
      this.imageShape})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (image.isNotEmpty) {
      return RoundedBorderCachedImageView(
        imageUrl: image,
        height: height ?? size,
        width: size,
        borderWidth: borderWidth,
        borderRadius: borderRadius,
        borderColor: borderColor ?? themeOf().appBarTextColor,
        boxFit: boxFit,
        imageShape: imageShape,
      );
    } else {
      return Container(
        width: size,
        height: height ?? size,
        decoration: getDecoration(),
        child: Center(
          child: Text(
            text.initials(),
            style: TextStyle(color: _color(), fontSize: _fontSize),
          ),
        ),
      );
    }
  }

  BoxDecoration getDecoration() {
    if (imageShape != null && imageShape == ImageShape.circle) {
      return BoxDecoration(
        shape: imageShape == ImageShape.circle
            ? BoxShape.circle
            : BoxShape.rectangle,
        color: _backgroundColor(),
      );
    } else {
      return BoxDecoration(
        color: _backgroundColor(),
        borderRadius: BorderRadius.circular(borderRadius),
        border: Border.all(
            width: borderWidth,
            color: borderColor ?? themeOf().appBarTextColor),
      );
    }
  }

  Color colorFor(String text) {
    var hash = 0;
    for (var i = 0; i < text.length; i++) {
      hash = text.codeUnitAt(i) + ((hash << 5) - hash);
    }
    final finalHash = hash.abs() % (256 * 256 * 256);
    final red = ((finalHash & 0xFF0000) >> 16);
    final blue = ((finalHash & 0xFF00) >> 8);
    final green = ((finalHash & 0xFF));
    final color = Color.fromRGBO(red, green, blue, 1);
    return color;
  }

  Color _color() {
    Color bgColor = _backgroundColor();
    return HSLColor.fromColor(bgColor).lightness < 0.8
        ? Colors.white
        : Colors.black87;
  }

  Color _backgroundColor() {
    return backgroundColor ?? colorFor(text);
  }

  double get _fontSize => size / (text.initials().length == 2 ? 2.5 : 1.8);
}
