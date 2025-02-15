import 'package:base_flutter_bloc/bloc/utils/bottom_bar/app_bottom_bar_bloc_event.dart';
import 'package:base_flutter_bloc/bloc/utils/bottom_bar/app_bottom_bar_bloc_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AppBottomBarBloc
    extends Bloc<AppBottomBarBlocEvent, AppBottomBarBlocState> {
  int currentIndex = 0;

  AppBottomBarBloc(super.initialState) {
    on<AppBottomBarBlocEvent>((event, emit) {
      switch (event) {
        case TabChangeEvent tabChangeEvent:
          currentIndex = tabChangeEvent.tabIndex;
          emit(AppBottomBarBlocState(tabIndex: tabChangeEvent.tabIndex));
      }
    });
  }
}
