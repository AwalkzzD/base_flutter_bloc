import 'dart:convert';

import 'package:base_flutter_bloc/remote/repository/settings/response/mobile_license_menu.dart';
import 'package:base_flutter_bloc/remote/repository/terminology/response/terminology_list_response.dart';
import 'package:base_flutter_bloc/remote/repository/user/response/academic_periods_response.dart';
import 'package:base_flutter_bloc/remote/repository/user/response/institute_response.dart';
import 'package:base_flutter_bloc/remote/repository/user/response/student_relative_extended.dart';
import 'package:base_flutter_bloc/remote/repository/user/response/user_response.dart';
import 'package:base_flutter_bloc/utils/auth/request_properties.dart';
import 'package:base_flutter_bloc/utils/common_utils/sp_util.dart';

const String keyScaleFactor = "scaleFactor";
const String keyThemeMode = "theme";
const String keyTerminologies = "terminologies";
const String keyLangCode = "language";

const String keyLogin = "login";
const String keyAccessToken = "accessToken";
const String keyIdToken = "idToken";
const String keyRefreshToken = "refreshToken";
const String keyExpiration = "expiration";

const String keyFirebaseToken = "setFirebaseToken";

const String keyRequestProperties = "requestProperties";
const String keyMenu = "menu";
const String keyMobileMenu = "mobile_menu";
const String keyUser = "user";
const String keyInstitute = "institute";
const String keyAcademicPeriod = "academicPeriod";
const String keyAcademicPeriodList = "academicPeriodList";
const String keyStudentList = "studentList";
const String keyStudent = "student";
const String keyAuthenticationRequired = "authenticationRequired";
const String keyCalendarViewType = "calendarViewType";
const String keyDashboardElements = "dashboardElements";
const String keyNameSetting = "name_setting";

Future<void> sharedPrefClear() async {
  await SpUtil.clear();
}

/// Firebase Token
void setFirebaseToken(String? token) {
  SpUtil.putString(keyFirebaseToken, token);
}

String getFirebaseToken() {
  return SpUtil.getString(keyFirebaseToken);
}

/// Scale Factor
void setScaleFactor(double value) {
  SpUtil.putDouble(keyScaleFactor, value);
}

double getScaleFactor() {
  return SpUtil.getDouble(keyScaleFactor, defValue: 1.0);
}

double getScaleFactorHeight() {
  var scale = SpUtil.getDouble(keyScaleFactor, defValue: 1.0);
  return (scale < 1.0) ? 1.0 : scale;
}

/// Theme
void setThemeMode({required bool isDark}) {
  SpUtil.putBool(keyThemeMode, isDark);
}

bool getThemeMode() {
  return SpUtil.getBool(keyThemeMode, defValue: false);
}

/// authenticationRequired
void setAuthenticationRequired(bool value) {
  SpUtil.putBool(keyAuthenticationRequired, value);
}

bool getAuthenticationRequired() {
  return SpUtil.getBool(keyAuthenticationRequired, defValue: false);
}

/// Login
void setLogin(bool flag) {
  SpUtil.putBool(keyLogin, flag);
}

bool isLogin() {
  return SpUtil.getBool(keyLogin);
}

/// Access Token
void saveAccessToken(String? token) {
  SpUtil.putString(keyAccessToken, token);
}

String getAccessToken() {
  return SpUtil.getString(keyAccessToken);
}

/// Id Token
void saveIdToken(String? token) {
  SpUtil.putString(keyIdToken, token);
}

String getIdToken() {
  return SpUtil.getString(keyIdToken);
}

/// Refresh Token
void saveRefreshToken(String? token) {
  SpUtil.putString(keyRefreshToken, token);
}

String getRefreshToken() {
  return SpUtil.getString(keyRefreshToken);
}

/// ExpiryToken Time
void saveExpiryTokenTime(DateTime? dateTime) {
  if (dateTime != null) {
    SpUtil.putString(keyExpiration, dateTime.toString());
  } else {
    SpUtil.putString(keyExpiration, "");
  }
}

DateTime getExpiryTokenTime() {
  return DateTime.parse(SpUtil.getString(keyExpiration));
}

/// Language
void saveLanguage(String? code) {
  SpUtil.putString(keyLangCode, code);
}

String getLanguage() {
  return SpUtil.getString(keyLangCode, defValue: "en-GB");
}

/// Request Properties
void saveRequestProperties(RequestProperties? requestProperties) {
  SpUtil.putString(
      keyRequestProperties, json.encode(requestProperties?.toJson()));
}

RequestProperties? getRequestProperties() {
  RequestProperties? requestProperties =
      SpUtil.getObj(keyRequestProperties, (v) => RequestProperties.fromJson(v));
  return requestProperties;
}

/// academic period List
void saveAcademicPeriodList(List<AcademicPeriodResponse> menuList) {
  SpUtil.putObjectList(keyAcademicPeriodList, menuList);
}

List<AcademicPeriodResponse> getAcademicPeriodList() {
  return SpUtil.getObjList(
      keyAcademicPeriodList, (v) => AcademicPeriodResponse.fromJson(v!));
}

/// academic period
void saveAcademicPeriod(AcademicPeriodResponse academicPeriodResponse) {
  SpUtil.putObject(keyAcademicPeriod, academicPeriodResponse);
}

AcademicPeriodResponse? getAcademicPeriod() {
  AcademicPeriodResponse? userResponse = SpUtil.getObj(
      keyAcademicPeriod, (v) => AcademicPeriodResponse.fromJson(v));
  return userResponse;
}

/// Institute
void saveInstitute(InstituteResponse user) {
  SpUtil.putObject(keyInstitute, user);
}

InstituteResponse? getInstitute() {
  InstituteResponse? userResponse =
      SpUtil.getObj(keyInstitute, (v) => InstituteResponse.fromJson(v));
  return userResponse;
}

/// User
void saveUser(UserResponse user) {
  SpUtil.putObject(keyUser, user);
}

UserResponse? getUser() {
  UserResponse? userResponse =
      SpUtil.getObj(keyUser, (v) => UserResponse.fromJson(v));
  return userResponse;
}

/// StudentList
void saveStudentList(List<StudentForRelativeExtended> studentList) {
  List<StudentForRelativeExtended> uniqueItems = [];
  var uniqueIDs = studentList.map((e) => e.id).toSet();
  for (var e in uniqueIDs) {
    uniqueItems.add(studentList.firstWhere((i) => i.id == e));
  }

  SpUtil.putObjectList(keyStudentList, uniqueItems);
}

List<StudentForRelativeExtended> getStudentList() {
  return SpUtil.getObjList(
      keyStudentList, (v) => StudentForRelativeExtended.fromJson(v!));
}

/// Selected Student
void saveStudent(StudentForRelativeExtended user) {
  SpUtil.putObject(keyStudent, user);
}

StudentForRelativeExtended? getStudent() {
  StudentForRelativeExtended? userResponse =
      SpUtil.getObj(keyStudent, (v) => StudentForRelativeExtended.fromJson(v));
  return userResponse;
}

/// Terminologies
void saveTerminologiesList(List<TerminologyListResponse> menuList) {
  SpUtil.putObjectList(keyTerminologies, menuList);
}

List<TerminologyListResponse> getTerminologiesList() {
  return SpUtil.getObjList(
      keyTerminologies, (v) => TerminologyListResponse.fromJson(v!));
}

/// Mobile Menu
void saveMobileMenu(MobileLicenseMenuResponse user) {
  SpUtil.putObject(keyMobileMenu, user);
}

MobileLicenseMenuResponse? getMobileMenu() {
  MobileLicenseMenuResponse? userResponse = SpUtil.getObj(
      keyMobileMenu, (v) => MobileLicenseMenuResponse.fromJson(v));
  return userResponse;
}

/// Name Setting
void setNameSetting(bool? flag) {
  SpUtil.putBool(keyNameSetting, flag ?? false);
}

bool getNameSetting() {
  return SpUtil.getBool(keyNameSetting, defValue: false);
}

/// Dashboard Elements
void saveDashboardElements(String? code) {
  SpUtil.putString(keyDashboardElements, code);
}

String getDashboardElements() {
  return SpUtil.getString(keyDashboardElements);
}

/// Calendar Type
void saveCalendarViewType(String viewType) {
  SpUtil.putString(keyCalendarViewType, viewType);
}

String getCalendarViewType() {
  String viewType = SpUtil.getString(keyCalendarViewType);
  return viewType;
}
