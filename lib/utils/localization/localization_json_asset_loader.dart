import 'dart:convert';
import 'dart:ui';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/services.dart';

class LocalizationJsonAssetLoader extends AssetLoader {
  const LocalizationJsonAssetLoader();

  String getLocalePath(String basePath, Locale locale) {
    String language = locale.toStringWithSeparator(separator: "-");
    if(language=="en-GB"){
      return '$basePath/MobileResources.json';
    }else{
      return '$basePath/MobileResources.$language.json';
    }
  }

  @override
  Future<Map<String, dynamic>> load(String path, Locale locale) async {
    var localePath = getLocalePath(path, locale);
    return jsonDecode(await rootBundle.loadString(localePath));
  }
}

// Loader for single json file
class JsonSingleAssetLoader extends AssetLoader {
  Map? jsonData;

  @override
  Future<Map<String, dynamic>> load(String path, Locale locale) async {
    jsonData ??= jsonDecode(await rootBundle.loadString(path));
    return jsonData![locale.toString()];
  }
}