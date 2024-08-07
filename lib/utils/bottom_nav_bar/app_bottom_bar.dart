import 'package:base_flutter_bloc/bloc/app_bloc.dart';
import 'package:base_flutter_bloc/remote/repository/settings/response/mobile_license_menu.dart';
import 'package:base_flutter_bloc/utils/bottom_nav_bar/fab_bottom_sheet.dart';
import 'package:base_flutter_bloc/utils/bottom_nav_bar/r_nav_item.dart';
import 'package:base_flutter_bloc/utils/bottom_nav_bar/r_nav_n_sheet.dart';
import 'package:base_flutter_bloc/utils/common_utils/app_widgets.dart';
import 'package:base_flutter_bloc/utils/constants/app_images.dart';
import 'package:base_flutter_bloc/utils/constants/app_theme.dart';
import 'package:base_flutter_bloc/utils/dropdown/dropdown_option_model.dart';
import 'package:base_flutter_bloc/utils/stream_helper/menu_utils.dart';
import 'package:base_flutter_bloc/utils/widgets/common_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AppBottomBar extends StatefulWidget {
  final Function(int) onTabSelected;
  final Function(DropDownOptionModel, int) onMenuClick;
  final List<RNavItem> navTabs;
  final int initialSelectedIndex;
  final bool isUserTeacher;
  final bool isUserOther;

  const AppBottomBar(
      {super.key,
      required this.initialSelectedIndex,
      required this.navTabs,
      required this.onMenuClick,
      required this.onTabSelected,
      required this.isUserTeacher,
      required this.isUserOther});

  @override
  State<AppBottomBar> createState() => _AppBottomBarState();
}

class _AppBottomBarState extends State<AppBottomBar> {
  final MenuUtils menuUtils = MenuUtils();

  List<DropDownOptionModel> teacherMenus() {
    List<DropDownOptionModel> menus = [];
    if (menuUtils.isMessageMenu()) {
      menus.add(DropDownOptionModel(
          key: AppImages.icNewMessage, value: 'New Message'));
    }
    return menus;
  }

  List<DropDownOptionModel> studentMenus() {
    List<DropDownOptionModel> menus = [];
    if (menuUtils.isMessageMenu()) {
      menus.add(DropDownOptionModel(
          key: AppImages.icNewMessage, value: 'New Message'));
    }
    if (menuUtils.isAttendanceIntentionMenu()) {
      menus.add(DropDownOptionModel(
          key: AppImages.icApplyLeave, value: 'Apply for leave'));
    }
    return menus;
  }

  @override
  Widget build(BuildContext context) {
    return RNavNSheet(
      onTap: (index) {
        /*setState(() {
          widget.initialSelectedIndex = index;
        });
        Future.delayed(const Duration(seconds: 1), () {
          setState(() {
            _index = index;
          });
        });*/
        widget.onTabSelected(index);
      },
      initialSelectedIndex: widget.initialSelectedIndex,
      sheet: buildPopUpSheet(),
      backgroundGradient: getCommonGradient(),
      backgroundColor: themeOf().bottomBarColor,
      onSheetToggle: (v) {
        setState(() {
          //_open = v;
        });
      },
      items: widget.navTabs,
    );
  }

  Widget? buildPopUpSheet() {
    if (widget.isUserOther) {
      return null;
    } else {
      AppBloc? appBloc = BlocProvider.of<AppBloc>(globalContext);
      return StreamBuilder<MobileLicenseMenuResponse?>(
          stream: appBloc.mobileMenu,
          builder: (context, snapshot) {
            return menuList().isEmpty
                ? const SizedBox()
                : FabBottomSheet(
                    onClick: widget.onMenuClick, menus: menuList());
          });
    }
  }

  List<DropDownOptionModel> menuList() {
    if (widget.isUserOther) {
      return [];
    } else {
      return widget.isUserTeacher == true ? teacherMenus() : studentMenus();
    }
  }
}
