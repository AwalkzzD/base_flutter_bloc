import 'package:base_flutter_bloc/bloc/theme/theme_bloc_event.dart';
import 'package:base_flutter_bloc/bloc/theme/theme_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ThemeBloc extends Bloc<ThemeBlocEvent, ThemeState> {
  ThemeBloc(super.initialState) {
    on<ThemeBlocEvent>((event, emit) {
      switch (event) {
        case ToggleDarkThemeEvent toggleDarkTheme:
          emit(ThemeState.darkTheme);
        case ToggleLightThemeEvent toggleLightTheme:
          emit(ThemeState.lightTheme);
      }
    });
  }
}
