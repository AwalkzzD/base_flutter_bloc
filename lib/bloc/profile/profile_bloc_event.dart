import 'package:base_flutter_bloc/base/component/base_event.dart';

abstract class ProfileBlocEvent extends BaseEvent {}

class LoadUserProfilePrefEvent extends ProfileBlocEvent {}

class LoadUserProfileEvent extends ProfileBlocEvent {
  final bool isRefresh;

  LoadUserProfileEvent({this.isRefresh = false});
}
