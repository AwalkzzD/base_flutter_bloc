import 'package:base_flutter_bloc/utils/common_utils/shared_pref.dart';

extension StringFuncs on String {
  String trimCharLeft(String pattern) {
    if (isEmpty || pattern.isEmpty || pattern.length > length) return this;
    var tmp = this;
    while (tmp.startsWith(pattern)) {
      tmp = substring(pattern.length);
    }
    return tmp;
  }

  String trimCharRight(String pattern) {
    if (isEmpty || pattern.isEmpty || pattern.length > length) return this;
    var tmp = this;
    while (tmp.endsWith(pattern)) {
      tmp = substring(0, length - pattern.length);
    }
    return tmp;
  }

  String trimChar(String pattern) {
    return trimCharLeft(pattern).trimCharRight(pattern);
  }
}

String removeHtmlTags(String input) {
  final RegExp regex = RegExp(r'<.*?>');
  return input.replaceAll(regex, '');
}

String getFullName(String? firstname, String? lastname) {
  if (getNameSetting()) {
    return "$lastname $firstname";
  } else {
    return "$firstname $lastname";
  }
}
