import 'package:base_flutter_bloc/base/network/api_client/base_client.dart';
import 'package:base_flutter_bloc/remote/repository/login/login_repository.dart';

class LoginProvider {
  LoginProvider._();

  static LoginRepository? _repository;

  static LoginRepository get loginRepository =>
      _repository ??= LoginRepository(BaseClient());
}
