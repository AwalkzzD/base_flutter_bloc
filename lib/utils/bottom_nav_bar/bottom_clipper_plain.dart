import 'package:flutter/material.dart';

class BottomClipperPlain extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    double height = size.height;
    double width = size.width;
    Path path = Path();
    path.moveTo(0, 35);
    path.quadraticBezierTo(width / 2, 0, width, 35);
    path.lineTo(width, height);
    path.lineTo(0, height);
    return path;
  }

  @override
  bool shouldReclip(covariant BottomClipperPlain oldClipper) {
    return false;
  }
}

/// Clip background of [RNavNSheet] when sheet is enabled
class BottomClipper extends CustomClipper<Path> {
  final double value;

  BottomClipper({this.value = 20});

  @override
  Path getClip(Size size) {
    double height = size.height;
    double width = size.width;

    double curve = 8;
    double curveTo = 12;

    Path path = Path();
    path.moveTo(0, (value * 3) + 2);
    path.quadraticBezierTo(
      (width / 3) - curve - curveTo - 4,
      value * 3 - curveTo + 4,
      (width / 2) - curve - curveTo - 10,
      curveTo + (curveTo/2) + 2,
    );
    path.quadraticBezierTo(width / 2 - curveTo + curveTo, -8, width / 2 + curve + curveTo + curveTo + 2, curveTo + curve + 3);
    path.quadraticBezierTo((width / 1.5) + curve + curveTo + 18, value * 3 - curveTo + 6, width, (value * 3) + 2);
    path.lineTo(width, height);
    path.lineTo(0, height);
    return path;
  }

  @override
  bool shouldReclip(covariant BottomClipper oldClipper) {
    return oldClipper.value != value;
  }
}
