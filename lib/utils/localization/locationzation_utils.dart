import 'package:base_flutter_bloc/utils/common_utils/app_widgets.dart';
import 'package:base_flutter_bloc/utils/common_utils/shared_pref.dart';
import 'package:base_flutter_bloc/utils/localization/language_model.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

List<LanguageModel> getDefaultLanguageList() {
  return [
    LanguageModel(
      id: 1,
      languageTitle: "English (en-UK)",
      languageCode: "en-GB",
      isSelected: false,
      isRTL: false,
    ),
    LanguageModel(
      id: 2,
      languageTitle: "English (en-US)",
      languageCode: "en-US",
      isSelected: false,
      isRTL: false,
    ),
    LanguageModel(
      id: 3,
      languageTitle: "Ελληνικά (el-GR)",
      languageCode: "el-GR",
      isSelected: false,
      isRTL: false,
    ),
    LanguageModel(
      id: 4,
      languageTitle: "Deutsch (de-DE)",
      languageCode: "de-DE",
      isSelected: false,
      isRTL: false,
    ),
    LanguageModel(
      id: 5,
      languageTitle: "Español (es-ES)",
      languageCode: "es-ES",
      isSelected: false,
      isRTL: false,
    ),
    LanguageModel(
      id: 6,
      languageTitle: "Български (bg-BG)",
      languageCode: "bg-BG",
      isSelected: false,
      isRTL: false,
    ),
    LanguageModel(
      id: 7,
      languageTitle: "Arabic (ar-EG)",
      languageCode: "ar-EG",
      isSelected: false,
      isRTL: true,
    ),
  ];
}

List<Locale> getSupportedLocales() {
  return [
    const Locale('en', 'GB'),
    const Locale('en', 'US'),
    const Locale('el', 'GR'),
    const Locale('de', 'DE'),
    const Locale('es', 'ES'),
    const Locale('bg', 'BG'),
    const Locale('ar', 'EG'),
    // Add more locales as needed
  ];
}

void changeLanguage(String code) {
  saveLanguage(code);
  globalContext.setLocale(getLanguageLocale(code));
}

Locale getLanguageLocale(String code) {
  List<String> codeParts = code.split('-');
  String languageCode = codeParts.isNotEmpty ? codeParts[0] : 'en';
  String countryCode = codeParts.length > 1 ? codeParts[1] : 'GB';
  return Locale(languageCode, countryCode);
}

Locale getDefaultLocale() {
  return const Locale('en', 'GB');
}
