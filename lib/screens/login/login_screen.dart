import 'dart:io';

import 'package:base_flutter_bloc/base/src_bloc.dart';
import 'package:base_flutter_bloc/bloc/login/login_bloc.dart';
import 'package:base_flutter_bloc/bloc/login/login_bloc_event.dart';
import 'package:base_flutter_bloc/remote/utils/api_endpoints.dart';
import 'package:base_flutter_bloc/remote/utils/oauth_dio.dart';
import 'package:base_flutter_bloc/screens/car_details/car_details_home_screen.dart';
import 'package:base_flutter_bloc/utils/auth/auth_utils.dart';
import 'package:flutter/material.dart';
import 'package:webview_cookie_manager/webview_cookie_manager.dart';
import 'package:webview_flutter_plus/webview_flutter_plus.dart';

class LoginScreen extends BasePage {
  const LoginScreen({super.key});

  @override
  BasePageState<BaseBloc<BaseEvent, BaseState>> getState() =>
      _LoginScreenState();
}

class _LoginScreenState extends BasePageState<LoginBloc> {
  final LoginBloc _bloc = LoginBloc();

  late WebViewControllerPlus webViewController;
  final cookieManager = WebviewCookieManager();

  @override
  void onReady() {
    super.onReady();
    getBloc().add(LoadLoginPageEvent());
  }

  @override
  void initState() {
    initWebViewController();
    super.initState();
  }

  @override
  Widget buildWidget(BuildContext context) {
    return getBlocListener(onDataState: (state) {
      if (state.data is OAuthToken) {
        getBloc().add(DoLoginEvent(cookieManager));
      } else if (state.data is Cookie) {
        navigateToNextScreen();
      }
    }, child: getBlocBuilder(
      onDataState: (state) {
        if (state.data is AuthorizationResult) {
          webViewController
              .loadRequest((state.data as AuthorizationResult).authorizeUri);
          return WebViewWidget(
            controller: webViewController,
          );
        } else {
          return const SizedBox();
        }
      },
    ));
  }

  @override
  LoginBloc getBloc() => _bloc;

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
          onPageStarted: (String url) {},
          onPageFinished: (String url) {},
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

              getBloc().add(LoadLoginAccessEvent(
                  getBloc().authorizationResult?.codeVerifier ?? '',
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
    Navigator.push(context,
        MaterialPageRoute(builder: (context) => const CarDetailsHomeScreen()));
  }
}
