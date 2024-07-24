import 'package:base_flutter_bloc/base/network/repository/remote_repository.dart';
import 'package:base_flutter_bloc/base/network/response/error/error_response.dart';
import 'package:base_flutter_bloc/base/network/response/success/success_response.dart';
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
        await dataSource.getData<CarMakesResponse>(GetCarMakesRequest());
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
        .getData<CarManufacturersResponse>(GetCarManufacturersRequest());
    response.fold((error) {
      onError(error);
    }, (success) {
      onSuccess(success);
    });
  }
}
