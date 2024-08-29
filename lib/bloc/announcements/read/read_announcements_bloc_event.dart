import 'package:base_flutter_bloc/base/component/base_event.dart';

abstract class ReadAnnouncementsBlocEvent extends BaseEvent {}

class LoadAnnouncementsBlocEvent extends ReadAnnouncementsBlocEvent {
  final bool isPagination;
  final bool isPullToRefresh;

  LoadAnnouncementsBlocEvent({
    this.isPagination = false,
    this.isPullToRefresh = false,
  });
}
