import 'package:base_flutter_bloc/utils/screen_utils/flutter_screen_util.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';

import '../common_utils/common_utils.dart';
import '../constants/app_images.dart';
import '../constants/app_styles.dart';
import '../constants/app_theme.dart';
import '../widgets/divider_widget.dart';
import '../widgets/image_view.dart';

class CustomDropdown<T> extends StatefulWidget {
  final String hint;
  final List<T> items;
  final T? initialValue;
  final InputDecoration? decoration;
  final Function(T?) onClick;
  final bool isDisable;
  final bool isExpanded;
  final bool isDense;
  final ButtonStyleData? buttonStyleData;
  final DropdownStyleData? dropdownStyleData;
  final MenuItemStyleData? menuItemStyleData;
  final IconStyleData? iconStyleData;
  final TextStyle? textStyle;
  final TextStyle? hintStyle;
  final TextStyle? dropDownTextStyle;
  final bool showDivider;
  final bool showUnderline;
  final int maxLines;

  const CustomDropdown(
      {Key? key,
      required this.hint,
      required this.items,
      this.decoration,
      this.isDisable = false,
      this.isExpanded = true,
      this.isDense = false,
      this.buttonStyleData,
      this.dropdownStyleData,
      this.menuItemStyleData,
      this.iconStyleData,
      this.textStyle,
      this.hintStyle,
      this.dropDownTextStyle,
      required this.onClick,
      this.initialValue,
      this.showDivider = false,
      this.showUnderline = false,
      this.maxLines = 2})
      : super(key: key);

  @override
  State<CustomDropdown<T>> createState() => _CustomDropdownState<T>();
}

class _CustomDropdownState<T> extends State<CustomDropdown<T>> {
  final valueListenable = ValueNotifier<T?>(null);
  double menuHeight = 48.h;

  void calculateMenuHeight() {
    var list = widget.items.map((item) {
      return item.toString();
    }).toList();
    var maxLine = maxNumberOfLines(list, 20);
    menuHeight = maxLine > 1 ? 60.h : 48.h;
  }

  int maxNumberOfLines(List<String> strings, int charsPerLine) {
    int maxLines = 0;

    for (String text in strings) {
      int numberOfLines = (text.length / charsPerLine).ceil();
      if (numberOfLines > maxLines) {
        maxLines = numberOfLines;
      }
    }

    return maxLines;
  }

  @override
  void initState() {
    calculateMenuHeight();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    if (widget.showUnderline) {
      return buildDropDown();
    } else {
      return DropdownButtonHideUnderline(
        child: buildDropDown(),
      );
    }
  }

  Widget buildDropDown() {
    return DropdownButtonFormField2<T>(
      isExpanded: widget.isExpanded,
      decoration: const InputDecoration(
        contentPadding: EdgeInsets.all(0),
        border: InputBorder.none,
      ),
      isDense: widget.isDense,
      value: widget.initialValue,
      style: widget.textStyle,
      alignment: AlignmentDirectional.centerStart,
      hint: Text(
        widget.hint,
        style: widget.hintStyle ??
            styleSmall4.copyWith(color: themeOf().dropdownHintColor),
      ),
      items: widget.items.map((item) {
        return DropdownMenuItem<T>(
          key: UniqueKey(),
          value: item,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                item.toString(),
                maxLines: widget.maxLines,
                overflow: TextOverflow.ellipsis,
                style: widget.dropDownTextStyle ??
                    styleSmall4.copyWith(color: themeOf().textPrimaryColor),
              ),
              if (widget.showDivider) ...[
                SizedBox(
                  height: 6.h,
                ),
                const DividerWidget(
                  verticalMargin: 0,
                )
              ]
            ],
          ),
        );
      }).toList(),
      onChanged: widget.isDisable
          ? null
          : (value) {
              widget.onClick.call(value);
            },
      buttonStyleData: widget.buttonStyleData ??
          ButtonStyleData(
            padding: EdgeInsetsDirectional.only(end: 12.h),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              border: Border.all(
                color: themeOf().dropdownBorderColor,
              ),
              color: widget.isDisable
                  ? themeOf().textFieldBorderColor
                  : themeOf().dropdownBgColor,
            ),
          ),
      iconStyleData: widget.iconStyleData ??
          IconStyleData(
            icon: ImageView(
                image: AppImages.icDropDown,
                imageType: ImageType.svg,
                width: 10.h,
                height: 6.h,
                color: themeOf().iconColor),
          ),
      dropdownStyleData: widget.dropdownStyleData ??
          DropdownStyleData(
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: themeOf().dropdownBgColor),
          ),
      menuItemStyleData: widget.menuItemStyleData ??
          MenuItemStyleData(
            height: isTablet() ? 44.h : 48.h,
            padding: EdgeInsetsDirectional.symmetric(horizontal: 16.h),
            //height: menuHeight,
          ),
    );
  }
}
