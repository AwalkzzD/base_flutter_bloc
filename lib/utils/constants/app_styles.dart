import 'package:base_flutter_bloc/utils/constants/app_colors.dart';
import 'package:base_flutter_bloc/utils/constants/app_theme.dart';
import 'package:base_flutter_bloc/utils/screen_utils/flutter_screen_util.dart';
import 'package:flutter/material.dart';

const String fontFamilyRoboto = "Roboto";

double fSmall1 = 8.sp;
double fSmall2 = 10.sp;
double fSmall3 = 12.sp;
double fSmall13 = 13.sp;
double fSmall4 = 14.sp;

double fMedium1 = 16.sp;
double fMedium2 = 18.sp;
double fMedium3 = 20.sp;
double fMedium4 = 22.sp;

double fLarge1 = 24.sp;
double fLarge2 = 26.sp;
double fLarge3 = 28.sp;
double fLarge4 = 30.sp;
double fLarge5 = 32.sp;
double fLarge6 = 34.sp;
double fLarge7 = 36.sp;
double fLarge8 = 38.sp;

/// Small
TextStyle styleSmall1 =
    TextStyle(fontSize: fSmall1, color: black, fontFamily: fontFamilyRoboto);

TextStyle styleSmall1Regular = TextStyle(
    fontSize: fSmall1,
    color: black,
    fontFamily: fontFamilyRoboto,
    fontWeight: FontWeight.normal);

TextStyle styleSmall1Bold = TextStyle(
    fontSize: fSmall1,
    color: black,
    fontFamily: fontFamilyRoboto,
    fontWeight: FontWeight.bold);

TextStyle styleSmall2 =
    TextStyle(fontSize: fSmall2, color: black, fontFamily: fontFamilyRoboto);

TextStyle styleSmall2MediumWhite = TextStyle(
    fontSize: fSmall2,
    color: Colors.white,
    fontFamily: fontFamilyRoboto,
    fontWeight: FontWeight.w500);

TextStyle styleSmall2Normal = TextStyle(
    fontSize: fSmall2,
    color: themeOf().textPrimaryColor,
    fontFamily: fontFamilyRoboto,
    fontWeight: FontWeight.normal);

TextStyle styleSmall2NormalItalic = TextStyle(
    fontSize: fSmall2,
    color: themeOf().textPrimaryColor,
    fontFamily: fontFamilyRoboto,
    fontStyle: FontStyle.italic,
    fontWeight: FontWeight.normal);

TextStyle styleSmall2Medium = TextStyle(
    fontSize: fSmall2,
    color: themeOf().textPrimaryColor,
    fontFamily: fontFamilyRoboto,
    fontWeight: FontWeight.w500);

TextStyle styleSmall2Bold = TextStyle(
    fontSize: fSmall2,
    color: black,
    fontFamily: fontFamilyRoboto,
    fontWeight: FontWeight.bold);

TextStyle styleSmall2SemiBold = TextStyle(
    fontSize: fSmall2,
    color: themeOf().accentColor,
    fontFamily: fontFamilyRoboto,
    fontWeight: FontWeight.w600);

TextStyle styleSmall3 =
    TextStyle(fontSize: fSmall3, color: black, fontFamily: fontFamilyRoboto);

TextStyle styleSmall = TextStyle(
    fontSize: fSmall3,
    color: themeOf().textPrimaryColor,
    fontFamily: fontFamilyRoboto,
    fontWeight: FontWeight.normal);

TextStyle styleSmallDarkBlueMedium = TextStyle(
    fontSize: fSmall3,
    color: themeOf().textPrimaryColor,
    fontFamily: fontFamilyRoboto,
    fontWeight: FontWeight.w500);

TextStyle styleSmall3MediumGray = TextStyle(
    fontSize: fSmall3,
    color: gray75Color,
    fontFamily: fontFamilyRoboto,
    fontWeight: FontWeight.w500);

TextStyle styleSmall3Medium = TextStyle(
    fontSize: fSmall3,
    color: themeOf().textPrimaryColor,
    fontFamily: fontFamilyRoboto,
    fontWeight: FontWeight.w500);

TextStyle styleSmall3MediumWhite = TextStyle(
    fontSize: fSmall3,
    color: Colors.white,
    fontFamily: fontFamilyRoboto,
    fontWeight: FontWeight.w500);

TextStyle styleSmall3SemiBold = TextStyle(
    fontSize: fSmall3,
    color: black,
    fontFamily: fontFamilyRoboto,
    fontWeight: FontWeight.w600);

TextStyle styleSmall3Bold = TextStyle(
    fontSize: fSmall3,
    color: black,
    fontFamily: fontFamilyRoboto,
    fontWeight: FontWeight.bold);

TextStyle styleSmall13Medium = TextStyle(
    fontSize: fSmall13,
    color: themeOf().textPrimaryColor,
    fontFamily: fontFamilyRoboto,
    fontWeight: FontWeight.w500);

TextStyle styleSmall13MediumWhite = TextStyle(
    fontSize: fSmall13,
    color: Colors.white,
    fontFamily: fontFamilyRoboto,
    fontWeight: FontWeight.w500);

TextStyle styleSmall4 =
    TextStyle(fontSize: fSmall4, color: black, fontFamily: fontFamilyRoboto);

TextStyle styleSmall4Medium = TextStyle(
    fontSize: fSmall4,
    color: black,
    fontFamily: fontFamilyRoboto,
    fontWeight: FontWeight.w500);

TextStyle dateCalendarStyleWhite = TextStyle(
    fontSize: fSmall4, color: Colors.white, fontFamily: fontFamilyRoboto);

TextStyle dateCalendarStylePrimary = TextStyle(
    fontSize: fSmall4,
    color: themeOf().accentColor,
    fontFamily: fontFamilyRoboto,
    fontWeight: FontWeight.w500);

TextStyle styleSmall4SemiBold = TextStyle(
    fontSize: fSmall4,
    color: themeOf().accentColor,
    fontFamily: fontFamilyRoboto,
    fontWeight: FontWeight.w600);

TextStyle styleSmall4Regular = TextStyle(
    fontSize: fSmall4,
    color: Colors.white,
    fontFamily: fontFamilyRoboto,
    fontWeight: FontWeight.normal);

TextStyle styleSmall4RegularDarkBlue = TextStyle(
    fontSize: fSmall4,
    color: themeOf().textPrimaryColor,
    fontFamily: fontFamilyRoboto,
    fontWeight: FontWeight.normal);

TextStyle styleSmall4Bold = TextStyle(
    fontSize: fSmall4,
    color: black,
    fontFamily: fontFamilyRoboto,
    fontWeight: FontWeight.bold);

/// Medium
TextStyle styleMedium1 =
    TextStyle(fontSize: fMedium1, color: black, fontFamily: fontFamilyRoboto);

TextStyle calendarDateStyle = TextStyle(
    fontSize: fMedium1,
    fontFamily: fontFamilyRoboto,
    fontWeight: FontWeight.w500);

TextStyle styleMedium1SemiBold = TextStyle(
    fontSize: fMedium1,
    color: themeOf().accentColor,
    fontFamily: fontFamilyRoboto,
    fontWeight: FontWeight.w600);

TextStyle styleMediumRegular = TextStyle(
    fontSize: fMedium1,
    color: white,
    fontFamily: fontFamilyRoboto,
    fontWeight: FontWeight.normal);

TextStyle fMedium1NormalTextColor = TextStyle(
    fontSize: fMedium1,
    color: themeOf().textPrimaryColor,
    fontFamily: fontFamilyRoboto,
    fontWeight: FontWeight.normal);

TextStyle styleMediumMedium = TextStyle(
    fontSize: fMedium1,
    color: themeOf().accentColor,
    fontFamily: fontFamilyRoboto,
    fontWeight: FontWeight.w500);

TextStyle styleMedium1Bold = TextStyle(
    fontSize: fMedium1,
    color: black,
    fontFamily: fontFamilyRoboto,
    fontWeight: FontWeight.bold);

TextStyle styleMedium2 =
    TextStyle(fontSize: fMedium2, color: black, fontFamily: fontFamilyRoboto);

TextStyle styleMedium2RegularGray = TextStyle(
    fontSize: fMedium2,
    color: gray75Color,
    fontFamily: fontFamilyRoboto,
    fontWeight: FontWeight.normal);

TextStyle styleMedium2Bold = TextStyle(
    fontSize: fMedium2,
    color: black,
    fontFamily: fontFamilyRoboto,
    fontWeight: FontWeight.bold);

TextStyle styleMedium3 =
    TextStyle(fontSize: fMedium3, color: black, fontFamily: fontFamilyRoboto);

TextStyle styleMedium3Bold = TextStyle(
    fontSize: fMedium3,
    color: black,
    fontFamily: fontFamilyRoboto,
    fontWeight: FontWeight.bold);

TextStyle styleMedium4 =
    TextStyle(fontSize: fMedium4, color: black, fontFamily: fontFamilyRoboto);

TextStyle styleMedium4Bold = TextStyle(
    fontSize: fMedium4,
    color: black,
    fontFamily: fontFamilyRoboto,
    fontWeight: FontWeight.bold);

/// Large
TextStyle styleLarge1 =
    TextStyle(fontSize: fLarge1, color: black, fontFamily: fontFamilyRoboto);

TextStyle styleLarge1Bold = TextStyle(
    fontSize: fLarge1,
    color: black,
    fontFamily: fontFamilyRoboto,
    fontWeight: FontWeight.bold);

TextStyle styleLarge2 =
    TextStyle(fontSize: fLarge2, color: black, fontFamily: fontFamilyRoboto);

TextStyle styleLarge2Bold = TextStyle(
    fontSize: fLarge2,
    color: black,
    fontFamily: fontFamilyRoboto,
    fontWeight: FontWeight.bold);

TextStyle styleLarge3 =
    TextStyle(fontSize: fLarge3, color: black, fontFamily: fontFamilyRoboto);

TextStyle styleLarge3Bold = TextStyle(
    fontSize: fLarge3,
    color: black,
    fontFamily: fontFamilyRoboto,
    fontWeight: FontWeight.bold);

TextStyle styleLarge4 =
    TextStyle(fontSize: fLarge4, color: black, fontFamily: fontFamilyRoboto);

TextStyle styleLarge4Bold = TextStyle(
    fontSize: fLarge4,
    color: black,
    fontFamily: fontFamilyRoboto,
    fontWeight: FontWeight.bold);

TextStyle styleLarge5 =
    TextStyle(fontSize: fLarge5, color: black, fontFamily: fontFamilyRoboto);

TextStyle styleLarge5Bold = TextStyle(
    fontSize: fLarge5,
    color: black,
    fontFamily: fontFamilyRoboto,
    fontWeight: FontWeight.bold);

TextStyle styleLarge6 =
    TextStyle(fontSize: fLarge6, color: black, fontFamily: fontFamilyRoboto);

TextStyle styleLarge6Bold = TextStyle(
    fontSize: fLarge6,
    color: black,
    fontFamily: fontFamilyRoboto,
    fontWeight: FontWeight.bold);

TextStyle styleLarge7 =
    TextStyle(fontSize: fLarge7, color: black, fontFamily: fontFamilyRoboto);

TextStyle styleLarge7Bold = TextStyle(
    fontSize: fLarge7,
    color: black,
    fontFamily: fontFamilyRoboto,
    fontWeight: FontWeight.bold);

TextStyle styleLarge8 =
    TextStyle(fontSize: fLarge8, color: black, fontFamily: fontFamilyRoboto);

TextStyle styleLarge8Bold = TextStyle(
    fontSize: fLarge8,
    color: black,
    fontFamily: fontFamilyRoboto,
    fontWeight: FontWeight.bold);
