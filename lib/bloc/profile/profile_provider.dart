import 'package:base_flutter_bloc/base/network/api_client/base_client.dart';
import 'package:base_flutter_bloc/remote/repository/profile/profile_repository.dart';

class ProfileProvider {
  ProfileProvider._();

  static BaseClient? _client;
  static ProfileRepository? _repository;

  static get baseClient => _client ??= BaseClient();

  static ProfileRepository get profileRepository =>
      _repository ??= ProfileRepository(baseClient);
}
