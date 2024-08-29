import 'package:base_flutter_bloc/base/network/src_network.dart';
import 'package:base_flutter_bloc/remote/repository/announcements/announcement_main/request/get_announcement_list_request.dart';

import '../../../../utils/remote/pagination_data.dart';
import '../../../../utils/remote/pagination_utils.dart';
import '../announcement_central/response/announcements_list_response.dart';

class AnnouncementMainRepository extends RemoteRepository {
  AnnouncementMainRepository(super.remoteDataSource);

  Future<void> apiGetAnnouncements(
    Map<String, dynamic>? data,
    Function(SuccessResponse<List<AnnouncementsListResponse>>, PaginationData)
        onSuccess,
    Function(ErrorResponse) onError,
  ) async {
    final response =
        await dataSource.makeRequest<List<AnnouncementsListResponse>>(
            GetAnnouncementListRequest(data: data));

    response.fold((error) {
      onError(error);
    }, (success) {
      onSuccess(success, getPaginationHeader(success.rawResponse));
    });
  }
}
