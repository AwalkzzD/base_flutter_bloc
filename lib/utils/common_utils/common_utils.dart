import 'dart:convert';
import 'dart:io';

import 'package:base_flutter_bloc/utils/common_utils/app_widgets.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;

extension Unique<E, Id> on List<E> {
  List<E> unique([Id Function(E element)? id, bool inplace = true]) {
    final ids = Set();
    var list = inplace ? this : List<E>.from(this);
    list.retainWhere((x) => ids.add(id != null ? id(x) : x as Id));
    return list;
  }
}

typedef OnItemTap<T> = void Function(BuildContext context, T? data, int? index);

extension IndexedIterable<E> on Iterable<E> {
  Iterable<T> mapIndexed<T>(T Function(E e, int i) f) {
    var i = 0;
    return map((e) => f(e, i++));
  }
}

String string(String key, [dynamic args]) {
  return globalContext.tr(key, namedArgs: args);
}

Future<String> networkImageToBase64(String imageUrl) async {
  http.Response response = await http.get(Uri.parse(imageUrl));
  final bytes = response.bodyBytes;
  return base64Encode(bytes);
}

Uint8List getUint8List(String path) {
  File file = File(path);
  return file.readAsBytesSync();
}

String getBase64FromUint8List(Uint8List bytes) {
  return base64Encode(bytes);
}

String getBase64File(String path) {
  Uint8List bytes = getUint8List(path);
  return getBase64FromUint8List(bytes);
}

extension Ex on double {
  double toPrecision(int n) => double.parse(toStringAsFixed(n));
}

Future<void> closeApp() async {
  if (Platform.isIOS) {
    try {
      SystemNavigator.pop(animated: true);
    } catch (e) {
      exit(0);
    }
  } else {
    try {
      SystemNavigator.pop();
    } catch (e) {
      exit(0);
    }
  }
}

bool isTablet() {
  var shortestSide = MediaQuery.of(globalContext).size.shortestSide;
  return shortestSide < 600 ? false : true;
}
