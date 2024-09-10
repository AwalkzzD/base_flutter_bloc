import 'package:base_flutter_bloc/base/network/repository/remote_repository.dart';
import 'package:base_flutter_bloc/base/network/response/error/error_response.dart';
import 'package:base_flutter_bloc/base/network/response/success/success_response.dart';
import 'package:base_flutter_bloc/remote/repository/cards_repository/request/get_card_data_request.dart';

import 'response/card_data_response.dart';

class CardsRepository extends RemoteRepository {
  CardsRepository(super.remoteDataSource);

  Future<void> apiGetCardData(
    int? entityId,
    String? entityType,
    Function(SuccessResponse<CardDataResponse>) onSuccess,
    Function(ErrorResponse) onError,
  ) async {
    final response = await dataSource.makeRequest<CardDataResponse>(
        GetCardDataRequest(
            entityId: entityId ?? 0, entityType: entityType ?? '0'));

    response.fold((error) {
      onError(error);
    }, (success) {
      onSuccess(success);
    });
  }
}
