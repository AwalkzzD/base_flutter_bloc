import 'package:base_flutter_bloc/base/network/api_client/base_client.dart';
import 'package:base_flutter_bloc/remote/repository/user/user_repository.dart';

class UserProvider {
  UserProvider._();

  static BaseClient? _client;
  static UserRepository? _repository;

  static get baseClient => _client ??= BaseClient();

  static UserRepository get userRepository =>
      _repository ??= UserRepository(baseClient);
}
