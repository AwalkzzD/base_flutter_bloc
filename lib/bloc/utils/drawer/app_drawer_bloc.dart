import 'package:base_flutter_bloc/base/src_bloc.dart';
import 'package:base_flutter_bloc/bloc/utils/drawer/app_drawer_bloc_event.dart';

class AppDrawerBloc extends BaseBloc<AppDrawerBlocEvent, BaseState> {
  AppDrawerBloc() {
    on<AppDrawerBlocEvent>((event, emit) {
      switch (event) {
        /// events
      }
    });
  }
}
