import 'package:base_flutter_bloc/base/network/repository/remote_repository.dart';
import 'package:base_flutter_bloc/remote/repository/profile/request/get_profile_preferences_request.dart';
import 'package:base_flutter_bloc/remote/repository/profile/request/update_contact_request.dart';
import 'package:base_flutter_bloc/remote/repository/profile/response/user_profile_prefrences_response.dart';
import 'package:base_flutter_bloc/remote/repository/profile/response/user_profile_response.dart';
import 'package:base_flutter_bloc/remote/repository/user/request/get_user_profile_request.dart';

import '../../../base/network/response/error/error_response.dart';
import '../../../base/network/response/success/success_response.dart';

class ProfileRepository extends RemoteRepository {
  ProfileRepository(super.remoteDataSource);

  Future<void> apiGetUserProfilePreferences(
    Function(SuccessResponse<UserProfilePreferencesResponse>) onSuccess,
    Function(ErrorResponse) onError,
  ) async {
    final response =
        await dataSource.makeRequest<UserProfilePreferencesResponse>(
            GetProfilePreferencesRequest());

    response.fold((error) {
      onError(error);
    }, (success) {
      onSuccess(success);
    });
  }

  Future<void> apiGetUserProfile(
    int userId,
    Function(SuccessResponse<UserProfileResponse>) onSuccess,
    Function(ErrorResponse) onError,
  ) async {
    final response = await dataSource
        .makeRequest<UserProfileResponse>(GetUserProfileRequest());

    response.fold((error) {
      onError(error);
    }, (success) {
      onSuccess(success);
    });
  }

  Future<void> apiUpdateUserContact(
    int? userId,
    Map<String, dynamic>? data,
    Function(SuccessResponse<String>) onSuccess,
    Function(ErrorResponse) onError,
  ) async {
    final response = await dataSource.makeRequest<String>(
        UpdateContactRequest(userId: userId ?? 0, data: data ?? {}));

    response.fold((error) {
      onError(error);
    }, (success) {
      onSuccess(success);
    });
  }
}
