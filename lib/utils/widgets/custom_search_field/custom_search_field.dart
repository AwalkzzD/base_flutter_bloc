import 'dart:async';

import 'package:base_flutter_bloc/utils/screen_utils/flutter_screen_util.dart';
import 'package:flutter/material.dart';

import '../../common_utils/common_utils.dart';
import '../../constants/app_styles.dart';
import '../../constants/app_theme.dart';

class CustomSearchField extends StatefulWidget {
  final TextEditingController controller;
  final FocusNode focusNode;
  final Function(String) onSearch;
  final Function()? onCancel;

  const CustomSearchField(
      {required this.controller,
      required this.focusNode,
      required this.onSearch,
      this.onCancel,
      super.key});

  @override
  State<CustomSearchField> createState() => _CustomSearchFieldState();
}

class _CustomSearchFieldState extends State<CustomSearchField> {
  Timer? _timer;
  final Duration _duration = const Duration(milliseconds: 500);

  runDebouncer(String text) {
    _timer?.cancel();
    if (text.isNotEmpty) {
      _timer = Timer(_duration, () => widget.onSearch(text));
    } else {
      widget.onSearch(text);
    }
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: widget.controller,
      focusNode: widget.focusNode,
      keyboardType: TextInputType.text,
      textInputAction: TextInputAction.search,
      onChanged: (value) => runDebouncer(value.trim()),
      style: TextStyle(
          fontSize: 14.sp,
          fontFamily: fontFamilyPoppins,
          fontWeight: FontWeight.normal,
          color: themeOf().textPrimaryColor),
      decoration: InputDecoration(
        fillColor: themeOf().textFieldBgColor,
        filled: true,
        border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide(color: themeOf().textFieldHeaderColor)),
        focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide(color: themeOf().accentColor)),
        contentPadding: EdgeInsetsDirectional.all(12.h),
        hintText: string("common_labels.label_search"),
        hintStyle: TextStyle(
            fontSize: 14.sp,
            fontFamily: fontFamilyPoppins,
            fontWeight: FontWeight.normal,
            color: themeOf().textPrimaryColor),
        suffix: widget.onCancel == null
            ? const SizedBox()
            : GestureDetector(
                onTap: widget.onCancel,
                child: Text(
                  string("common_labels.label_cancel"),
                  style: TextStyle(
                      fontSize: 12.sp,
                      fontFamily: fontFamilyPoppins,
                      fontWeight: FontWeight.normal,
                      color: themeOf().textSecondaryColor),
                ),
              ),
      ),
    );
  }
}
