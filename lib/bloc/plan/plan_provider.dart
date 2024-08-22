import 'package:base_flutter_bloc/remote/repository/calendar/calendar_repository.dart';

import '../../base/network/api_client/base_client.dart';

class PlanProvider {
  PlanProvider._();

  static BaseClient? _client;
  static CalendarRepository? _repository;

  static get baseClient => _client ??= BaseClient();

  static CalendarRepository get calendarRepository =>
      _repository ??= CalendarRepository(baseClient);
}
