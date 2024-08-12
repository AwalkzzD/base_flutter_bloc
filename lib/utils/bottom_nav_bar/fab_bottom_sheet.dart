import 'package:base_flutter_bloc/utils/common_utils/app_widgets.dart';
import 'package:base_flutter_bloc/utils/constants/app_images.dart';
import 'package:base_flutter_bloc/utils/constants/app_theme.dart';
import 'package:base_flutter_bloc/utils/dropdown/dropdown_option_model.dart';
import 'package:base_flutter_bloc/utils/screen_utils/flutter_screen_util.dart';
import 'package:base_flutter_bloc/utils/widgets/content_area_widget.dart';
import 'package:flutter/material.dart';

class FabBottomSheet extends StatefulWidget {
  const FabBottomSheet({
    super.key,
    required this.onClick,
    this.menus = const [],
  });

  final Function(DropDownOptionModel, int) onClick;
  final List<DropDownOptionModel> menus;

  @override
  State<FabBottomSheet> createState() => _FabBottomSheetState();
}

class _FabBottomSheetState extends State<FabBottomSheet> {
  @override
  Widget build(BuildContext context) {
    return DraggableScrollableSheet(
      expand: false,
      builder: (context, controller) {
        return Column(
          mainAxisSize: MainAxisSize.max,
          children: [
            Container(
              width: MediaQuery.of(globalContext).size.width,
              decoration: BoxDecoration(
                color: Colors.transparent,
                border: Border.all(
                  width: 0.0,
                  color: Colors.transparent,
                ),
              ),
              child: Container(
                padding: EdgeInsets.symmetric(vertical: 30.h),
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: const AssetImage(AppImages.bgBottomSheetMask),
                    colorFilter: ColorFilter.mode(
                        themeOf().bottomBarColor, BlendMode.srcATop),
                    fit: BoxFit.fill,
                  ),
                ),
                child: Center(
                  child: Container(
                    height: 4.h,
                    width: 94.h,
                    decoration: BoxDecoration(
                      color: themeOf().borderColor,
                      borderRadius: BorderRadius.circular(20.h),
                    ),
                  ),
                ),
              ),
            ),
            Expanded(
                child: Container(
                    color: themeOf().bottomBarColor,
                    padding: EdgeInsets.symmetric(horizontal: 24.h),
                    child: ContentAreaWidget(
                      scrollController: controller,
                      onClick: widget.onClick,
                      menus: widget.menus,
                    ))),
          ],
        );
      },
      minChildSize: 0.05,
      initialChildSize: 0.7,
    );
  }
}
