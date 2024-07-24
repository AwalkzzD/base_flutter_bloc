import 'package:base_flutter_bloc/base/component/base_bloc.dart';
import 'package:base_flutter_bloc/base/component/base_state.dart';
import 'package:base_flutter_bloc/bloc/car_details/car_details_provider.dart';
import 'package:base_flutter_bloc/bloc/car_details/manufacturers/car_manufacturers_bloc_event.dart';
import 'package:base_flutter_bloc/remote/repository/car_details/response/car_manufacturers_response.dart'
    as car_manufacturers;

class CarManufacturersBloc
    extends BaseBloc<CarManufacturersBlocEvent, BaseState> {
  CarManufacturersBloc() {
    on<CarManufacturersBlocEvent>((event, emit) async {
      switch (event) {
        case GetCarManufacturersEvent():
          emit(const LoadingState());
          await CarDetailsProvider.carDetailsRepository.apiGetCarManufacturers(
              (response) {
            emit(DataState<List<car_manufacturers.Result>?>(
                response.data.results));
          }, (error) async {
            emit(ErrorState(error.errorMsg));
          });
          break;
        default:
          emit(const ErrorState('Unexpected Error! Please try again later!'));
          break;
      }
    });
  }
}
