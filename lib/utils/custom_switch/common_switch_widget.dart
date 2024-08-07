import 'package:flutter/material.dart';
import 'package:flutter_switch/flutter_switch.dart';

import '../constants/app_images.dart';
import '../constants/app_theme.dart';
import '../widgets/image_view.dart';

class CommonSwitchWidget extends StatefulWidget {
  final double height;
  final double width;
  final double thumbSize;
  final bool value;
  final double padding;
  final bool showIcon;
  final Function(bool) onToggle;

  const CommonSwitchWidget(
      {super.key,
      required this.height,
      required this.width,
      required this.padding,
      required this.thumbSize,
      required this.value,
      this.showIcon = false,
      required this.onToggle});

  @override
  State<CommonSwitchWidget> createState() => _CommonSwitchWidgetState();
}

class _CommonSwitchWidgetState extends State<CommonSwitchWidget> {
  @override
  Widget build(BuildContext context) {
    return FlutterSwitch(
      width: widget.width,
      height: widget.height,
      toggleSize: widget.thumbSize,
      value: widget.value,
      padding: widget.padding,
      toggleColor: widget.value
          ? themeOf().activeSwitchToggleColor
          : themeOf().inActiveSwitchToggleColor,
      activeColor: themeOf().activeSwitchBgColor,
      activeSwitchBorder: Border.all(
        color: themeOf().activeSwitchBorderBgColor,
      ),
      inactiveColor: themeOf().inActiveSwitchBgColor,
      inactiveSwitchBorder: Border.all(
        color: themeOf().inActiveSwitchBorderBgColor,
      ),
      activeIcon: (widget.showIcon)
          ? const ImageView(
              image: AppImages.icActiveIcon, imageType: ImageType.svg)
          : Container(),
      inactiveIcon: (widget.showIcon)
          ? const ImageView(
              image: AppImages.icInActiveIcon, imageType: ImageType.svg)
          : Container(),
      showOnOff: false,
      onToggle: (val) {
        widget.onToggle(val);
      },
    );
  }
}
