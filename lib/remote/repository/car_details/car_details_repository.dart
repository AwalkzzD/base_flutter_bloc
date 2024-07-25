import 'package:base_flutter_bloc/base/network/src_network.dart';
import 'package:base_flutter_bloc/remote/repository/car_details/request/get_car_makes_request.dart';
import 'package:base_flutter_bloc/remote/repository/car_details/request/get_car_manufacturers_request.dart';
import 'package:base_flutter_bloc/remote/repository/car_details/response/car_makes_response.dart';
import 'package:base_flutter_bloc/remote/repository/car_details/response/car_manufacturers_response.dart';

class CarDetailsRepository extends RemoteRepository {
  CarDetailsRepository(super.remoteDataSource);

  Future<void> apiGetCarMakes(
      Function(SuccessResponse<CarMakesResponse>) onSuccess,
      Function(ErrorResponse) onError) async {
    final response =
        await dataSource.makeRequest<CarMakesResponse>(GetCarMakesRequest());
    response.fold((error) {
      onError(error);
    }, (success) {
      onSuccess(success);
    });
  }

  Future<void> apiGetCarManufacturers(
      Function(SuccessResponse<CarManufacturersResponse>) onSuccess,
      Function(ErrorResponse) onError) async {
    final response = await dataSource
        .makeRequest<CarManufacturersResponse>(GetCarManufacturersRequest());
    response.fold((error) {
      onError(error);
    }, (success) {
      onSuccess(success);
    });
  }
}
