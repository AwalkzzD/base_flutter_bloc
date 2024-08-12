import 'dart:math' show max, pi;

import 'package:base_flutter_bloc/utils/bottom_nav_bar/bottom_clipper_plain.dart';
import 'package:base_flutter_bloc/utils/bottom_nav_bar/r_nav_item.dart';
import 'package:base_flutter_bloc/utils/bottom_nav_bar/sheetToggleButton.dart';
import 'package:base_flutter_bloc/utils/common_utils/common_utils.dart';
import 'package:base_flutter_bloc/utils/constants/app_colors.dart';
import 'package:base_flutter_bloc/utils/constants/app_images.dart';
import 'package:base_flutter_bloc/utils/constants/app_size.dart';
import 'package:base_flutter_bloc/utils/constants/app_theme.dart';
import 'package:base_flutter_bloc/utils/screen_utils/flutter_screen_util.dart';
import 'package:flutter/material.dart';

/// Animated, modern and highly customisable [BottomNavigationBar]
class RNavNSheet extends StatefulWidget {
  /// List of [RNavItem] (bottom navigation items)
  final List<RNavItem> items;

  /// [Function] callback that returns index of selected [RNavItem]
  final void Function(int index)? onTap;

  /// Index of default selected item
  final int? initialSelectedIndex;

  /// Bottom sheet to be displayed on dock icon click
  final Widget? sheet;

  /// Angle (in radians) to rotate toggle button when sheet is open
  final double? sheetIconRotateAngle;

  /// [List] of [Color] for border over [RNavNSheet] ([Gradient] from left to right)
  final List<Color>? borderColors;

  /// Background [Color] of [RNavNSheet]
  final Color? backgroundColor;

  /// Background [Gradient] of [RNavNSheet]
  final Gradient? backgroundGradient;

  /// [Color] of selected nav item
  final Color? selectedItemColor;

  /// [Color] of unselected nav item
  final Color? unselectedItemColor;

  /// [Gradient] of selected [RNavItem]
  final Gradient? selectedItemGradient;

  /// [Gradient] of unselected [RNavItem]
  final Gradient? unselectedItemGradient;

  /// [Function] callback that returns ```true``` if sheet is open
  /// and ```false``` if sheet is closed
  final void Function(bool value)? onSheetToggle;

  const RNavNSheet({
    Key? key,
    required this.items,
    this.onTap,
    this.initialSelectedIndex,
    this.sheet,
    this.borderColors,
    this.backgroundColor,
    this.backgroundGradient,
    this.onSheetToggle,
    this.sheetIconRotateAngle,
    this.selectedItemColor,
    this.unselectedItemColor,
    this.selectedItemGradient,
    this.unselectedItemGradient,
  })  : assert(items.length >= 2 && items.length <= 5,
            "There must be at least 2 and at most 5 items!"),
        assert(
          (items.length % 2 == 0 && sheet != null) || sheet == null,
          "Please add either 2 or 4 items with sheet!",
        ),
        super(key: key);

  @override
  State<RNavNSheet> createState() => _RNavNSheetState();
}

class _RNavNSheetState extends State<RNavNSheet>
    with SingleTickerProviderStateMixin {
  int? _selectedIndex;
  late AnimationController _animationController;
  late double _animValue = 0.0;
  bool _sheetOpen = false;

  PersistentBottomSheetController? _bottomSheetController;

  GlobalKey<ScaffoldState> key = GlobalKey<ScaffoldState>();

  _onSheetToggle(bool value) {
    setState(() {
      _sheetOpen = value;
    });
    if (widget.onSheetToggle != null) widget.onSheetToggle!(value);
  }

  _showBottomSheet() {
    if (_sheetOpen) {
      Scaffold.of(context).showBodyScrim(false, 0.0);
      _bottomSheetController?.close();
      return;
    }
    _onSheetToggle(true);
    _animationController.reset();
    _animationController.animateTo(1.0);

    _bottomSheetController =
        Scaffold.of(context).showBottomSheet((BuildContext context) {
      return Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: () {},
          child: Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            color: disableBgColor.withOpacity(0.5),
            child: SizedBox(
              width: MediaQuery.of(context).size.width,
              height: homeScreenBottomSheetHeight,
              child: Stack(
                children: [
                  Transform.translate(
                    offset: Offset(0, 480.h),
                    child: widget.sheet!,
                  ),
                ],
              ),
            ),
          ),
        ),
      );
    },
            constraints: BoxConstraints(
              maxWidth: MediaQuery.of(context).size.width,
            ),
            backgroundColor: Colors.transparent,
            transitionAnimationController: _animationController,
            enableDrag: false)
          ..closed.whenComplete(() {
            _animationController.animateBack(0.0).then((value) {
              _onSheetToggle(false);
            });
          });
  }

  _initAnimation() {
    _animationController = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 300));
    _animationController.addListener(() {
      setState(() {
        _animValue = _animationController.value;
      });
    });
  }

  @override
  void initState() {
    _initAnimation();
    _selectedIndex = widget.initialSelectedIndex;
    super.initState();
  }

  @override
  void didUpdateWidget(RNavNSheet oldWidget) {
    super.didUpdateWidget(oldWidget);
    _selectedIndex = widget.initialSelectedIndex;
  }

  List<double> get padding => widget.items.length == 2
      ? [35.0, 35.0]
      : widget.items.length == 3
          ? [35.0, 25.0, 35.0]
          : widget.items.length == 4
              ? [35.0, 30.0, 30.0, 35.0]
              : [35.0, 30.0, 25.0, 30.0, 35.0];

  @override
  Widget build(BuildContext context) {
    List<RNavItem> itemsInner = widget.items;
    var theme = Theme.of(context);
    var items = <Widget>[];

    for (var item in itemsInner) {
      var i = itemsInner.indexOf(item);
      items.add(Expanded(
        child: RNavItemInner(
          iconPath: item.iconPath,
          iconDisablePath: item.iconDisablePath,
          hide: _sheetOpen,
          selectedItemColor: widget.selectedItemColor,
          unselectedItemColor: widget.unselectedItemColor,
          selectedItemGradient: widget.selectedItemGradient,
          unselectedItemGradient: widget.unselectedItemGradient,
          padding: EdgeInsets.only(top: padding[i]),
          selected: _selectedIndex == i,
          onTap: () {
            if (widget.onTap != null) {
              widget.onTap!(i);
              setState(() {
                _selectedIndex = i;
              });
            }
          },
        ),
      ));
    }

    var fab = Expanded(
      child: Transform.rotate(
        angle: _animValue * (pi / 180) * (widget.sheetIconRotateAngle ?? 90.0),
        child: SheetToggleButton(
          onTap: () => _showBottomSheet(),
          imagePath: _sheetOpen
              ? AppImages.icCloseBottomSheet
              : AppImages.icOpenBottomSheet,
        ),
      ),
    );

    if (widget.sheet != null) {
      if (itemsInner.length == 2) {
        items.insert(1, fab);
      } else if (itemsInner.length == 4) {
        items.insert(2, fab);
      }
    }

    /// changes both bg [open/ close]of drawer
    var bgColor = widget.backgroundColor ?? theme.canvasColor;
    CustomClipper<Path> clipper = BottomClipperPlain();

    if (widget.sheet != null) {
      clipper = BottomClipper(
        value: max(8, _animValue * 28),
      );
    }

    return SizedBox(
      height: isTablet() ? kAppBottomBarHeight.h : kAppBottomBarHeight,
      child: Stack(
        children: [
          ClipPath(
            clipper: (_sheetOpen) ? clipper : null,
            child: Container(
              padding: const EdgeInsets.only(top: 5),
              child: AnimatedContainer(
                decoration: BoxDecoration(
                  color: (_sheetOpen) ? bgColor : themeOf().bottomBarColor,
                  gradient: (_sheetOpen) ? widget.backgroundGradient : null,
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(20), // Adjust the radius as needed
                    topRight:
                        Radius.circular(20), // Adjust the radius as needed
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: themeOf().bottomBarShadowColor,
                      blurRadius: 25,
                      spreadRadius: 4,
                      offset: const Offset(0, 10),
                    ),
                  ],
                ),
                height:
                    isTablet() ? kAppBottomBarHeight.h : kAppBottomBarHeight,
                duration: const Duration(milliseconds: 250),
                child: Material(
                  color: Colors.transparent,
                  child: Row(
                    children: items,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
