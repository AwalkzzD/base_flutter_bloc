import 'package:base_flutter_bloc/base/network/api_client/base_client.dart';
import 'package:base_flutter_bloc/remote/repository/user/user_repository.dart';

class UserProvider {
  UserProvider._();

  static UserRepository? _repository;

  static UserRepository get userRepository =>
      _repository ??= UserRepository(BaseClient());
}
