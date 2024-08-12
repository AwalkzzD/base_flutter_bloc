import 'package:base_flutter_bloc/bloc/app_bloc.dart';
import 'package:base_flutter_bloc/utils/appbar/icon_appbar.dart';
import 'package:base_flutter_bloc/utils/common_utils/app_widgets.dart';
import 'package:base_flutter_bloc/utils/constants/app_images.dart';
import 'package:base_flutter_bloc/utils/constants/app_theme.dart';
import 'package:base_flutter_bloc/utils/screen_utils/flutter_screen_util.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class BarcodeAppBarButton extends StatelessWidget {
  final Function()? onClick;

  const BarcodeAppBarButton({super.key, this.onClick});

  @override
  Widget build(BuildContext context) {
    AppBloc appBloc = BlocProvider.of<AppBloc>(globalContext);
    AppTheme appTheme = BlocProvider.of<AppTheme>(globalContext);
    return StreamBuilder<bool>(
        stream: appBloc.showStudentQrCode.stream,
        builder: (context, snapshot) {
          if (snapshot.hasData && snapshot.data == true) {
            return IconAppBar(
              onClick: (context) {
                if (onClick == null) {
                } else {
                  onClick?.call();
                }
              },
              image: AppImages.icAppBarBarCode,
              height: 18.h,
              width: 18.h,
              color: themeOf().iconColor,
            );
          } else {
            return const SizedBox();
          }
        });
  }
}
