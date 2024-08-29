import 'package:base_flutter_bloc/base/network/src_network.dart';
import 'package:base_flutter_bloc/remote/repository/announcements/announcement_central/request/get_announcements_central_request.dart';
import 'package:base_flutter_bloc/remote/repository/announcements/announcement_central/response/detail/announcement_detail_response.dart';

import '../../../../utils/remote/pagination_data.dart';
import '../../../../utils/remote/pagination_utils.dart';

class AnnouncementCentralRepository extends RemoteRepository {
  AnnouncementCentralRepository(super.remoteDataSource);

  Future<void> apiGetAnnouncementsCentral(
    Map<String, dynamic>? data,
    Function(SuccessResponse<List<AnnouncementDetailResponse>>, PaginationData)
        onSuccess,
    Function(ErrorResponse) onError,
  ) async {
    final response =
        await dataSource.makeRequest<List<AnnouncementDetailResponse>>(
            GetAnnouncementsCentralRequest(data: data));

    response.fold((error) {
      onError(error);
    }, (success) {
      onSuccess(success, getPaginationHeader(success.rawResponse));
    });
  }
}
