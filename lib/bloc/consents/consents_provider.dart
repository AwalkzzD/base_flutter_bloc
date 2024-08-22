import 'package:base_flutter_bloc/remote/repository/consents/consent_repository.dart';

import '../../base/network/api_client/base_client.dart';

class ConsentsProvider {
  ConsentsProvider._();

  static BaseClient? _client;
  static ConsentRepository? _repository;

  static get baseClient => _client ??= BaseClient();

  static ConsentRepository get consentRepository =>
      _repository ??= ConsentRepository(baseClient);
}
