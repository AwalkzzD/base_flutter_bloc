import 'package:base_flutter_bloc/base/src_bloc.dart';
import 'package:base_flutter_bloc/remote/repository/user/response/student_relative_extended.dart';

abstract class HomeBlocEvent extends BaseEvent {}

class GetLoginScreenApiData extends HomeBlocEvent {}

class GetSelectedStudentEvent extends HomeBlocEvent {}

class SetSelectedStudentEvent extends HomeBlocEvent {
  final StudentForRelativeExtended studentForRelativeExtended;

  SetSelectedStudentEvent({required this.studentForRelativeExtended});
}

class LoadQrSettingsEvent extends HomeBlocEvent {}

class LoadTerminologyEvent extends HomeBlocEvent {}

class CheckConsentsEvent extends HomeBlocEvent {}
