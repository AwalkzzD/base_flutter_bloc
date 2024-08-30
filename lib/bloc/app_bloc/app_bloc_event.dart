import 'package:base_flutter_bloc/base/component/base_event.dart';

import '../../remote/repository/user/response/student_relative_extended.dart';

abstract class AppBlocEvent extends BaseEvent {}

class GetSelectedStudentEvent extends AppBlocEvent {}

class SetSelectedStudentEvent extends AppBlocEvent {
  final StudentForRelativeExtended studentForRelativeExtended;

  SetSelectedStudentEvent({required this.studentForRelativeExtended});
}

class CheckConsentsEvent extends AppBlocEvent {}
