import 'package:base_flutter_bloc/base/src_bloc.dart';
import 'package:base_flutter_bloc/bloc/car_details/makes/car_makes_bloc_event.dart';
import 'package:base_flutter_bloc/remote/models/car/makes/car_makes_response.dart';
import 'package:base_flutter_bloc/remote/repository/car_details/car_details_repository.dart';

class CarMakesBloc extends BaseBloc<CarMakesBlocEvent, BaseState> {
  CarMakesBloc() {
    on<CarMakesBlocEvent>((event, emit) async {
      if (event is GetCarMakesEvent) {
        emit(const LoadingState());
        await apiGetCarMakes((response) {
          emit(DataState<List<Result>?>(response));
        }, (errorMsg) async {
          emit(ErrorState(errorMsg));
        });
      } else {
        emit(const ErrorState('Unexpected Error! Please try again later!'));
      }
    });
  }
}
