import 'package:base_flutter_bloc/remote/repository/user/response/student_relative_extended.dart';
import 'package:base_flutter_bloc/utils/appbar/common_profile_view.dart';
import 'package:base_flutter_bloc/utils/auth/request_properties.dart';
import 'package:base_flutter_bloc/utils/auth/user_claim_helper.dart';
import 'package:base_flutter_bloc/utils/common_utils/shared_pref.dart';
import 'package:base_flutter_bloc/utils/constants/app_theme.dart';
import 'package:base_flutter_bloc/utils/screen_utils/flutter_screen_util.dart';
import 'package:base_flutter_bloc/utils/widgets/image_view.dart';
import 'package:flutter/material.dart';
import 'package:popover/popover.dart';
import 'package:rxdart/rxdart.dart';

import '../widgets/student_list_popover_widget.dart';
import 'icon_appbar.dart';

class AppBarButtonProfileView extends StatelessWidget {
  final Function(StudentForRelativeExtended?)? onStudentClick;
  final BehaviorSubject<StudentForRelativeExtended?>? student;
  final List<StudentForRelativeExtended?>? studentsList;

  const AppBarButtonProfileView(
      {super.key, this.student, this.onStudentClick, this.studentsList});

  @override
  Widget build(BuildContext context) {
    RequestProperties? requestProperties = getRequestProperties();
    if (requestProperties?.userType == UserTypes.Parent) {
      return IconAppBar(
        onClick: (context) async {
          if (requestProperties != null) {
            if (requestProperties.userType == UserTypes.Parent) {
              final result = await showPopover(
                backgroundColor: themeOf().appBarColor,
                context: context,
                bodyBuilder: (context) => StudentListPopoverWidget(
                    student: student,
                    onStudentClick: onStudentClick,
                    studentsList: studentsList ?? getStudentList()),
                onPop: () {},
                width: ScreenUtil().screenWidth - 26,
              );
              if (result == null) {
                //SystemChrome.setSystemUIOverlayStyle(themeOf().uiOverlayStyleCommon());
              }
            } else {
              // todo: router.push(AppRouter.profileRoute)
            }
          }
        },
        icon: StreamBuilder<StudentForRelativeExtended?>(
            stream: student?.stream,
            builder: (context, snapshot) {
              if (snapshot.hasData && snapshot.data != null) {
                return CommonProfileView(
                  image: getBase64Image(snapshot.data?.student.image ?? ""),
                  text: snapshot.data?.student.getName() ?? "",
                  boxFit: BoxFit.cover,
                  size: 30.h,
                  borderColor: themeOf().appBarTextColor,
                );
              } else {
                return CommonProfileView(
                  image: "",
                  text: "",
                  size: 30.h,
                  boxFit: BoxFit.cover,
                  borderColor: themeOf().appBarTextColor,
                );
              }
            }),
      );
    } else {
      return const SizedBox();
    }
  }
}
