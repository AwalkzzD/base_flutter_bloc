import 'package:base_flutter_bloc/base/component/base_event.dart';

abstract class SubjectBlocEvent extends BaseEvent {}

class GetLearningSubjectsEvent extends SubjectBlocEvent {
  final int? periodId;
  final bool isPagination;
  final bool isPullToRefresh;

  GetLearningSubjectsEvent({
    this.periodId,
    this.isPullToRefresh = false,
    this.isPagination = false,
  });
}
