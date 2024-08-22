import 'package:base_flutter_bloc/utils/stream_helper/common_enums.dart';

class CustomRouteArguments {
  final ScreenType fromScreen;
  final String name;
  final Function()? onCloseDrawer;

  CustomRouteArguments({
    this.fromScreen = ScreenType.normal,
    this.name = '',
    this.onCloseDrawer,
  });
}
