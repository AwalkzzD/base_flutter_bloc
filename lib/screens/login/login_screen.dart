import 'dart:io';

import 'package:auto_route/auto_route.dart';
import 'package:base_flutter_bloc/base/routes/router/app_router.gr.dart';
import 'package:base_flutter_bloc/base/src_bloc.dart';
import 'package:base_flutter_bloc/bloc/login/login_bloc.dart';
import 'package:base_flutter_bloc/bloc/login/login_bloc_event.dart';
import 'package:base_flutter_bloc/remote/repository/settings/response/check_mobile_license_response.dart';
import 'package:base_flutter_bloc/remote/repository/user/response/check_user_type_response.dart';
import 'package:base_flutter_bloc/remote/repository/user/response/get_parent_child_educational_programs_response.dart';
import 'package:base_flutter_bloc/remote/repository/user/response/init_user_response.dart';
import 'package:base_flutter_bloc/remote/utils/api_endpoints.dart';
import 'package:base_flutter_bloc/remote/utils/oauth_dio.dart';
import 'package:base_flutter_bloc/utils/auth/auth_utils.dart';
import 'package:base_flutter_bloc/utils/common_utils/app_widgets.dart';
import 'package:base_flutter_bloc/utils/stream_helper/common_enums.dart';
import 'package:flutter/material.dart';
import 'package:webview_cookie_manager/webview_cookie_manager.dart';
import 'package:webview_flutter_plus/webview_flutter_plus.dart';

@RoutePage()
class LoginScreen extends BasePage {
  const LoginScreen({super.key});

  @override
  BasePageState<BasePage, BaseBloc<BaseEvent, BaseState>> getState() =>
      _LoginScreenState();
}

class _LoginScreenState extends BasePageState<LoginScreen, LoginBloc> {
  final LoginBloc _bloc = LoginBloc();

  late WebViewControllerPlus webViewController;
  final cookieManager = WebviewCookieManager();

  @override
  void onReady() {
    super.onReady();
    getBloc.add(LoadLoginPageEvent());
  }

  @override
  void initState() {
    initWebViewController();
    super.initState();
  }

  @override
  Widget buildWidget(BuildContext context) {
    return customBlocConsumer(
      onDataReturn: (state) {
        switch (state.data) {
          case AuthorizationResult authorizationResult:
            return WebViewWidget(controller: webViewController);
          default:
            return const SizedBox();
        }
      },
      onDataPerform: (state) async {
        switch (state.data) {
          case AuthorizationResult authorizationResult:
            webViewController.loadRequest((authorizationResult).authorizeUri);

          case OAuthToken oAuthToken:
            // getBloc().add(GetCompanyIdEvent());
            getBloc.add(InitUserApiLoginEvent());

          case InitUserResponse initUserResponse:
            getBloc.add(LoadCheckUserTypeEvent());

          case CheckUserTypeResponse checkUserTypeResponse:
            getBloc.add(CheckMobileLicenseEvent());

          case CheckMobileLicenseResponse checkMobileLicenseResponse:
            getBloc.add(GetParentChildAndEducationalProgramsEvent());

          case GetParentChildEducationalProgramsResponse
            getParentChildEducationalProgramsResponse:
            appBloc.refreshData();
            getBloc.add(DoLoginEvent(cookieManager));

          case Cookie cookie:
            navigateToNextScreen();
        }
      },
      onErrorPerform: (state) {
        router.navigate(const LoginRoute());
        showToast(state.errorMessage ?? 'Unexpected Error');
      },
    );
  }

  @override
  LoginBloc get getBloc => _bloc;

  void initWebViewController() {
    clearCookies();
    webViewController = WebViewControllerPlus()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..clearCache()
      ..clearLocalStorage()
      ..setUserAgent(
          "Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.9.0.4) Gecko/20100101 Firefox/4.0")
      ..setBackgroundColor(const Color(0x00000000))
      ..setNavigationDelegate(
        NavigationDelegate(
          onProgress: (int progress) {},
          onPageStarted: (String url) {
            showLoader();
          },
          onPageFinished: (String url) {
            hideLoader();
          },
          onHttpError: (HttpResponseError error) async {
            Uri? uri = error.request?.uri;
            if (uri != null) {
              String path = "${uri.scheme}://${uri.host}/";
              if (path.startsWith(ApiEndpoints.logInCallBack)) {
                String? code = Uri.splitQueryString(uri.fragment)['code'];
                //loadAccess(getBloc().authResult.value?.codeVerifier ?? "", code.toString());
              } else if (path.startsWith(ApiEndpoints.logOutCallBack)) {
                // clear shared prefs
              } else {
                //onError(error.toString());
              }
            }
          },
          onWebResourceError: (WebResourceError error) {},
          onNavigationRequest: (NavigationRequest request) async {
            Uri? uri = Uri.parse(request.url);
            String path = "${uri.scheme}://${uri.host}/";
            if (path.startsWith(ApiEndpoints.logInCallBack)) {
              String? code = Uri.splitQueryString(uri.fragment)['code'];

              getBloc.add(LoadLoginAccessEvent(
                  getBloc.authorizationResult?.codeVerifier ?? '',
                  code.toString()));

              return NavigationDecision.prevent;
            } else if (path.startsWith(ApiEndpoints.logOutCallBack)) {
              return NavigationDecision.prevent;
            } else {
              return NavigationDecision.navigate;
            }
          },
        ),
      );
  }

  void clearCookies() async {
    await cookieManager.clearCookies();
  }

  void navigateToNextScreen() {
    router.replace(HomeRoute(fromScreen: ScreenType.login));
  }
}
