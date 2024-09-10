import 'package:base_flutter_bloc/base/src_bloc.dart';
import 'package:base_flutter_bloc/bloc/full_image_viewer/image_full_screen_bloc.dart';
import 'package:base_flutter_bloc/utils/screen_utils/flutter_screen_util.dart';
import 'package:flutter/cupertino.dart';

import '../../utils/appbar/back_button_appbar.dart';
import '../../utils/widgets/image_view.dart';

class ImageFullScreen extends BasePage {
  final String title;
  final String value;

  const ImageFullScreen({
    super.key,
    required this.value,
    required this.title,
  });

  @override
  BasePageState<BasePage, BaseBloc<BaseEvent, BaseState>> get getState =>
      _ImageFullScreenState();
}

class _ImageFullScreenState
    extends BasePageState<ImageFullScreen, ImageFullScreenBloc> {
  final ImageFullScreenBloc _bloc = ImageFullScreenBloc();

  @override
  Widget? get customAppBar => AppBarBackButton.build(
      onBackPressed: () => router.pop(), title: widget.title);

  @override
  Widget buildWidget(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          ImageView(
            image: widget.value,
            imageType: ImageType.base64,
            boxFit: BoxFit.contain,
            width: 0.5.sw,
          ),
          // Add any additional widgets you want here
        ],
      ),
    );
  }

  @override
  ImageFullScreenBloc get getBloc => _bloc;
}
