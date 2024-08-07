abstract class AppBottomBarBlocEvent {}

class TabChangeEvent extends AppBottomBarBlocEvent {
  final int tabIndex;

  TabChangeEvent({required this.tabIndex});
}
