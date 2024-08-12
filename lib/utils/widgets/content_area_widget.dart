import 'package:base_flutter_bloc/utils/constants/app_theme.dart';
import 'package:base_flutter_bloc/utils/dropdown/dropdown_option_model.dart';
import 'package:base_flutter_bloc/utils/screen_utils/flutter_screen_util.dart';
import 'package:base_flutter_bloc/utils/widgets/divider_widget.dart';
import 'package:base_flutter_bloc/utils/widgets/image_view.dart';
import 'package:flutter/material.dart';

class ContentAreaWidget extends StatefulWidget {
  const ContentAreaWidget(
      {super.key,
      required this.onClick,
      this.menus = const [],
      this.scrollController});

  final Function(DropDownOptionModel, int) onClick;
  final List<DropDownOptionModel> menus;
  final ScrollController? scrollController;

  // final Widget Function(ScrollController? scrollController, void Function(String) tryAgain) errorIndicatorWidget;

  @override
  State<ContentAreaWidget> createState() => _ContentAreaWidgetState();
}

class _ContentAreaWidgetState extends State<ContentAreaWidget> {
  @override
  Widget build(BuildContext context) {
    return ListView(
      shrinkWrap: true,
      controller: widget.scrollController,
      physics: const NeverScrollableScrollPhysics(),
      children: List.generate(widget.menus.length,
          (index) => buildMenuItem(widget.menus[index], index)),
    );
  }

  Widget buildMenuItem(DropDownOptionModel data, int index) {
    return Padding(
      padding: EdgeInsets.only(bottom: 10.h),
      child: InkWell(
        onTap: () {
          widget.onClick.call(data, index);
        },
        child: Row(
          children: [
            ImageView(
              image: data.key,
              imageType: ImageType.svg,
              color: themeOf().iconColor,
              width: 16.h,
              height: 18.h,
            ),
            SizedBox(
              width: 30.h,
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: 8.h),
                    child: Text(
                      data.value ?? "",
                      style: const TextStyle()
                          .copyWith(color: themeOf().textPrimaryColor),
                    ),
                  ),
                  const DividerWidget(verticalMargin: 0)
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
