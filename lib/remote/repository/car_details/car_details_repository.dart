import 'package:base_flutter_bloc/remote/models/car/makes/car_makes_response.dart'
    as car_makes;
import 'package:base_flutter_bloc/remote/models/car/manufacturers/car_manufacturers_response.dart'
    as car_manufacturers;
import 'package:dio/dio.dart';

Future<void> apiGetCarManufacturers(
    Function(List<car_manufacturers.Result>?) onSuccess,
    Function(String) onError) async {
  try {
    var dio = Dio();
    var response = await dio.request(
      'https://vpic.nhtsa.dot.gov/api/vehicles/getallmanufacturers?format=json',
      options: Options(
        responseType: ResponseType.plain,
        method: 'GET',
      ),
    );

    if (response.statusCode == 200) {
      final carManufacturers =
          car_manufacturers.carManufacturersResponseFromJson(response.data);
      onSuccess(carManufacturers.results);
    } else {
      onError(response.statusMessage ?? 'Something went wrong');
    }
  } catch (ex) {
    onError(ex.toString());
  }
}

Future<void> apiGetCarMakes(Function(List<car_makes.Result>?) onSuccess,
    Function(String) onError) async {
  try {
    var dio = Dio();
    var response = await dio.request(
      'https://vpic.nhtsa.dot.gov/api/vehicles/getallmakes?format=json',
      options: Options(
        responseType: ResponseType.plain,
        method: 'GET',
      ),
    );

    if (response.statusCode == 200) {
      final carMakes = car_makes.carMakesResponseFromJson(response.data);
      onSuccess(carMakes.results);
    } else {
      onError(response.statusMessage ?? 'Something went wrong');
    }
  } catch (ex) {
    onError(ex.toString());
  }
}
