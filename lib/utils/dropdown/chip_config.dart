import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';

class ChipConfig {
  final Icon? deleteIcon;

  final Color deleteIconColor;
  final Color labelColor;
  final Color? backgroundColor;

  final TextStyle? labelStyle;
  final EdgeInsetsDirectional padding;
  final EdgeInsetsDirectional labelPadding;

  final double radius;
  final double spacing;
  final double runSpacing;

  final Widget? separator;

  final WrapType wrapType;

  final bool autoScroll;

  const ChipConfig({
    this.deleteIcon,
    this.deleteIconColor = Colors.white,
    this.backgroundColor,
    this.padding = const EdgeInsetsDirectional.only(start: 12, top: 0, end: 4, bottom: 0),
    this.radius = 18,
    this.spacing = 8,
    this.runSpacing = 8,
    this.separator,
    this.labelColor = Colors.white,
    this.labelStyle,
    this.wrapType = WrapType.scroll,
    this.labelPadding = EdgeInsetsDirectional.zero,
    this.autoScroll = false,
  });
}

enum WrapType { scroll, wrap }
