import 'package:base_flutter_bloc/base/src_bloc.dart';
import 'package:base_flutter_bloc/bloc/home/home_bloc_event.dart';
import 'package:base_flutter_bloc/remote/repository/user/response/student_relative_extended.dart';
import 'package:base_flutter_bloc/utils/auth/request_properties.dart';
import 'package:base_flutter_bloc/utils/bottom_nav_bar/r_nav_item.dart';
import 'package:base_flutter_bloc/utils/common_utils/shared_pref.dart';
import 'package:base_flutter_bloc/utils/constants/app_colors.dart';
import 'package:base_flutter_bloc/utils/constants/app_images.dart';
import 'package:base_flutter_bloc/utils/screen_utils/keep_alive_widget.dart';
import 'package:flutter/material.dart';
import 'package:rxdart/rxdart.dart';

class HomeBloc extends BaseBloc<HomeBlocEvent, BaseState> {
  @override
  RequestProperties? requestProperties;

  @override
  RequestProperties? getRequestPropertiesData() {
    if (requestProperties != null) {
      return requestProperties;
    } else {
      requestProperties = getRequestProperties();
      return requestProperties;
    }
  }

  @override
  bool? isOtherUser() {
    return isUserParent() == false &&
        isUserStudent() == false &&
        isUserTeacher() == false;
  }

  @override
  bool? isUserParent() {
    return getRequestPropertiesData()?.isUserParent();
  }

  @override
  bool? isUserTeacher() {
    return getRequestPropertiesData()?.isUserTeacher();
  }

  @override
  bool? isUserStudent() {
    return getRequestPropertiesData()?.isUserStudent();
  }

  /// Other Users
  List<RNavItem> otherUserTabs() => [
        const RNavItem(
          iconPath: AppImages.icHome,
          iconDisablePath: AppImages.icHomeDisable,
        ),
        const RNavItem(
          iconPath: AppImages.icMessage,
          iconDisablePath: AppImages.icMessageDisable,
        ),
      ];

  List<Widget> otherUserScreens() => [
        KeepAlivePage(child: Container()),
        KeepAlivePage(child: Container()),
      ];

  /// Student
  List<RNavItem> studentTabs() => [
        const RNavItem(
          iconPath: AppImages.icHome,
          iconDisablePath: AppImages.icHomeDisable,
        ),
        const RNavItem(
          iconPath: AppImages.icLearning,
          iconDisablePath: AppImages.icLearningDisable,
        ),
        const RNavItem(
          iconPath: AppImages.icMessage,
          iconDisablePath: AppImages.icMessageDisable,
        ),
        const RNavItem(
          iconPath: AppImages.icSchool,
          iconDisablePath: AppImages.icSchoolDisable,
        ),
      ];

  List<Widget> studentScreens() => [
        Container(color: Colors.greenAccent),
        KeepAlivePage(child: Container(color: green)),
        KeepAlivePage(child: Container(color: black)),
        KeepAlivePage(child: Container(color: red)),
      ];

  /// Teacher
  List<RNavItem> teacherTabs() => [
        const RNavItem(
          iconPath: AppImages.icHome,
          iconDisablePath: AppImages.icHomeDisable,
        ),
        const RNavItem(
          iconPath: AppImages.icTeaching,
          iconDisablePath: AppImages.icTeachingDisable,
        ),
        const RNavItem(
          iconPath: AppImages.icMessage,
          iconDisablePath: AppImages.icMessageDisable,
        ),
        const RNavItem(
          iconPath: AppImages.icSchool,
          iconDisablePath: AppImages.icSchoolDisable,
        ),
      ];

  List<Widget> teacherScreens() => [
        KeepAlivePage(child: Container()),
        KeepAlivePage(child: Container()),
        KeepAlivePage(child: Container()),
        KeepAlivePage(child: Container()),
      ];

  late BehaviorSubject<StudentForRelativeExtended?> selectedStudent;

  HomeBloc() {
    selectedStudent = BehaviorSubject.seeded(getStudent());
  }

  void setStudent(StudentForRelativeExtended? studentForRelativeExtended) {
    if (!selectedStudent.isClosed) {
      selectedStudent.add(studentForRelativeExtended);
    }
  }
}
