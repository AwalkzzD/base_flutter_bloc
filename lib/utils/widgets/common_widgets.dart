import 'package:base_flutter_bloc/utils/constants/app_theme.dart';
import 'package:flutter/material.dart';

Gradient getIconBgGradient() {
  return LinearGradient(
    colors: [
      themeOf().lightMode() ? const Color(0x2e7f1417) : const Color(0x42695c5c),
      themeOf().lightMode() ? const Color(0x1fbc212c) : const Color(0x42695c5c)
    ],
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
  );
}

Gradient getCommonGradient() {
  return LinearGradient(
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
    colors: [
      themeOf().accentColor,
      themeOf().primaryColor,
    ],
  );
}

Gradient getLightGradientSelected() {
  return LinearGradient(
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
    colors: [
      themeOf().accentColor,
      themeOf().primaryColor,
    ],
  );
}

Gradient getDarkGradientSelected() {
  return const LinearGradient(
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
    colors: [
      Colors.white,
      Colors.white,
    ],
  );
}

Gradient getLightGradientUnSelected() {
  return const LinearGradient(
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
    colors: [
      Color(0x1F7F1417),
      Color(0x1FBC212C),
    ],
  );
}

Gradient getDarkGradientUnSelected() {
  return const LinearGradient(
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
    colors: [
      Color(0xFF272727),
      Color(0xFF272727),
    ],
  );
}

Gradient getLightMessageSenderGradient() {
  return LinearGradient(
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
    colors: [Color(0xFFF2E7E7), Color(0xFFF2E7E7)],
  );
}

Gradient getDarkMessageSenderGradient() {
  return const LinearGradient(
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
    colors: [
      Color(0x33939393),
      Color(0x33939393),
    ],
  );
}

Gradient getLightMessageReceiverGradient() {
  return const LinearGradient(
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
    colors: [
      Color(0x1208263A),
      Color(0x1208263A),
    ],
  );
}

Gradient getDarkMessageReceiverGradient() {
  return const LinearGradient(
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
    colors: [
      Color(0x29FFFFFF),
      Color(0x29FFFFFF),
    ],
  );
}
