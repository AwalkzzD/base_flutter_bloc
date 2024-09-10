import 'package:base_flutter_bloc/base/component/base_event.dart';

import '../../remote/repository/cards_repository/response/card_data_response.dart';
import '../../remote/repository/user/response/student_relative_extended.dart';

abstract class CardsBlocEvent extends BaseEvent {}

class LoadCardSettingsEvent extends CardsBlocEvent {
  final StudentForRelativeExtended? selectedStudent;

  LoadCardSettingsEvent({required this.selectedStudent});
}

class LoadCardDataEvent extends CardsBlocEvent {
  final StudentForRelativeExtended? selectedStudent;

  LoadCardDataEvent({required this.selectedStudent});
}

class LoadAllDataEvent extends CardsBlocEvent {
  final StudentForRelativeExtended? selectedStudent;
  final CardDataResponse cardDataResponse;

  LoadAllDataEvent({
    required this.selectedStudent,
    required this.cardDataResponse,
  });
}
