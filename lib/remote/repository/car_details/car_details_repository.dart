import 'package:base_flutter_bloc/base/network/response/base_response.dart';
import 'package:base_flutter_bloc/remote/api_manager/api_manager.dart';
import 'package:base_flutter_bloc/remote/api_manager/utils/app_endpoints.dart';
import 'package:base_flutter_bloc/remote/models/car/makes/car_makes_response.dart'
    as car_makes;
import 'package:base_flutter_bloc/remote/models/car/manufacturers/car_manufacturers_response.dart'
    as car_manufacturers;

Future<void> apiGetCarManufacturers(
    Function(List<car_manufacturers.Result>?) onSuccess,
    Function(String) onError) async {
  try {
    BaseResponse response = await getNetworkResource(
        endPoint: AppEndpoints.getCarManufacturers,
        queryParams: {"format": "json"});
    final carManufacturers =
        car_manufacturers.carManufacturersResponseFromJson(response.data);
    onSuccess(carManufacturers.results);
  } catch (ex) {
    onError(ex.toString());
  }
}

Future<void> apiGetCarMakes(Function(List<car_makes.Result>?) onSuccess,
    Function(String) onError) async {
  try {
    BaseResponse response = await getNetworkResource(
        endPoint: AppEndpoints.getCarMakes, queryParams: {"format": "json"});

    final carMakes = car_makes.carMakesResponseFromJson(response.data);
    onSuccess(carMakes.results);
  } catch (ex) {
    onError(ex.toString());
  }
}
