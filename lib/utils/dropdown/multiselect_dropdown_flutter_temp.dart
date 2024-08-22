import 'package:base_flutter_bloc/utils/screen_utils/flutter_screen_util.dart';
import 'package:flutter/material.dart';
import 'package:rxdart/rxdart.dart';

import '../common_utils/common_utils.dart';
import '../constants/app_colors.dart';
import '../constants/app_images.dart';
import '../constants/app_styles.dart';
import '../constants/app_theme.dart';
import '../widgets/image_view.dart';
import 'chip_config.dart';

const double tileHeight = 50;

class MultiSelectDropdownTemp<T> extends StatefulWidget {
  final List<T> list;
  final ValueChanged<List<T>> onChange;
  final List<T> initiallySelected;
  final Decoration? boxDecoration;
  final double? width;
  final String hint;
  final TextStyle textStyle;
  final EdgeInsets? padding;
  final String Function(T) itemLabelSelector;
  final ChipConfig? chipConfig;

  const MultiSelectDropdownTemp(
      {super.key,
      required this.list,
      required this.onChange,
      required this.initiallySelected,
      this.boxDecoration,
      this.width,
      this.hint = 'Select options',
      this.textStyle = const TextStyle(fontSize: 15),
      this.padding,
      required this.itemLabelSelector,
      this.chipConfig});

  @override
  State<MultiSelectDropdownTemp<T>> createState() =>
      _MultiSelectDropdownStateTemp<T>();
}

class _MultiSelectDropdownStateTemp<T>
    extends State<MultiSelectDropdownTemp<T>> {
  late final BehaviorSubject<List<T>> selected =
      BehaviorSubject.seeded([...widget.initiallySelected]);

  late final BehaviorSubject<List<T>> filteredOptions =
      BehaviorSubject.seeded([...widget.list]);

  final ScrollController _controller = ScrollController();

  late MenuController menuController;

  late ChipConfig chipConfig = widget.chipConfig ??
      ChipConfig(
        padding: EdgeInsetsDirectional.only(start: 8.h),
        backgroundColor: themeOf().fieldBgColor,
        wrapType: WrapType.wrap,
        deleteIcon: Icon(Icons.cancel,
            size: 16.h,
            color: themeOf().lightMode()
                ? themeOf().accentColor
                : themeOf().textSecondaryColor),
        labelPadding: EdgeInsetsDirectional.zero,
        radius: 8,
        runSpacing: 0.w,
        labelStyle:
            styleSmall3Medium.copyWith(color: themeOf().textSecondaryColor),
      );

  @override
  void initState() {
    super.initState();
    menuController = MenuController();
  }

  @override
  void dispose() {
    selected.close();
    filteredOptions.close();
    _controller.dispose();
    super.dispose();
  }

  @override
  void didUpdateWidget(covariant MultiSelectDropdownTemp<T> oldWidget) {
    if (widget.initiallySelected != oldWidget.initiallySelected) {
      selected.add([...widget.initiallySelected]);
    }
    if (widget.list != oldWidget.list) {
      filteredOptions.add([...widget.list]);
    }
    super.didUpdateWidget(oldWidget);
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (ctx, boxConstraints) {
        double modalWidth = getWidth(boxConstraints);
        return StreamBuilder<List<T>>(
          stream: selected.stream,
          builder: (context, snapshot) {
            final List<T> textToShow = buildText();
            double modalHeight = getModalHeight();

            return ConstrainedBox(
              constraints: BoxConstraints(
                  minHeight: isTablet() ? 44.h : 50.h, maxHeight: 200.h),
              child: MenuAnchor(
                crossAxisUnconstrained: false,
                style: MenuStyle(
                  backgroundColor:
                      MaterialStateProperty.all(themeOf().dropdownBgColor),
                  surfaceTintColor: MaterialStateProperty.all(white),
                  fixedSize: MaterialStateProperty.resolveWith((states) {
                    return Size(modalWidth, modalHeight);
                  }),
                  padding: MaterialStateProperty.resolveWith((states) {
                    return EdgeInsets.zero;
                  }),
                ),
                builder: (context, controller, _) {
                  menuController = controller;
                  return InkWell(
                    onTap: () {
                      if (controller.isOpen) {
                        controller.close();
                      } else {
                        controller.open();
                      }
                    },
                    child: Container(
                      decoration: widget.boxDecoration ??
                          BoxDecoration(
                            border: Border.all(
                                color: themeOf().dropdownBorderColor),
                            borderRadius: BorderRadius.circular(10),
                          ),
                      width: modalWidth,
                      child: Row(
                        children: [
                          Expanded(
                            child: textToShow.isNotEmpty
                                ? SingleChildScrollView(
                                    controller: _controller,
                                    scrollDirection: Axis.vertical,
                                    child: Padding(
                                      padding: EdgeInsetsDirectional.only(
                                          start: 8.h, bottom: 8.h),
                                      child: Wrap(
                                        spacing: 0,
                                        children: textToShow.map((option) {
                                          return Padding(
                                            padding: EdgeInsetsDirectional.only(
                                                top: 8.h, end: 8.h),
                                            child: Chip(
                                              materialTapTargetSize:
                                                  MaterialTapTargetSize
                                                      .shrinkWrap,
                                              padding: chipConfig.padding,
                                              label: Text(widget
                                                  .itemLabelSelector(option)
                                                  .toString()),
                                              shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(
                                                        chipConfig.radius),
                                              ),
                                              deleteIcon: chipConfig.deleteIcon,
                                              deleteIconColor:
                                                  chipConfig.deleteIconColor,
                                              labelPadding:
                                                  chipConfig.labelPadding,
                                              backgroundColor:
                                                  chipConfig.backgroundColor,
                                              labelStyle: chipConfig.labelStyle,
                                              onDeleted: () {
                                                handleOnChange(false, option);
                                              },
                                            ),
                                          );
                                        }).toList(),
                                      ),
                                    ),
                                  )
                                : Padding(
                                    padding: EdgeInsetsDirectional.only(
                                        start: 14.h, end: 8.h),
                                    child: Text(
                                      widget.hint,
                                      style: styleSmall4.copyWith(
                                          color: themeOf().dropdownHintColor),
                                    ),
                                  ),
                          ),
                          Container(
                            padding: EdgeInsetsDirectional.only(end: 12.h),
                            child: ImageView(
                                image: AppImages.icDropDown,
                                imageType: ImageType.svg,
                                width: 10.h,
                                height: 6.h,
                                color: themeOf().iconColor),
                          ),
                        ],
                      ),
                    ),
                  );
                },
                menuChildren: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.max,
                    children: filteredOptions.value.map((data) {
                      return buildTile(data);
                    }).toList(),
                  ),
                  SizedBox(
                    height: 8.h,
                  )
                ],
              ),
            );
          },
        );
      },
    );
  }

  double getWidth(BoxConstraints boxConstraints) {
    if (widget.width != null &&
        widget.width != double.infinity &&
        widget.width != double.maxFinite) {
      return widget.width!;
    }
    if (boxConstraints.maxWidth == double.infinity ||
        boxConstraints.maxWidth == double.maxFinite) {
      return 250.h;
    }
    return boxConstraints.maxWidth;
  }

  double getModalHeight() {
    double height = filteredOptions.value.length * 40.h;
    return height > 300.h ? 300.h : height;
  }

  List<T> buildText() {
    if (selected.value.isEmpty) {
      return [];
    }
    return List<T>.from(selected.value);
  }

  void handleOnChange(bool newValue, T data) {
    if (newValue) {
      var temp = selected.value;
      temp.add(data);
      selected.value = temp;
    } else {
      if (selected.value.contains(data)) {
        var temp = selected.value;
        temp.remove(data);
        selected.value = temp;
      }
    }

    if (menuController.isOpen) {
      // menuController.close();
    }

    if (selected.value.length > 2) {
      _controller.animateTo(
        _controller.position.maxScrollExtent,
        duration: const Duration(milliseconds: 100),
        curve: Curves.easeInOut,
      );
    }

    widget.onChange(selected.value);
  }

  Widget buildTile(T data) {
    return _CustomTile(
      value: isSelected(data),
      onChanged: (bool newValue) {
        handleOnChange(newValue, data);
      },
      title: widget.itemLabelSelector(data).toString(),
    );
  }

  bool isSelected(T data) {
    final Set<String> selectedList = selected.value
        .map<String>((option) => widget.itemLabelSelector(option))
        .toSet();

    return selectedList.contains(widget.itemLabelSelector(data));
  }
}

class _CustomTile extends StatelessWidget {
  const _CustomTile({
    required this.title,
    required this.value,
    required this.onChanged,
  });

  final String title;
  final bool value;
  final ValueChanged<bool> onChanged;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        onChanged(!value);
      },
      child: Container(
        padding: EdgeInsetsDirectional.only(
            start: 6.h, top: 12.h, bottom: 6.h, end: 6.h),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(width: 6.w),
            value
                ? ImageView(
                    image: AppImages.icCheckBoxChecked,
                    imageType: ImageType.svg,
                    height: 18.h,
                    width: 18.h,
                  )
                : ImageView(
                    image: AppImages.icCheckBoxUnChecked,
                    imageType: ImageType.svg,
                    height: 18.h,
                    width: 18.h,
                    color: themeOf().iconColor,
                  ),
            SizedBox(width: 6.w),
            Expanded(
              child: Text(
                title,
                style: styleSmall4Medium.copyWith(
                    color: themeOf().textPrimaryColor),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
