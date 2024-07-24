import 'package:base_flutter_bloc/utils/auth/user_claim_helper.dart';
import 'package:base_flutter_bloc/utils/enum_to_string/enum_to_string.dart';

class RequestProperties {
  String userName = "";
  String tenant = "";
  int userId = 0;
  String instituteCode = "";
  String instituteLocale = "";
  UserTypes userType = UserTypes.Anonymous;
  int entityId = 0;
  String instituteId = "";
  String periodCode = "";

  Future<void> initializeValues(String instituteId, String periodCode) async {
    userName = await UserClaimsHelper.getUsername() ?? "";
    tenant = await UserClaimsHelper.getTenant() ?? "";
    userId = await UserClaimsHelper.getUserId();
    instituteCode = await UserClaimsHelper.getInstituteCode() ?? "";
    instituteLocale = await UserClaimsHelper.getInstituteLocale() ?? "";
    userType = await UserClaimsHelper.getEntityType();
    entityId = await UserClaimsHelper.getEntityId();

    this.instituteId = instituteId;
    this.periodCode = periodCode;
  }

  Future<void> initializePeriodCode(String periodCode) async {
    this.periodCode = periodCode;
  }

  Map<String, dynamic> toJson() {
    return {
      'userName': userName,
      'tenant': tenant,
      'userId': userId,
      'instituteCode': instituteCode,
      'instituteLocale': instituteLocale,
      'userType': EnumToString.convertToString(userType),
      'entityId': entityId,
      'instituteId': instituteId,
      'periodCode': periodCode,
    };
  }

  static RequestProperties fromJson(Map<dynamic, dynamic> json) {
    RequestProperties properties = RequestProperties();
    properties.userName = json['userName'];
    properties.tenant = json['tenant'];
    properties.userId = json['userId'];
    properties.instituteCode = json['instituteCode'];
    properties.instituteLocale = json['instituteLocale'];
    properties.userType =
        EnumToString.fromString(UserTypes.values, json['userType']) ??
            UserTypes.Anonymous;
    properties.entityId = json['entityId'];
    properties.instituteId = json['instituteId'];
    properties.periodCode = json['periodCode'];
    return properties;
  }

  bool isUserParent() {
    return userType == UserTypes.Parent;
  }

  bool isUserTeacher() {
    return userType == UserTypes.Teacher;
  }

  bool isUserStudent() {
    return userType == UserTypes.Student;
  }

  @override
  String toString() {
    return 'RequestProperties {\n'
        '  userName: $userName,\n'
        '  tenant: $tenant,\n'
        '  userId: $userId,\n'
        '  instituteCode: $instituteCode,\n'
        '  instituteLocale: $instituteLocale,\n'
        '  userType: $userType,\n'
        '  entityId: $entityId,\n'
        '  instituteId: $instituteId,\n'
        '  periodCode: $periodCode\n'
        '}';
  }
}
