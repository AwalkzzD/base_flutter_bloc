import 'package:base_flutter_bloc/base/src_bloc.dart';
import 'package:base_flutter_bloc/bloc/car_details/car_details_provider.dart';
import 'package:base_flutter_bloc/bloc/car_details/makes/car_makes_bloc_event.dart';
import 'package:base_flutter_bloc/remote/repository/car_details/response/car_makes_response.dart'
    as car_makes;

class CarMakesBloc extends BaseBloc<CarMakesBlocEvent, BaseState> {
  CarMakesBloc() {
    on<CarMakesBlocEvent>((event, emit) async {
      if (event is GetCarMakesEvent) {
        emit(const LoadingState());
        await CarDetailsProvider.carDetailsRepository.apiGetCarMakes(
            (response) {
          emit(DataState<List<car_makes.Result>?>(response.data.results));
        }, (error) async {
          emit(ErrorState(error.errorMsg));
        });
      } else {
        emit(const ErrorState('Unexpected Error! Please try again later!'));
      }
    });
  }
}
