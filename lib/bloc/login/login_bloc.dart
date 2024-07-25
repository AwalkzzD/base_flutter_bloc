import 'dart:io';

import 'package:base_flutter_bloc/base/src_bloc.dart';
import 'package:base_flutter_bloc/bloc/login/login_bloc_event.dart';
import 'package:base_flutter_bloc/bloc/login/login_provider.dart';
import 'package:base_flutter_bloc/remote/utils/oauth_dio.dart';
import 'package:base_flutter_bloc/utils/auth/auth_utils.dart';

class LoginBloc extends BaseBloc<LoginBlocEvent, BaseState> {
  AuthorizationResult? authorizationResult;

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

          /// DoLoginEvent
          case DoLoginEvent doLoginEvent:
            emit(const LoadingState());
            await LoginProvider.loginRepository
                .apiDoLogin(doLoginEvent.cookieManager, (response) {
              emit(DataState<Cookie>(response.data));
            }, (error) {
              emit(ErrorState((error).errorMsg));
            });

          /// DoLoginEvent
          case InitUserLoginEvent initUserLoginEvent:
            emit(const LoadingState());
        }
      },
    );
  }
}
