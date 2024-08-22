import 'package:base_flutter_bloc/base/src_bloc.dart';
import 'package:base_flutter_bloc/bloc/home/home_bloc_event.dart';
import 'package:base_flutter_bloc/bloc/settings/settings_provider.dart';
import 'package:base_flutter_bloc/remote/repository/user/response/student_relative_extended.dart';
import 'package:base_flutter_bloc/utils/auth/request_properties.dart';
import 'package:base_flutter_bloc/utils/bottom_nav_bar/r_nav_item.dart';
import 'package:base_flutter_bloc/utils/common_utils/shared_pref.dart';
import 'package:base_flutter_bloc/utils/constants/app_images.dart';
import 'package:base_flutter_bloc/utils/screen_utils/keep_alive_widget.dart';
import 'package:flutter/material.dart';
import 'package:rxdart/rxdart.dart';

import '../../remote/repository/settings/response/app_settings_response.dart';
import '../../utils/stream_helper/settings_utils.dart';

class HomeBloc extends BaseBloc<HomeBlocEvent, BaseState> {
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
  bool? get isOtherUser {
    return isUserParent == false &&
        isUserStudent == false &&
        isUserTeacher == false;
  }

  @override
  bool? get isUserParent => getRequestPropertiesData()?.isUserParent();

  @override
  bool? get isUserTeacher => getRequestPropertiesData()?.isUserTeacher();

  @override
  bool? get isUserStudent => getRequestPropertiesData()?.isUserStudent();

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

  String returnSomething() {
    return 'Hello';
  }

  HomeBloc() {
    selectedStudent = BehaviorSubject.seeded(getStudent());
    on<HomeBlocEvent>((event, emit) {
      switch (event) {
        /// GetSelectedStudentEvent
        case GetSelectedStudentEvent getSelectedStudentEvent:
          emit(const LoadingState());
          selectedStudent = BehaviorSubject.seeded(getStudent());
          emit(DataState(selectedStudent.value));

        /// SetSelectedStudentEvent
        case SetSelectedStudentEvent setSelectedStudentEvent:
          emit(const LoadingState());
          if (!selectedStudent.isClosed) {
            selectedStudent
                .add(setSelectedStudentEvent.studentForRelativeExtended);
          }
          emit(DataState(setSelectedStudentEvent.studentForRelativeExtended));
      }
    });
  }

  void setStudent(StudentForRelativeExtended? studentForRelativeExtended) {
    if (!selectedStudent.isClosed) {
      selectedStudent.add(studentForRelativeExtended);
    }
  }

  void loadStudentQRCodeSettings(
      Function(List<AppSettingsResponse>) onSuccess) {
    List<SettingsValue> settingValues = [
      SettingsValue.ShowStudentQrCode,
      SettingsValue.ShowStudentRegistrationProgram,
      SettingsValue.HideDashboardPageElementsForStudents,
      SettingsValue.HideDashboardPageElementsForParents,
      //SettingsValue.HideDashboardPageElementsForTeachers
    ];

    SettingsProvider.settingsRepository.apiGetApplicationSettings(
      settingValues,
      null,
      null,
      (response) {
        List<AppSettingsResponse> settingResponse = response.data;
        String dashboardSetting = "";
        if (isUserParent == true) {
          if (settingResponse.dashBoardParent != null &&
              settingResponse.dashBoardParent?.value != null) {
            dashboardSetting =
                settingResponse.dashBoardParent!.dashBoardSettings;
          }
        }
        if (isUserStudent == true) {
          if (settingResponse.dashBoardStudent != null &&
              settingResponse.dashBoardStudent?.value != null) {
            dashboardSetting =
                settingResponse.dashBoardStudent!.dashBoardSettings;
          }
        }
        if (isUserTeacher == true) {
          if (settingResponse.dashboardTeacher != null &&
              settingResponse.dashboardTeacher?.value != null) {
            dashboardSetting =
                settingResponse.dashboardTeacher!.dashBoardSettings;
          }
        }
        saveDashboardElements(dashboardSetting);
        onSuccess.call(settingResponse);
      },
      (error) {
        loadStudentQRCodeSettings(onSuccess);
      },
    );
  }
}
