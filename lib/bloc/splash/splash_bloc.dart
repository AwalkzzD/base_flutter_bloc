import 'package:base_flutter_bloc/base/src_bloc.dart';
import 'package:base_flutter_bloc/bloc/splash/splash_bloc_event.dart';
import 'package:base_flutter_bloc/utils/common_utils/shared_pref.dart';

class SplashBloc extends BaseBloc<SplashBlocEvent, BaseState> {
  SplashBloc() {
    on<SplashBlocEvent>((event, emit) {
      switch (event) {
        case CheckUserLoginStatus checkUserLoginStatus:
          emit(const LoadingState());
          try {
            if (isLogin()) {
              emit(const DataState<bool>(true));
            } else {
              emit(const DataState<bool>(false));
            }
          } catch (ex) {
            emit(ErrorState(ex.toString()));
          }
      }
    });
  }
}
