import 'package:base_flutter_bloc/base/component/base_event.dart';

abstract class UnreadAnnouncementsBlocEvent extends BaseEvent {}

class LoadAnnouncementsBlocEvent extends UnreadAnnouncementsBlocEvent {
  final bool isPagination;
  final bool isPullToRefresh;

  LoadAnnouncementsBlocEvent({
    this.isPagination = false,
    this.isPullToRefresh = false,
  });
}
