import 'package:base_flutter_bloc/base/component/base_event.dart';

abstract class ContactInfoBlocEvent extends BaseEvent {}

class LoadUpdateUserProfileContactEvent extends ContactInfoBlocEvent {
  final Map<String, dynamic> data;

  LoadUpdateUserProfileContactEvent({required this.data});
}
