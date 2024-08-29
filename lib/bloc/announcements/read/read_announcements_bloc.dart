import 'package:base_flutter_bloc/base/src_bloc.dart';
import 'package:base_flutter_bloc/bloc/announcements/announcements_provider.dart';
import 'package:base_flutter_bloc/bloc/announcements/read/read_announcements_bloc_event.dart';
import 'package:base_flutter_bloc/utils/common_utils/app_widgets.dart';

import '../../../remote/repository/announcements/announcement_central/response/announcements_list_response.dart';
import '../../../remote/repository/announcements/announcement_main/request/utils/announcements_request_params.dart';
import '../../../utils/remote/pagination_data.dart';
import '../../../utils/remote/pagination_utils.dart';

class ReadAnnouncementsBloc extends BaseBloc {
  PaginationData pageData = getPaginationHeader(null);

  List<AnnouncementsListResponse> announcementsListBloc =
      List.empty(growable: true);

  ReadAnnouncementsBloc() {
    on<ReadAnnouncementsBlocEvent>((event, emit) {
      switch (event) {
        case LoadAnnouncementsBlocEvent loadAnnouncementsBlocEvent:
          loadAnnouncements(
            isPagination: loadAnnouncementsBlocEvent.isPagination,
            isPullToRefresh: loadAnnouncementsBlocEvent.isPullToRefresh,
            onSuccess: () {},
            onError: () {},
            onEmpty: () {},
          );
      }
    });
  }

  Future<void> loadAnnouncements({
    bool isPagination = false,
    bool isPullToRefresh = false,
    Function()? onSuccess,
    Function()? onEmpty,
    Function()? onError,
  }) async {
    if (!isPagination && !isPullToRefresh) {
      pageData = getPaginationHeader(null);
    }
    AnnouncementListParameters requestParameters = AnnouncementListParameters(
      pageNumber: isPullToRefresh ? 1 : pageData.currentPage + 1,
      isRead: true,
    );
    // toDate: SPDateUtils.stringFormat(DateTime.now(),SPDateUtils.FORMAT_DD_MM_YYYY).toIso8601String());
    Map<String, dynamic>? data = requestParameters.toMap();
    AnnouncementsProvider.announcementMainRepository.apiGetAnnouncements(data,
        (announcementListResponse, paginationData) {
      if (!isPagination && !isPullToRefresh) {
        onSuccess!();
        // hideLoading();
      }
      pageData = paginationData;
      if (announcementListResponse.data.isNotEmpty) {
        if (pageData.currentPage == 1) {
          announcementsListBloc.addAll(announcementListResponse.data);
          onSuccess!();
        } else {
          List<AnnouncementsListResponse> oldMessageList =
              announcementsListBloc;
          oldMessageList.addAll(announcementListResponse.data);
          announcementsListBloc.clear();
          announcementsListBloc.addAll(oldMessageList);
          onSuccess!();
        }
      } else {
        onEmpty!();
        // showEmpty(string("announcements.warning_no_announcement"));
      }
    }, (error) {
      if (isPullToRefresh) {
        showToast(error.errorMsg);
      }
      if (isPagination) {
        throw Exception(error.errorMsg);
      }
      if (!isPagination && !isPullToRefresh) {
        // hideLoading();
        onError!();
        /*showError(error.message.toString(), () {
          loadAnnouncements();
        });*/
      }
    });
  }
}
