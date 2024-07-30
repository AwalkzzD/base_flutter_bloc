import 'dart:async';

import 'package:base_flutter_bloc/base/network/response/error/error_response.dart';
import 'package:base_flutter_bloc/bloc/settings/settings_provider.dart';
import 'package:base_flutter_bloc/bloc/user/user_provider.dart';
import 'package:base_flutter_bloc/remote/repository/settings/response/app_settings_response.dart';
import 'package:base_flutter_bloc/remote/repository/settings/response/check_mobile_license_response.dart';
import 'package:base_flutter_bloc/remote/repository/settings/response/company_id_response.dart';
import 'package:base_flutter_bloc/remote/repository/settings/response/mobile_license_menu.dart';
import 'package:base_flutter_bloc/remote/repository/terminology/response/terminology_list_response.dart';
import 'package:base_flutter_bloc/remote/repository/user/response/academic_periods_response.dart';
import 'package:base_flutter_bloc/remote/repository/user/response/check_user_type_response.dart';
import 'package:base_flutter_bloc/remote/repository/user/response/institute_response.dart';
import 'package:base_flutter_bloc/remote/repository/user/response/student_of_relative_response.dart';
import 'package:base_flutter_bloc/remote/repository/user/response/user_response.dart';
import 'package:base_flutter_bloc/utils/auth/request_properties.dart';
import 'package:base_flutter_bloc/utils/auth/user_claim_helper.dart';
import 'package:base_flutter_bloc/utils/common_utils/shared_pref.dart';
import 'package:base_flutter_bloc/utils/guid/flutter_guid.dart';
import 'package:base_flutter_bloc/utils/stream_helper/settings_utils.dart';
import 'package:collection/collection.dart';

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

Future<void> loadGetStudentRelative(
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
