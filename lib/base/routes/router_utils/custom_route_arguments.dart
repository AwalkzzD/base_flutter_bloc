import 'package:base_flutter_bloc/utils/stream_helper/common_enums.dart';

import '../../../remote/repository/profile/response/user_profile_response.dart';

class CustomRouteArguments {
  final ScreenType fromScreen;
  final String name;
  final Function()? onCloseDrawer;
  final bool fromRoute;
  final UserProfileResponse? profile;
  final String? qrImageScreenTitle;
  final String? qrImageScreenValue;
  final int? periodId;
  final int? studentId;

  CustomRouteArguments({
    this.fromScreen = ScreenType.normal,
    this.name = '',
    this.onCloseDrawer,
    this.fromRoute = true,
    this.profile,
    this.qrImageScreenTitle,
    this.qrImageScreenValue,
    this.periodId,
    this.studentId,
  });
}
