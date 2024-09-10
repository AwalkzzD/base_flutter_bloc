import 'package:base_flutter_bloc/base/component/base_event.dart';

abstract class TeacherBlocEvent extends BaseEvent {}

class LoadTeachersEvent extends TeacherBlocEvent {
  final bool isPagination;
  final bool isPullToRefresh;

  LoadTeachersEvent({
    this.isPagination = false,
    this.isPullToRefresh = false,
  });
}
