import 'package:base_flutter_bloc/base/component/base_bloc.dart';
import 'package:base_flutter_bloc/base/component/base_event.dart';
import 'package:base_flutter_bloc/base/component/base_state.dart';
import 'package:base_flutter_bloc/base/page/base_page.dart';
import 'package:base_flutter_bloc/utils/screen_utils/flutter_screen_util.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../common_utils/common_utils.dart';
import '../../constants/app_colors.dart';
import '../../constants/app_images.dart';
import '../../constants/app_styles.dart';
import '../../constants/app_theme.dart';
import '../common_widgets.dart';
import '../gradient_button.dart';
import '../image_view.dart';
import 'common_filter_screen_bloc.dart';

class CommonFilterScreen extends BasePage {
  final String filterTitleText;
  final String filterButtonText;
  final Widget contentWidget;
  final Function onCloseTapped;
  final Function onButtonTapped;

  const CommonFilterScreen(
      {Key? key,
      required this.filterTitleText,
      required this.filterButtonText,
      required this.contentWidget,
      required this.onCloseTapped,
      required this.onButtonTapped})
      : super(key: key);

  @override
  BasePageState<BasePage, BaseBloc<BaseEvent, BaseState>> get getState =>
      _FilterScreenState();
}

class _FilterScreenState
    extends BasePageState<CommonFilterScreen, CommonFilterScreenBloc> {
  final CommonFilterScreenBloc _bloc = CommonFilterScreenBloc();
  bool switchValue = false;

  @override
  void onReady() {}

  @override
  Widget? getAppBar() {
    return null;
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  SystemUiOverlayStyle getSystemUIOverlayStyle() {
    return themeOf().uiOverlayStyleDialog();
  }

  @override
  Widget buildWidget(BuildContext context) {
    return Dialog(
      insetPadding: EdgeInsets.fromLTRB(20.h, 0, 20.h, 0),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      elevation: 0.0,
      backgroundColor: Colors.transparent,
      child: Container(
        width: isTablet() ? 0.6.sw : double.infinity,
        margin: const EdgeInsets.only(left: 0.0, right: 0.0),
        child: Stack(
          children: [
            Container(
              margin: const EdgeInsets.only(top: 12.0, right: 12.0),
              decoration: BoxDecoration(
                color: themeOf().dialogBgColor,
                shape: BoxShape.rectangle,
                borderRadius: BorderRadius.circular(10),
                boxShadow: const [
                  BoxShadow(
                    color: Colors.black26,
                    blurRadius: 10.0,
                    offset: Offset(0.0, 10.0),
                  ),
                ],
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  buildTopView(),
                  Flexible(
                      child:
                          SingleChildScrollView(child: widget.contentWidget)),
                  buildBottomView()
                ],
              ),
            ),
            PositionedDirectional(
              end: 0.0,
              child: GestureDetector(
                onTap: () {
                  widget.onCloseTapped();
                  Navigator.of(context).pop();
                },
                child: Align(
                  alignment: AlignmentDirectional.topEnd,
                  child: ImageView(
                    image: AppImages.icClose,
                    imageType: ImageType.svg,
                    width: 24.h,
                    height: 24.h,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildTopView() {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(15.h),
      decoration: BoxDecoration(
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(10),
            topRight: Radius.circular(10),
          ),
          gradient: getCommonGradient()),
      child: Text(
        widget.filterTitleText,
        style: styleSmall4.copyWith(color: white, fontWeight: FontWeight.w500),
      ),
    );
  }

  Widget buildBottomView() {
    if (widget.filterButtonText.isEmpty) {
      return const SizedBox();
    } else {
      return Container(
        padding: EdgeInsetsDirectional.fromSTEB(15.h, 0, 15.h, 15.h),
        child: GradientButton(
          width: double.infinity,
          gradient: getCommonGradient(),
          onPressed: () {
            widget.onButtonTapped();
          },
          borderRadius: BorderRadius.circular(10),
          child: Text(
            widget.filterButtonText,
            style: styleMedium1Bold.copyWith(
              color: white,
            ),
          ),
        ),
      );
    }
  }

  @override
  CommonFilterScreenBloc get getBloc => _bloc;
}
