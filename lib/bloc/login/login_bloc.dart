import 'dart:developer';
import 'dart:io';

import 'package:base_flutter_bloc/base/src_bloc.dart';
import 'package:base_flutter_bloc/bloc/login/login_bloc_event.dart';
import 'package:base_flutter_bloc/bloc/login/login_provider.dart';
import 'package:base_flutter_bloc/remote/repository/user/response/init_user_response.dart';
import 'package:base_flutter_bloc/remote/repository/user/response/student_of_relative_response.dart';
import 'package:base_flutter_bloc/remote/utils/oauth_dio.dart';
import 'package:base_flutter_bloc/utils/auth/auth_utils.dart';
import 'package:base_flutter_bloc/utils/auth/user_common_api.dart';
import 'package:base_flutter_bloc/utils/auth/user_init_api.dart';
import 'package:bloc_concurrency/bloc_concurrency.dart';

class LoginBloc extends BaseBloc<LoginBlocEvent, BaseState> {
  AuthorizationResult? authorizationResult;
  String? companyId;
  String? activePeriod;
  List<StudentOfRelativeResponse>? studentList;

  LoginBloc() {
    on<LoginBlocEvent>((event, emit) async {
      switch (event) {
        /// LoadLoginPageEvent
        case LoadLoginPageEvent loadLoginPageEvent:
          emit(const LoadingState());
          log('Loading Login Page');
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

        /// InitUserApiLoginEvent
        case InitUserApiLoginEvent initUserApiLoginEvent:
          emit(const LoadingState());
          final response = await initUserAPI((response) {}, (error) {});
          if (response == null) {
            emit(const ErrorState('Something went wrong!'));
          } else {
            emit(DataState<InitUserResponse>(response));
          }

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
    }, transformer: sequential());
  }
}
