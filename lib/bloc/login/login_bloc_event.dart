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

class GetCompanyIdEvent extends LoginBlocEvent {}

class GetActivePeriodEvent extends LoginBlocEvent {
  final String companyId;

  GetActivePeriodEvent(this.companyId);
}

class GetAcademicPeriodsEvent extends LoginBlocEvent {
  final String companyId;
  final String activePeriod;

  GetAcademicPeriodsEvent(this.companyId, this.activePeriod);
}

class GetCompanyEvent extends LoginBlocEvent {
  final String instituteCode;

  GetCompanyEvent(this.instituteCode);
}

class GetMobileLicenseMenuEvent extends LoginBlocEvent {}

class GetTerminologiesEvent extends LoginBlocEvent {}
