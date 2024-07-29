import 'package:base_flutter_bloc/base/network/api_client/base_client.dart';
import 'package:base_flutter_bloc/remote/repository/settings/settings_repository.dart';

class SettingsProvider {
  SettingsProvider._();

  static BaseClient? _client;
  static SettingsRepository? _repository;

  static get baseClient => _client ??= BaseClient();

  static SettingsRepository get settingsRepository =>
      _repository ??= SettingsRepository(baseClient);
}
