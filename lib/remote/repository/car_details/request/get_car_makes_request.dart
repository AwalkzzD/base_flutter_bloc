import 'package:base_flutter_bloc/base/network/request/base_request.dart';
import 'package:base_flutter_bloc/base/network/request/http_method.dart';
import 'package:base_flutter_bloc/remote/repository/car_details/response/car_makes_response.dart';
import 'package:base_flutter_bloc/remote/utils/api_endpoints.dart';

class GetCarMakesRequest extends BaseRequest {
  GetCarMakesRequest()
      : super(
          endPoint: ApiEndpoints.getCarMakes,
          decoder: (data) => carMakesResponseFromJson(data),
          httpMethod: HttpMethod.GET,
        );

  @override
  Map<String, String> get queryParameters {
    return {"format": "json"};
  }
}
