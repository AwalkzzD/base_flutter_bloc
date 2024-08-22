import 'dart:async';

import 'package:base_flutter_bloc/base/network/response/error/error_response.dart';
import 'package:base_flutter_bloc/bloc/consents/consents_provider.dart';
import 'package:base_flutter_bloc/bloc/settings/settings_provider.dart';
import 'package:base_flutter_bloc/bloc/user/user_provider.dart';
import 'package:base_flutter_bloc/remote/repository/settings/response/app_settings_response.dart';
import 'package:base_flutter_bloc/remote/repository/settings/response/check_mobile_license_response.dart';
import 'package:base_flutter_bloc/remote/repository/settings/response/company_id_response.dart';
import 'package:base_flutter_bloc/remote/repository/settings/response/mobile_license_menu.dart';
import 'package:base_flutter_bloc/remote/repository/terminology/response/terminology_list_response.dart';
import 'package:base_flutter_bloc/remote/repository/user/response/academic_periods_response.dart';
import 'package:base_flutter_bloc/remote/repository/user/response/check_user_type_response.dart';
import 'package:base_flutter_bloc/remote/repository/user/response/get_parent_child_educational_programs_response.dart';
import 'package:base_flutter_bloc/remote/repository/user/response/institute_response.dart';
import 'package:base_flutter_bloc/remote/repository/user/response/student_educational_program_response.dart';
import 'package:base_flutter_bloc/remote/repository/user/response/student_of_relative_response.dart';
import 'package:base_flutter_bloc/remote/repository/user/response/student_relative_extended.dart';
import 'package:base_flutter_bloc/remote/repository/user/response/user_response.dart';
import 'package:base_flutter_bloc/utils/auth/request_properties.dart';
import 'package:base_flutter_bloc/utils/auth/user_claim_helper.dart';
import 'package:base_flutter_bloc/utils/common_utils/shared_pref.dart';
import 'package:base_flutter_bloc/utils/guid/flutter_guid.dart';
import 'package:base_flutter_bloc/utils/stream_helper/settings_utils.dart';
import 'package:collection/collection.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../bloc/app_bloc.dart';
import '../../remote/repository/consents/request/utils/consents_request.dart';
import '../../remote/repository/consents/response/consents_student_response.dart';
import '../common_utils/app_widgets.dart';
import '../enum_to_string/enum_to_string.dart';
import '../stream_helper/common_enums.dart';

Future<void> getCompanyId(Function(CompanyIdResponse?) onSuccess,
    Function(ErrorResponse) onError) async {
  Guid guid = Guid("72bdc44f-c588-44f3-b6df-9aace7daafdd");
  await SettingsProvider.settingsRepository.apiGetCompanyId(guid.value, "0",
      (response) {
    onSuccess.call(response.data);
  }, (error) {
    onError.call(error);
  });
}

Future<void> getActivePeriod(
    String? companyId,
    Function(List<AppSettingsResponse>) onSuccess,
    Function(ErrorResponse) onError) async {
  List<SettingsValue> settingValues = [
    SettingsValue.ActivePeriod,
    SettingsValue.UseSurNameFirst
  ];
  await SettingsProvider.settingsRepository
      .apiGetApplicationSettings(settingValues, companyId, "0", (response) {
    onSuccess(response.data);
  }, (error) {
    onError(error);
  });
}

Future<void> getUserAcademicPeriods(
    String? instituteId,
    String? period,
    Function(List<AcademicPeriodResponse>) onSuccess,
    Function(ErrorResponse) onError) async {
  await UserProvider.userRepository.apiGetAcademicPeriods(instituteId, period,
      (academicPeriods, paginateData) {
    if (academicPeriods.data.isEmpty) {
      onSuccess([]);
    } else {
      AcademicPeriodResponse? academicPeriod =
          academicPeriods.data.firstWhereOrNull((w) => w.isDefault == true);
      if (academicPeriod != null) {
        saveAcademicPeriod(academicPeriod);
      } else {
        String periodCode = period ?? "";
        bool isPeriodCodePresent =
            academicPeriods.data.any((s) => s.id.toString() == periodCode);
        if (!isPeriodCodePresent) {
          List<int?> ids = academicPeriods.data.map((s) => s.id).toList();
          periodCode = ids
              .reduce((curr, next) => (curr ?? 0) > (next ?? 0) ? curr : next)
              .toString();
        }
        AcademicPeriodResponse? academicPeriod = academicPeriods.data
            .firstWhereOrNull((w) => w.id.toString() == periodCode);
        if (academicPeriod != null) {
          saveAcademicPeriod(academicPeriod);
        }
      }
      onSuccess(academicPeriods.data);
    }
  }, (error) {
    onError(error);
  });
}

Future<void> getCompany(
    String? instituteCode,
    Function(InstituteResponse) onSuccess,
    Function(ErrorResponse) onError) async {
  await UserProvider.userRepository.apiGetCompany(instituteCode, (response) {
    saveInstitute(response.data);
    onSuccess(response.data);
  }, (error) {
    onError(error);
  });
}

Future<void> getMobileLicenseUserMenus(
    Function(MobileLicenseMenuResponse) onSuccess,
    Function(ErrorResponse) onError) async {
  await SettingsProvider.settingsRepository.apiGetMobileLicenseUserMenus(
      (response) {
    saveMobileMenu(response.data);
    onSuccess(response.data);
  }, (error) {
    onError(error);
  });
}

Future<void> getTerminologies(Function(List<TerminologyListResponse>) onSuccess,
    Function(ErrorResponse) onError) async {
  await SettingsProvider.settingsRepository.apiGetTerminologies((response) {
    onSuccess(response.data);
  }, (error) {
    onError(error);
  });
}

Future<void> getUserData(
    Function(UserResponse) onSuccess, Function(ErrorResponse) onError) async {
  await UserProvider.userRepository.apiGetUserData((response) {
    saveUser(response.data);
    onSuccess(response.data);
  }, (error) {
    onError(error);
  });
}

Future<void> loadCheckUserType(Function(CheckUserTypeResponse) onSuccess,
    Function(ErrorResponse) onError) async {
  RequestProperties? requestProperties = getRequestProperties();
  if (requestProperties != null) {
    bool checkIfUserTypeAllowed =
        await checkIfUserTypeSupportedAsync(requestProperties.userType);
    if (checkIfUserTypeAllowed) {
      onSuccess(CheckUserTypeResponse(true));
    } else {
      onError(ErrorResponse(-1, 'Invalid User Type'));
    }
  }
}

Future<void> loadCheckMobileLicense(
    Function(CheckMobileLicenseResponse) onSuccess,
    Function(ErrorResponse) onError) async {
  await SettingsProvider.settingsRepository.apiCheckLicense((response) {
    if (response.data.response == "true") {
      onSuccess(response.data);
    } else {
      onError(ErrorResponse(-1, 'Invalid Mobile License'));
    }
  }, (error) {
    onError(error);
  });
}

void loadGetStudentRelative(
  int? studentId,
  Function(List<StudentOfRelativeResponse>) onSuccess,
  Function(ErrorResponse) onError,
) {
  getStudentRelative(studentId, (response) {
    onSuccess.call(response);
  }, (error) {
    onError(error);
  });
}

Future<void> getStudentRelative(
    int? studentId,
    Function(List<StudentOfRelativeResponse>) onSuccess,
    Function(ErrorResponse) onError) async {
  await UserProvider.userRepository.apiGetStudentRelative(studentId, ["1"],
      (response, paginationData) {
    onSuccess(response.data);
  }, (error) {
    onError(error);
  });
}

List<StudentForRelativeExtended> studentRelativeExtendedList = [];

Future<GetParentChildEducationalProgramsResponse>
    loadGetParentChildAndEducationalPrograms(
  Function(GetParentChildEducationalProgramsResponse) onSuccess,
  Function(ErrorResponse) onError,
) async {
  studentRelativeExtendedList = [];
  RequestProperties? requestProperties = getRequestProperties();
  if (requestProperties?.userType == UserTypes.Parent) {
    loadGetStudentRelative(requestProperties?.entityId, (studentList) {
      loadAllRelativeWithPrograms(0, studentList, () {
        saveStudentList(studentRelativeExtendedList);
        if (studentRelativeExtendedList.isNotEmpty) {
          saveStudent(studentRelativeExtendedList[0]);
        }
        onSuccess(GetParentChildEducationalProgramsResponse(isSuccess: true));
        return (GetParentChildEducationalProgramsResponse(isSuccess: true));
      }, (error) {
        onSuccess(GetParentChildEducationalProgramsResponse(isSuccess: false));
        return (GetParentChildEducationalProgramsResponse(isSuccess: false));
        /*onError
            .call(ErrorResponse(-1, "Failed to load relative with programs"));*/
      });
    }, (error) {
      onSuccess(GetParentChildEducationalProgramsResponse(isSuccess: false));
      return (GetParentChildEducationalProgramsResponse(isSuccess: false));
      /*onError.call(ErrorResponse(-1, "Failed to get Student Relative"));*/
    });
  } else if (requestProperties?.userType == UserTypes.Student) {
    UserResponse? userResponse = getUser();
    StudentOfRelativeResponse studentOfRelativeResponse =
        StudentOfRelativeResponse(
            id: userResponse?.entity?.id,
            surname: userResponse?.surname,
            givenName: userResponse?.givenName,
            image: userResponse?.image);
    StudentForRelativeExtended studentForRelativeExtended =
        StudentForRelativeExtended(studentOfRelativeResponse);
    loadGetStudentEducationPrograms(studentForRelativeExtended.id, (programs) {
      studentForRelativeExtended.educationalPrograms = programs;
    }, (error) {
      onSuccess(GetParentChildEducationalProgramsResponse(isSuccess: false));
      return (GetParentChildEducationalProgramsResponse(isSuccess: false));
      /*onError(ErrorResponse(-1, "errorMsg"));*/
    });
    studentRelativeExtendedList.add(studentForRelativeExtended);
    saveStudentList(studentRelativeExtendedList);
    if (studentRelativeExtendedList.isNotEmpty) {
      saveStudent(studentRelativeExtendedList[0]);
    }
    onSuccess(GetParentChildEducationalProgramsResponse(isSuccess: true));
    return (GetParentChildEducationalProgramsResponse(isSuccess: true));
  } else {
    onSuccess(GetParentChildEducationalProgramsResponse(isSuccess: true));
    return (GetParentChildEducationalProgramsResponse(isSuccess: true));
  }
  return (GetParentChildEducationalProgramsResponse(isSuccess: true));
}

void loadAllRelativeWithPrograms(
    int index,
    List<StudentOfRelativeResponse> studentList,
    Function() onSuccess,
    Function(ErrorResponse) onError) {
  if (index > studentList.length - 1) {
    onSuccess.call();
  } else {
    StudentOfRelativeResponse? student = studentList[index];
    loadGetStudentEducationPrograms(student.id, (programs) {
      StudentForRelativeExtended studentForRelativeExtended =
          StudentForRelativeExtended(student);
      studentForRelativeExtended.educationalPrograms = programs;
      studentRelativeExtendedList.add(studentForRelativeExtended);
      loadAllRelativeWithPrograms(index + 1, studentList, onSuccess, onError);
    }, onError);
  }
}

void loadGetStudentEducationPrograms(
    int? studentId,
    Function(List<StudentEducationalProgramResponse>) onSuccess,
    Function(ErrorResponse) onError) {
  getStudentEducationalPrograms(studentId, (response) {
    onSuccess.call(response);
  }, onError);
}

Future<void> getStudentEducationalPrograms(
    int? studentId,
    Function(List<StudentEducationalProgramResponse>) onSuccess,
    Function(ErrorResponse) onError) async {
  await UserProvider.userRepository.apiGetStudentEducationalProgram(
      studentId, 1, (response, paginationData) {
    onSuccess(response.data);
  }, (error) {
    onError(error);
  });
}

Future<void> loadRequiredConsents(int? selectedStudentId, bool? requiredParam,
    Function() onSuccess, Function(String) onError) async {
  ConsentsRequest requestParameters = ConsentsRequest(required: requiredParam);
  Map<String, dynamic>? data = requestParameters.toMap();

  RequestProperties? properties = getRequestProperties();
  UserTypes? userTypes = properties?.userType;
  if (requiredParam != null) {
    if (requiredParam) {
      BlocProvider.of<AppBloc>(globalContext)
          .requiredUnAnsweredConsentsList
          .value
          .clear();
    } else {
      BlocProvider.of<AppBloc>(globalContext)
          .notRequiredUnAnsweredConsentsList
          .value
          .clear();
    }
  } else {
    BlocProvider.of<AppBloc>(globalContext).mainConsentsList.value.clear();
  }

  if (userTypes == UserTypes.Teacher) {
    String entityType =
        EnumToString.convertToString(ConsentEntityType.teachers);

    ConsentsProvider.consentRepository
        .apiGetConsentsList(getRequestProperties()?.entityId, entityType, data,
            (consentsListResponse) {
      addConsentByRequiredParam(
          requiredParam, properties!.userId, consentsListResponse.data);
      onSuccess.call();
    }, (error) {
      onError.call(error.errorMsg);
    });
  } else if (userTypes == UserTypes.Student) {
    String entityType =
        EnumToString.convertToString(ConsentEntityType.students);

    ConsentsProvider.consentRepository
        .apiGetConsentsList(getRequestProperties()?.entityId, entityType, data,
            (consentsListResponse) {
      addConsentByRequiredParam(
          requiredParam, properties!.userId, consentsListResponse.data);
      onSuccess.call();
    }, (error) {
      onError.call(error.errorMsg);
    });
  } else if (userTypes == UserTypes.Parent) {
    String entityType =
        EnumToString.convertToString(ConsentEntityType.students);

    ConsentsProvider.consentRepository.apiGetConsentsList(
        selectedStudentId, entityType, data, (consentsListResponse) {
      addConsentByRequiredParam(
          requiredParam, selectedStudentId ?? 0, consentsListResponse.data);
      onSuccess.call();
    }, (error) {
      onError.call(error.errorMsg);
    });
  } else {
    // no-op
  }
}

void addConsentByRequiredParam(
    bool? requiredParam, int id, List<ConsentsStudentsResponse> list) {
  AppBloc appBloc = BlocProvider.of<AppBloc>(globalContext);
  if (requiredParam != null) {
    if (requiredParam) {
      appBloc.addRequiredUnAnsweredConsents(id, list);
    } else {
      appBloc.addNotRequiredUnAnsweredConsents(id, list);
    }
  } else {
    appBloc.addConsents(id, list);
  }
}
