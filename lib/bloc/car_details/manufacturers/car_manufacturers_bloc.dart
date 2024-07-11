import 'package:base_flutter_bloc/base/component/base_bloc.dart';
import 'package:base_flutter_bloc/base/component/base_state.dart';
import 'package:base_flutter_bloc/bloc/car_details/manufacturers/car_manufacturers_bloc_event.dart';
import 'package:base_flutter_bloc/remote/models/car/manufacturers/car_manufacturers_response.dart';
import 'package:base_flutter_bloc/remote/repository/car_details/car_details_repository.dart';

class CarManufacturersBloc
    extends BaseBloc<CarManufacturersBlocEvent, BaseState> {
  CarManufacturersBloc() {
    on<CarManufacturersBlocEvent>((event, emit) async {
      switch (event) {
        case GetCarManufacturersEvent():
          emit(const LoadingState());
          await apiGetCarManufacturers(
            (response) => emit(DataState<List<Result>?>(response)),
            (errorMsg) async => emit(ErrorState(errorMsg)),
          );
          break;
        default:
          emit(const ErrorState('Unexpected Error! Please try again later!'));
          break;
      }
    });
  }
}
