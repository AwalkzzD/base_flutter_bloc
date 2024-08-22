import 'package:flutter/material.dart';

class RoundedRectangleTabIndicator extends Decoration {
  final BoxPainter _painter;

  RoundedRectangleTabIndicator({required Color color, required double height, required double width})
      : _painter = _RoundedRectPainter(color, height, width);

  @override
  BoxPainter createBoxPainter([VoidCallback? onChanged]) {
    return _painter;
  }
}

class _RoundedRectPainter extends BoxPainter {
  final Paint _paint;
  final double height;
  final double width;

  _RoundedRectPainter(Color color, this.height, this.width)
      : _paint = Paint()
    ..color = color
    ..strokeWidth = height // Set the height as the stroke width for the rounded rectangle
    ..style = PaintingStyle.fill
    ..isAntiAlias = true;

  @override
  void paint(Canvas canvas, Offset offset, ImageConfiguration configuration) {
    final Rect rect = Offset(offset.dx + (configuration.size!.width - width) / 2, configuration.size!.height - height) &
    Size(width, height);
    final RRect rrect = RRect.fromRectAndRadius(rect, Radius.circular(height / 2)); // Set radius as half of height for a rounded rectangle
    canvas.drawRRect(rrect, _paint);
  }
}