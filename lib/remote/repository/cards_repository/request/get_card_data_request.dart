import 'package:base_flutter_bloc/base/network/request/base_request.dart';
import 'package:base_flutter_bloc/remote/repository/cards_repository/response/card_data_response.dart';
import 'package:dio/dio.dart';

import '../../../../base/network/request/http_method.dart';
import '../../../utils/api_endpoints.dart';

class GetCardDataRequest extends BaseRequest {
  int entityId;
  String entityType;

  GetCardDataRequest({
    required this.entityId,
    required this.entityType,
  }) : super(
          endPoint:
              "${ApiEndpoints.cardsByType}/$entityType/entities/$entityId",
          decoder: (response) => cardDataResponseFromJson(response),
          httpMethod: HttpMethod.GET,
          responseType: ResponseType.plain,
        );
}
