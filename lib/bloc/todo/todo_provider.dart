import 'package:base_flutter_bloc/remote/repository/todo/todo_repository.dart';

import '../../base/network/api_client/base_client.dart';

class TodoProvider {
  TodoProvider._();

  static BaseClient? _client;
  static TodoRepository? _repository;

  static get baseClient => _client ??= BaseClient();

  static TodoRepository get todoRepository =>
      _repository ??= TodoRepository(baseClient);
}
