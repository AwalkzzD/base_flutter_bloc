import 'package:base_flutter_bloc/base/src_bloc.dart';
import 'package:webview_cookie_manager/webview_cookie_manager.dart';

abstract class LoginBlocEvent extends BaseEvent {}

class LoadLoginPageEvent extends LoginBlocEvent {}

class LoadLoginAccessEvent extends LoginBlocEvent {
  final String codeVerifier;
  final String code;

  LoadLoginAccessEvent(this.codeVerifier, this.code);
}

class DoLoginEvent extends LoginBlocEvent {
  final WebviewCookieManager cookieManager;

  DoLoginEvent(this.cookieManager);
}
