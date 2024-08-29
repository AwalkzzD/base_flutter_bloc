import 'package:base_flutter_bloc/remote/repository/announcements/announcement_main/announcement_main_repository.dart';

import '../../base/network/api_client/base_client.dart';

class AnnouncementsProvider {
  AnnouncementsProvider._();

  static BaseClient? _client;
  static AnnouncementMainRepository? _repository;

  static get baseClient => _client ??= BaseClient();

  static AnnouncementMainRepository get announcementMainRepository =>
      _repository ??= AnnouncementMainRepository(baseClient);
}
