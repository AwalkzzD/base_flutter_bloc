import 'package:base_flutter_bloc/utils/widgets/image_view.dart';
import 'package:flutter/material.dart';

class RoundedBorderCachedImageView extends StatelessWidget {
  final String imageUrl;
  final double height;
  final double width;
  final double borderRadius;
  final double borderWidth;
  final Color borderColor;
  final BoxFit? boxFit;
  final ImageShape? imageShape;

  const RoundedBorderCachedImageView(
      {super.key,
      required this.imageUrl,
      required this.height,
      required this.width,
      this.borderRadius = 8.0,
      this.borderWidth = 2,
      this.boxFit,
      this.imageShape,
      required this.borderColor});

  @override
  Widget build(BuildContext context) {
    if (imageUrl.contains("https")) {
      return Container(
        height: height,
        width: width,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(borderRadius),
            border: Border.all(
                color: borderColor,
                width: borderWidth,
                style:
                    borderWidth == 0 ? BorderStyle.none : BorderStyle.solid)),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(borderRadius - borderWidth),
          child: ImageView(
            image: imageUrl,
            imageType: ImageType.network,
            imageShape: imageShape ?? ImageShape.none,
            /*placeholder: (context, url) => const CircularProgressIndicator(),
            errorWidget: (context, url, error) => const Icon(Icons.error),*/
            boxFit: boxFit ?? BoxFit.cover,
          ),
        ),
      );
    } else {
      return Container(
        height: height,
        width: width,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(borderRadius),
            border: Border.all(
                color: borderColor,
                width: borderWidth,
                style:
                    borderWidth == 0 ? BorderStyle.none : BorderStyle.solid)),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(borderRadius - borderWidth),
          child: ImageView(
            image: imageUrl,
            imageType: ImageType.base64,
            boxFit: boxFit,
            imageShape: imageShape ?? ImageShape.none,
          ),
        ),
      );
    }
  }
}
