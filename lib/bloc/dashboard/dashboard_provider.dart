import 'package:base_flutter_bloc/remote/repository/announcement_central/announcement_central_repository.dart';

import '../../base/network/api_client/base_client.dart';

class DashboardProvider {
  DashboardProvider._();

  static BaseClient? _client;
  static AnnouncementCentralRepository? _repository;

  static get baseClient => _client ??= BaseClient();

  static AnnouncementCentralRepository get announcementCentralRepository =>
      _repository ??= AnnouncementCentralRepository(baseClient);
}
