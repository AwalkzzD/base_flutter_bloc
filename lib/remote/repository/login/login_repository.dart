import 'dart:io';

import 'package:base_flutter_bloc/base/network/repository/remote_repository.dart';
import 'package:base_flutter_bloc/base/network/response/error/error_response.dart';
import 'package:base_flutter_bloc/base/network/response/success/success_response.dart';
import 'package:base_flutter_bloc/env/environment.dart';
import 'package:base_flutter_bloc/remote/utils/api_endpoints.dart';
import 'package:base_flutter_bloc/remote/utils/oauth_dio.dart';
import 'package:base_flutter_bloc/remote/utils/remote_utils.dart';
import 'package:base_flutter_bloc/utils/auth/auth_utils.dart';
import 'package:collection/collection.dart';
import 'package:webview_cookie_manager/webview_cookie_manager.dart';

class LoginRepository extends RemoteRepository {
  LoginRepository(super.remoteDataSource);

  Future<void> apiCreateAuthorizationRequest(
      Function(SuccessResponse<AuthorizationResult>) onSuccess,
      Function(ErrorResponse) onError) async {
    final response = await createAuthorizationRequest();

    if (response.authorizeUri.path.isNotEmpty) {
      onSuccess(SuccessResponse(200, response));
    } else {
      onError(ErrorResponse(-1, 'Authorize uri path empty'));
    }
  }

  Future<void> apiLoadLoginAccess(
    String codeVerifier,
    String code,
    Function(SuccessResponse<OAuthToken>) onSuccess,
    Function(ErrorResponse) onError,
  ) async {
    String ipAddress = await getPublicIP();
    print('IP Address -> $ipAddress');
    final response = await getAccessToken(codeVerifier, code, ipAddress);

    print('OAuthToken --> $response');

    if (response != null) {
      onSuccess(SuccessResponse(200, response));
    } else {
      onError(ErrorResponse(-1, 'OAuthToken is null'));
    }
  }

  Future<void> apiDoLogin(
    WebviewCookieManager cookieManager,
    Function(SuccessResponse<Cookie>) onSuccess,
    Function(ErrorResponse) onError,
  ) async {
    print('Getting Cookies');
    final cookies =
        await cookieManager.getCookies(ApiEndpoints.identityServerUri);
    Cookie? cookie =
        cookies.firstWhereOrNull((element) => element.name == "_culture_main");

    print('Printing Cookie --> ${cookie?.name}');

    if (cookie != null) {
      onSuccess(SuccessResponse(200, cookie));
    } else {
      onError(ErrorResponse(-1, 'Cannot get login cookies'));
    }
  }

  Future<OAuthToken>? getAccessToken(
      String codeVerifier, String code, String ipAddress) {
    final oauth = Environment().config?.oauth;
    return oauth?.requestTokenAndSave(CodeGrant(
        ipAddress: ipAddress,
        code: code,
        redirect_uri: ApiEndpoints.logInCallBack,
        code_verifier: codeVerifier));
  }
}
