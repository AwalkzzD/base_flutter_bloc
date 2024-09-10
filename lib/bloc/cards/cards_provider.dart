import 'package:base_flutter_bloc/remote/repository/cards_repository/cards_repository.dart';

import '../../base/network/api_client/base_client.dart';

class CardsProvider {
  CardsProvider._();

  static BaseClient? _client;
  static CardsRepository? _repository;

  static get baseClient => _client ??= BaseClient();

  static CardsRepository get cardsRepository =>
      _repository ??= CardsRepository(baseClient);
}
