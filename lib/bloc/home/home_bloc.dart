import 'package:base_flutter_bloc/base/src_bloc.dart';
import 'package:base_flutter_bloc/bloc/app_bloc/app_bloc.dart';
import 'package:base_flutter_bloc/bloc/home/home_bloc_event.dart';
import 'package:base_flutter_bloc/bloc/settings/settings_provider.dart';
import 'package:base_flutter_bloc/remote/repository/user/response/student_relative_extended.dart';
import 'package:base_flutter_bloc/utils/auth/request_properties.dart';
import 'package:base_flutter_bloc/utils/bottom_nav_bar/r_nav_item.dart';
import 'package:base_flutter_bloc/utils/common_utils/app_widgets.dart';
import 'package:base_flutter_bloc/utils/common_utils/shared_pref.dart';
import 'package:base_flutter_bloc/utils/constants/app_images.dart';
import 'package:base_flutter_bloc/utils/screen_utils/keep_alive_widget.dart';
import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rxdart/rxdart.dart';

import '../../remote/repository/consents/response/consents_student_response.dart';
import '../../remote/repository/settings/response/app_settings_response.dart';
import '../../remote/repository/user/response/student_of_relative_response.dart';
import '../../remote/repository/user/response/user_response.dart';
import '../../utils/auth/user_common_api.dart';
import '../../utils/enum_to_string/enum_to_string.dart';
import '../../utils/stream_helper/settings_utils.dart';
import '../../utils/widgets/strings_utils.dart';

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
  get selectedStudentStream => selectedStudent.stream;

  HomeBloc() {
    selectedStudent = BehaviorSubject.seeded(getStudent());
    on<HomeBlocEvent>((event, emit) async {
      switch (event) {
        /// LoadQrSettingsEvent
        case LoadQrSettingsEvent loadQrSettingsEvent:
          emit(const LoadingState());
          await loadQRSettings((response) {
            emit(DataState(response));
          });

        /// CheckConsentsEvent
        case CheckConsentsEvent checkConsentsEvent:
          emit(const LoadingState());
          await checkConsents((response) {
            emit(DataState(response));
          }, (errorMsg) {
            emit(ErrorState(errorMsg));
          });

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

  Future<void> loadQRSettings(Function(AppSettingsResponse?) success) async {
    if (isOtherUser == true) {
      success.call(null);
    } else {
      await loadStudentQRCodeSettings((settingResponse) {
        AppSettingsResponse? showQrCode = settingResponse.firstWhereOrNull(
            (element) =>
                element.setting ==
                EnumToString.convertToString(SettingsValue.ShowStudentQrCode));
        if (showQrCode != null) {
          String showQrCodeValue = showQrCode.value.toString();
          if (showQrCodeValue.toLowerCase() == "true") {
            globalContext.read<AppBloc>().setShowStudentQrCode(true);
          } else {
            globalContext.read<AppBloc>().setShowStudentQrCode(false);
          }
        }
        success.call(showQrCode);
      });
    }
  }

  Future<void> loadStudentQRCodeSettings(
      Function(List<AppSettingsResponse>) onSuccess) async {
    List<SettingsValue> settingValues = [
      SettingsValue.ShowStudentQrCode,
      SettingsValue.ShowStudentRegistrationProgram,
      SettingsValue.HideDashboardPageElementsForStudents,
      SettingsValue.HideDashboardPageElementsForParents,
      //SettingsValue.HideDashboardPageElementsForTeachers
    ];

    await SettingsProvider.settingsRepository.apiGetApplicationSettings(
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

  /*
  *  Method will get required and not required consent
  *  Required consents will be shown in Dialog
  *  Not required consent will be shown in Home screen consent area
  * */
  Future<void> checkConsents(
      Function(Map<int, List<ConsentsStudentsResponse>>?) onSuccess,
      Function(String) onError) async {
    if (isOtherUser == true) {
      onSuccess.call(null);
    } else {
      loadRequiredConsents(selectedStudent.value?.id, true, () {
        loadRequiredConsents(selectedStudent.value?.id, false, () {
          Map<int, List<ConsentsStudentsResponse>> unAnsweredRequiredConsents =
              globalContext
                  .read<AppBloc>()
                  .requiredUnAnsweredConsentsList
                  .value;

          /*bool showRequiredDialog = unAnsweredRequiredConsents.values
              .any((value) => value.isNotEmpty);

          if (showRequiredDialog) {
            // if (getAppBloc()!.requiredUnAnsweredConsentsList.value.isNotEmpty) {
            /// Scenario 1 : Show dialog that navigates the user to Consent screen with forced consents list.
            bool barrierDismissible = globalContext
                    .read<AppBloc>()
                    .disallowClosingMandatoryConsentsDialog ??
                false;
            ConsentDialog.showAlertDialog(
              context,
              barrierDismissible,
              onPositiveButtonClicked: () {
                Navigator.of(context).pop();
                Navigator.of(context).push(ConsentsScreen.route(
                    ConsentViewType.Required,
                    getBloc().selectedStudent.value?.id ?? -1,
                    null));
              },
            );
          }*/
          onSuccess.call(unAnsweredRequiredConsents);
        }, (err) => onError(err));
      }, (err) => onError(err));
    }
  }

  List<StudentForRelativeExtended> studentsList() => getStudentList();

  List<StudentForRelativeExtended> getStudentsListWithParent() {
    List<StudentForRelativeExtended> students = [];
    students.add(getParentAsStudent());
    students.addAll(getStudentList());
    return students;
  }

  StudentForRelativeExtended getParentAsStudent() {
    RequestProperties? properties = getRequestProperties();
    UserResponse? user = getUser();
    StudentOfRelativeResponse studentOfRelativeResponse =
        StudentOfRelativeResponse(
            id: properties?.entityId,
            surname: user?.surname,
            givenName: user?.givenName,
            fullname: getFullName(user?.givenName, user?.surname),
            image: user?.image);
    StudentForRelativeExtended studentForRelativeExtended =
        StudentForRelativeExtended(studentOfRelativeResponse);
    return studentForRelativeExtended;
  }
}
