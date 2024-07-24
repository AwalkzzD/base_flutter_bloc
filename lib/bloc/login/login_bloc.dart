import 'dart:io';

import 'package:base_flutter_bloc/base/network/response/error/error_response.dart';
import 'package:base_flutter_bloc/base/src_bloc.dart';
import 'package:base_flutter_bloc/bloc/login/login_bloc_event.dart';
import 'package:base_flutter_bloc/bloc/login/login_provider.dart';
import 'package:base_flutter_bloc/remote/utils/oauth_dio.dart';
import 'package:base_flutter_bloc/utils/auth/auth_utils.dart';

class LoginBloc extends BaseBloc<LoginBlocEvent, BaseState> {
  AuthorizationResult? authorizationResult;

  LoginBloc() {
    on<LoginBlocEvent>((event, emit) async {
      if (event is LoadLoginPageEvent) {
        emit(const LoadingState());
        await LoginProvider.loginRepository.apiCreateAuthorizationRequest(
            (response) {
          authorizationResult = response.data;
          emit(DataState<AuthorizationResult>(response.data));
        }, (error) {
          emit(ErrorState((error as ErrorResponse).errorMsg));
        });
      } else if (event is LoadLoginAccessEvent) {
        emit(const LoadingState());
        await LoginProvider.loginRepository
            .apiLoadLoginAccess(event.codeVerifier, event.code, (response) {
          emit(DataState<OAuthToken>(response.data));
        }, (error) {
          emit(ErrorState((error as ErrorResponse).errorMsg));
        });
      } else if (event is DoLoginEvent) {
        emit(const LoadingState());
        await LoginProvider.loginRepository.apiDoLogin(event.cookieManager,
            (response) {
          emit(DataState<Cookie>(response.data));
        }, (error) {
          emit(ErrorState((error as ErrorResponse).errorMsg));
        });
      }
    });
  }
}
