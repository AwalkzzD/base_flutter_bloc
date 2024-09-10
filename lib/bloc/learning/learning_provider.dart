import 'package:base_flutter_bloc/remote/repository/learning/learning_repository.dart';

import '../../base/network/api_client/base_client.dart';

class LearningProvider {
  LearningProvider._();

  static BaseClient? _client;
  static LearningRepository? _repository;

  static get baseClient => _client ??= BaseClient();

  static LearningRepository get learningRepository =>
      _repository ??= LearningRepository(baseClient);
}
