import 'package:base_flutter_bloc/utils/common_utils/shared_pref.dart';
import 'package:jwt_decode_full/jwt_decode_full.dart';

class UserClaimsHelper {
  static const String TENANT = "tenant";
  static const String USERID = "profile";
  static const String USERNAME = "preferred_username";
  static const String INSTITUTEID = "instituteId";
  static const String INSTITUTELOCALE = "locale";
  static const String ENTITYTYPE = "role";
  static const String ENTITYID = "entityId";

  static Future<String?> getClaim(String claimId) async {
    String accessToken = getAccessToken();
    if (accessToken.isEmpty) return null;

    final jwtData = jwtDecode(accessToken);

    Map<String, dynamic> decodedToken = jwtData.payload;
    return decodedToken[claimId];
  }

  static Future<String?> getInstituteCode() async {
    String? instituteId = await getClaim(INSTITUTEID);
    if (instituteId == null || instituteId.isEmpty) {
      // throw an exception here
      throw Exception("Institute ID not found!");
    }
    return instituteId;
  }

  static Future<int> getUserId() async {
    String? userId = await getClaim(USERID);
    if (userId == null || userId.isEmpty) return 0;
    return int.tryParse(userId) ?? 0;
  }

  static Future<String?> getUsername() async {
    return await getClaim(USERNAME);
  }

  static Future<String?> getTenant() async {
    return await getClaim(TENANT);
  }

  static Future<String?> getInstituteLocale() async {
    return await getClaim(INSTITUTELOCALE);
  }

  static Future<UserTypes> getEntityType() async {
    String? entityType = await getClaim(ENTITYTYPE);
    if (entityType == null || entityType.isEmpty) return UserTypes.Anonymous;
    int type = int.tryParse(entityType) ?? 0;
    return findUserTypeFromId(int.tryParse(entityType) ?? 0);
  }

  static Future<int> getEntityId() async {
    String? entityId = await getClaim(ENTITYID);
    if (entityId == null || entityId.isEmpty) return 0;
    return int.tryParse(entityId) ?? 0;
  }

  static UserTypes findUserTypeFromId(int id) {
    switch (id) {
      case 1:
        return UserTypes.Admin;
      case 2:
        return UserTypes.Student;
      case 4:
        return UserTypes.Teacher;
      case 8:
        return UserTypes.Partner;
      case 16:
        return UserTypes.Secretary;
      case 32:
        return UserTypes.Parent;
      case 64:
        return UserTypes.Owner;
      case 128:
        return UserTypes.Classter;
      case 256:
        return UserTypes.Alumni;
      case 512:
        return UserTypes.Admission;
      case 1024:
        return UserTypes.Agent;
      case 8192:
        return UserTypes.Anonymous;
      case 16384:
        return UserTypes.ResourceOwner;
      default:
        return UserTypes.Anonymous;
    }
  }
}

enum UserTypes {
  Admin,
  Student,
  Teacher,
  Partner,
  Secretary,
  Parent,
  Owner,
  Classter,
  Alumni,
  Admission,
  Agent,
  Anonymous,
  ResourceOwner,
}

Future<bool> checkIfUserTypeSupportedAsync(UserTypes? userType) async {
  return !(userType == UserTypes.Alumni) &&
      !(userType == UserTypes.Admission) &&
      !(userType == UserTypes.Anonymous);
}
