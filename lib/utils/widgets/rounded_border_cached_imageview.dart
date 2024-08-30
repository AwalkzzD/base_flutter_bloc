import 'package:base_flutter_bloc/utils/widgets/image_view.dart';
import 'package:flutter/material.dart';

class RoundedBorderCachedImageView extends StatelessWidget {
  final String imageUrl;
  final double height;
  final double? maxHeight;
  final double width;
  final double borderRadius;
  final double borderWidth;
  final Color borderColor;
  final BoxFit? boxFit;
  final ImageShape? imageShape;
  final bool autoHeight;
  final Color? backgroundColor;
  final EdgeInsetsGeometry padding;

  const RoundedBorderCachedImageView(
      {super.key,
      required this.imageUrl,
      required this.height,
      required this.width,
      this.borderRadius = 8.0,
      this.borderWidth = 2,
      this.maxHeight,
      this.boxFit,
      this.padding = const EdgeInsets.all(0),
      this.imageShape,
      this.backgroundColor,
      this.autoHeight = false,
      required this.borderColor});

  @override
  Widget build(BuildContext context) {
    if (imageUrl.contains("https")) {
      if (autoHeight) {
        return Container(
            constraints: BoxConstraints(
              minWidth: width,
              maxWidth: width,
              maxHeight: maxHeight ?? double.infinity,
            ),
            padding: padding,
            decoration: BoxDecoration(
                color: backgroundColor,
                borderRadius: BorderRadius.circular(borderRadius),
                border: Border.all(
                    color: borderColor,
                    width: borderWidth,
                    style: borderWidth == 0
                        ? BorderStyle.none
                        : BorderStyle.solid)),
            child: ClipRRect(
                borderRadius: BorderRadius.circular(borderRadius - borderWidth),
                child: buildImageView(ImageType.network)));
      } else {
        return Container(
          constraints: BoxConstraints(
            minWidth: width,
            maxWidth: width,
            maxHeight: maxHeight ?? double.infinity,
          ),
          padding: padding,
          decoration: BoxDecoration(
              color: backgroundColor,
              borderRadius: BorderRadius.circular(borderRadius),
              border: Border.all(
                  color: borderColor,
                  width: borderWidth,
                  style:
                      borderWidth == 0 ? BorderStyle.none : BorderStyle.solid)),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(borderRadius - borderWidth),
            child: buildImageView(ImageType.network),
          ),
        );
      }
    } else {
      if (autoHeight) {
        return Container(
            width: width,
            decoration: BoxDecoration(
                color: backgroundColor,
                borderRadius: BorderRadius.circular(borderRadius),
                border: Border.all(
                    color: borderColor,
                    width: borderWidth,
                    style: borderWidth == 0
                        ? BorderStyle.none
                        : BorderStyle.solid)),
            child: ClipRRect(
                borderRadius: BorderRadius.circular(borderRadius - borderWidth),
                child: buildImageView(ImageType.base64)));
      } else {
        return Container(
          height: height,
          width: width,
          decoration: BoxDecoration(
              color: backgroundColor,
              borderRadius: BorderRadius.circular(borderRadius),
              border: Border.all(
                  color: borderColor,
                  width: borderWidth,
                  style:
                      borderWidth == 0 ? BorderStyle.none : BorderStyle.solid)),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(borderRadius - borderWidth),
            child: buildImageView(ImageType.base64),
          ),
        );
      }
    }
  }

  Widget buildImageView(ImageType imageType) {
    return ImageView(
      image: imageUrl,
      imageType: imageType,
      boxFit: boxFit ?? BoxFit.cover,
      imageShape: imageShape ?? ImageShape.none,
    );
  }
}
