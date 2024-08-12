import 'package:base_flutter_bloc/utils/constants/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class ThemeState {
  final ThemeData themeData;
  final bool isDarkMode;

  const ThemeState({required this.themeData, required this.isDarkMode});

  static ThemeState get darkTheme => ThemeState(
      themeData: ThemeData.dark().copyWith(
        scaffoldBackgroundColor: const Color(0xFF121212),
        primaryColor: primaryColor,
        hintColor: hintTextColor,
        disabledColor: Colors.grey,
        cardColor: Colors.white,
        canvasColor: Colors.white,
        brightness: Brightness.dark,
        buttonTheme: ButtonThemeData(
            disabledColor: black.withOpacity(0.5),
            colorScheme: const ColorScheme.dark(),
            buttonColor: Colors.blue,
            splashColor: Colors.black),
        progressIndicatorTheme: const ProgressIndicatorThemeData(
            color: Colors.white, circularTrackColor: Colors.white),
        appBarTheme: const AppBarTheme(
          backgroundColor: Color(0xFF121212),
          elevation: 0.0,
          iconTheme: IconThemeData(color: Colors.white),
          systemOverlayStyle: SystemUiOverlayStyle(
              statusBarColor: Colors.white,
              statusBarIconBrightness: Brightness.light,
              statusBarBrightness: Brightness.dark),
        ),
      ),
      isDarkMode: true);

  static ThemeState get lightTheme => ThemeState(
      themeData: ThemeData.light().copyWith(
        scaffoldBackgroundColor: Colors.white,
        primaryColor: primaryColor,
        hintColor: hintTextColor,
        disabledColor: Colors.grey,
        cardColor: Colors.white,
        canvasColor: Colors.white,
        textSelectionTheme: TextSelectionThemeData(
          cursorColor: Colors.black,
          selectionColor: Colors.black.withOpacity(0.4),
        ),
        progressIndicatorTheme: const ProgressIndicatorThemeData(
            color: primaryColor, circularTrackColor: primaryColor),
        brightness: Brightness.light,
        buttonTheme: const ButtonThemeData(
            colorScheme: ColorScheme.light(),
            buttonColor: Colors.black,
            splashColor: Colors.white),
        appBarTheme: const AppBarTheme(
            elevation: 0.0,
            backgroundColor: Colors.white,
            iconTheme: IconThemeData(color: Color(0xFF121212)),
            systemOverlayStyle: SystemUiOverlayStyle(
                statusBarColor: Colors.white,
                statusBarIconBrightness: Brightness.dark,
                statusBarBrightness: Brightness.light)),
      ),
      isDarkMode: false);
}
