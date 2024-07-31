import 'dart:io';

import 'package:base_flutter_bloc/base/src_bloc.dart';
import 'package:base_flutter_bloc/bloc/login/login_bloc_event.dart';
import 'package:base_flutter_bloc/bloc/login/login_provider.dart';
import 'package:base_flutter_bloc/remote/repository/settings/response/app_settings_response.dart';
import 'package:base_flutter_bloc/remote/repository/settings/response/company_id_response.dart';
import 'package:base_flutter_bloc/remote/repository/settings/response/mobile_license_menu.dart';
import 'package:base_flutter_bloc/remote/repository/user/response/academic_periods_response.dart';
import 'package:base_flutter_bloc/remote/repository/user/response/institute_response.dart';
import 'package:base_flutter_bloc/remote/repository/user/response/student_of_relative_response.dart';
import 'package:base_flutter_bloc/remote/utils/oauth_dio.dart';
import 'package:base_flutter_bloc/utils/auth/auth_utils.dart';
import 'package:base_flutter_bloc/utils/auth/user_common_api.dart';
import 'package:base_flutter_bloc/utils/enum_to_string/enum_to_string.dart';
import 'package:base_flutter_bloc/utils/stream_helper/settings_utils.dart';
import 'package:collection/collection.dart';

class LoginBloc extends BaseBloc<LoginBlocEvent, BaseState> {
  AuthorizationResult? authorizationResult;
  String? companyId;
  String? activePeriod;
  List<StudentOfRelativeResponse>? studentList;

  LoginBloc() {
    on<LoginBlocEvent>(
      (event, emit) async {
        switch (event) {
          /// LoadLoginPageEvent
          case LoadLoginPageEvent loadLoginPageEvent:
            emit(const LoadingState());
            await LoginProvider.loginRepository.apiCreateAuthorizationRequest(
                (response) {
              authorizationResult = response.data;
              emit(DataState<AuthorizationResult>(response.data));
            }, (error) {
              emit(ErrorState((error).errorMsg));
            });

          /// LoadLoginAccessEvent
          case LoadLoginAccessEvent loadLoginAccessEvent:
            emit(const LoadingState());
            await LoginProvider.loginRepository.apiLoadLoginAccess(
                loadLoginAccessEvent.codeVerifier, loadLoginAccessEvent.code,
                (response) {
              emit(DataState<OAuthToken>(response.data));
            }, (error) {
              emit(ErrorState((error).errorMsg));
            });

          /// GetCompanyIdEvent
          case GetCompanyIdEvent getCompanyIdEvent:
            emit(const LoadingState());
            await getCompanyId(((response) {
              companyId = response?.id;
              emit(DataState<CompanyIdResponse?>(response));
            }), (error) {
              emit(ErrorState(error.errorMsg));
            });

          /// GetActivePeriodEvent
          case GetActivePeriodEvent getActivePeriodEvent:
            emit(const LoadingState());
            await getActivePeriod(getActivePeriodEvent.companyId, ((response) {
              AppSettingsResponse? activePeriodCode = response.firstWhereOrNull(
                  (element) =>
                      element.setting ==
                      EnumToString.convertToString(SettingsValue.ActivePeriod));
              if (activePeriodCode != null) {
                activePeriod = activePeriodCode.value.toString();
              } else {
                emit(const ErrorState('User Active Period not found.'));
              }
              emit(DataState<List<AppSettingsResponse>>(response));
            }), (error) {
              emit(ErrorState(error.errorMsg));
            });

          /// GetAcademicPeriodsEvent
          case GetAcademicPeriodsEvent getAcademicPeriodsEvent:
            emit(const LoadingState());
            await getUserAcademicPeriods(getAcademicPeriodsEvent.companyId,
                getAcademicPeriodsEvent.activePeriod, (response) {
              emit(DataState<List<AcademicPeriodResponse>>(response));
            }, (error) {
              emit(ErrorState(error.errorMsg));
            });

          /// GetCompanyEvent
          case GetCompanyEvent getCompanyEvent:
            emit(const LoadingState());
            await getCompany(getCompanyEvent.instituteCode, (response) {
              emit(DataState<InstituteResponse>(response));
            }, (error) {
              emit(ErrorState(error.errorMsg));
            });

          /// GetMobileLicenseMenuEvent
          case GetMobileLicenseMenuEvent getMobileLicenseMenuEvent:
            emit(const LoadingState());
            await getMobileLicenseUserMenus((response) {
              emit(DataState<MobileLicenseMenuResponse>(response));
            }, (error) {
              emit(ErrorState(error.errorMsg));
            });

          /// GetTerminologiesEvent
          case GetTerminologiesEvent getTerminologiesEvent:
            emit(const LoadingState());
            await getTerminologies((response) {
              emit(DataState(response));
            }, (error) {
              emit(ErrorState(error.errorMsg));
            });

          /// GetUserDataEvent
          case GetUserDataEvent getUserDataEvent:
            emit(const LoadingState());
            await getUserData((response) {
              emit(DataState(response));
            }, (error) {
              emit(ErrorState(error.errorMsg));
            });

          /// LoadCheckUserTypeEvent
          case LoadCheckUserTypeEvent loadCheckUserTypeEvent:
            emit(const LoadingState());
            await loadCheckUserType((response) {
              emit(DataState(response));
            }, (error) {
              emit(ErrorState(error.errorMsg));
            });

          /// CheckMobileLicenseEvent
          case CheckMobileLicenseEvent checkMobileLicenseEvent:
            emit(const LoadingState());
            await loadCheckMobileLicense((response) {
              emit(DataState(response));
            }, (error) {
              emit(ErrorState(error.errorMsg));
            });

          /// GetParentChildAndEducationalProgramsEvent
          case GetParentChildAndEducationalProgramsEvent
            getParentChildAndEducationalProgramsEvent:
            emit(const LoadingState());
            await loadGetParentChildAndEducationalPrograms(
                    (response) {}, (error) {})
                .then((response) {
              if (response.isSuccess) {
                emit(DataState(response));
              } else {
                emit(const ErrorState('Something went wrong!'));
              }
            }, onError: (error) {
              print(error.toString());
            });

          /// DoLoginEvent
          case DoLoginEvent doLoginEvent:
            emit(const LoadingState());
            await LoginProvider.loginRepository
                .apiDoLogin(doLoginEvent.cookieManager, (response) {
              emit(DataState<Cookie>(response.data));
            }, (error) {
              emit(ErrorState((error).errorMsg));
            });
        }
      },
    );
  }
}
