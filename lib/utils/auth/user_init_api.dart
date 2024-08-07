import 'package:base_flutter_bloc/base/network/response/error/error_response.dart';
import 'package:base_flutter_bloc/remote/repository/settings/response/app_settings_response.dart';
import 'package:base_flutter_bloc/remote/repository/settings/response/company_id_response.dart';
import 'package:base_flutter_bloc/remote/repository/settings/response/mobile_license_menu.dart';
import 'package:base_flutter_bloc/remote/repository/terminology/response/terminology_list_response.dart';
import 'package:base_flutter_bloc/remote/repository/user/response/academic_periods_response.dart';
import 'package:base_flutter_bloc/remote/repository/user/response/init_user_response.dart';
import 'package:base_flutter_bloc/remote/repository/user/response/institute_response.dart';
import 'package:base_flutter_bloc/remote/repository/user/response/user_response.dart';
import 'package:base_flutter_bloc/utils/auth/request_properties.dart';
import 'package:base_flutter_bloc/utils/auth/user_common_api.dart';
import 'package:base_flutter_bloc/utils/common_utils/shared_pref.dart';
import 'package:base_flutter_bloc/utils/enum_to_string/enum_to_string.dart';
import 'package:base_flutter_bloc/utils/stream_helper/settings_utils.dart';
import 'package:collection/collection.dart';

Future<InitUserResponse?> initUserAPI(Function(InitUserResponse) onSuccess,
    Function(ErrorResponse) onError) async {
  /// common variables
  String? companyId;
  String? activePeriod;
  UserResponse? userResponseLocal;
  InitUserResponse? initUserResponse;
  List<TerminologyListResponse>? terminologiesResponseLocal;
  MobileLicenseMenuResponse? mobileLicenseMenuResponseLocal;
  InstituteResponse? companyResponseLocal;
  List<AcademicPeriodResponse>? userAcademicPeriodsResponseLocal;
  List<AppSettingsResponse>? activePeriodResponseLocal;
  CompanyIdResponse? companyIdResponseLocal;

  /// getCompanyId
  await getCompanyId((companyIdResponse) async {
    companyId = companyIdResponse?.id;
    companyIdResponseLocal = companyIdResponse;
  }, (error) {
    companyIdResponseLocal = null;
  }).whenComplete(() async {
    if (companyIdResponseLocal != null) {
      /// getActivePeriod
      await getActivePeriod(companyId, (activePeriodResponse) async {
        activePeriodResponseLocal = activePeriodResponse;
      }, (error) {
        activePeriodResponseLocal = null;
      }).whenComplete(() async {
        if (activePeriodResponseLocal != null) {
          AppSettingsResponse? activePeriodCode = activePeriodResponseLocal!
              .firstWhereOrNull((element) =>
                  element.setting ==
                  EnumToString.convertToString(SettingsValue.ActivePeriod));
          if (activePeriodCode != null) {
            activePeriod = activePeriodCode.value.toString();
          } else {
            onError(ErrorResponse(-1, 'Active Period Code is null'));
          }

          /// getUserAcademicPeriods
          await getUserAcademicPeriods(companyId, activePeriod,
              (userAcademicPeriodsResponse) async {
            userAcademicPeriodsResponseLocal = userAcademicPeriodsResponse;
          }, (error) {
            userAcademicPeriodsResponseLocal = null;
          }).whenComplete(() async {
            if (userAcademicPeriodsResponseLocal != null) {
              if (userAcademicPeriodsResponseLocal!.isEmpty) {
                initUserResponse = null;
              } else {
                RequestProperties requestProperties = RequestProperties();
                await requestProperties.initializeValues(
                    companyId.toString(), activePeriod.toString());
                saveRequestProperties(requestProperties);

                /// getCompany
                await getCompany(getRequestProperties()?.instituteCode ?? '',
                    (companyResponse) async {
                  companyResponseLocal = companyResponse;
                }, (error) {
                  companyResponseLocal = null;
                }).whenComplete(() async {
                  if (companyResponseLocal != null) {
                    /// getMobileLicenseUserMenus
                    await getMobileLicenseUserMenus(
                        (mobileLicenseMenuResponse) async {
                      mobileLicenseMenuResponseLocal =
                          mobileLicenseMenuResponse;
                    }, (error) {
                      mobileLicenseMenuResponseLocal = null;
                    }).whenComplete(() async {
                      if (mobileLicenseMenuResponseLocal != null) {
                        /// getTerminologies
                        await getTerminologies((terminologiesResponse) async {
                          terminologiesResponseLocal = terminologiesResponse;
                        }, (error) {
                          terminologiesResponseLocal = null;
                        }).whenComplete(() async {
                          if (terminologiesResponseLocal != null) {
                            /// getUserData
                            await getUserData((userResponse) {
                              userResponse = userResponse;
                            }, (error) {
                              userResponseLocal = null;
                            }).whenComplete(() {
                              if (userResponseLocal == null) {
                                initUserResponse = null;
                              } else {
                                initUserResponse =
                                    InitUserResponse(isSuccess: true);
                              }
                            });
                          }
                        });
                      }
                    });
                  }
                });
              }
            }
          });
        }
      });
    }
  });

  if (initUserResponse == null) {
    return InitUserResponse(isSuccess: false);
  } else {
    return InitUserResponse(isSuccess: true);
  }
}
