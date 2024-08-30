import 'package:base_flutter_bloc/base/component/base_bloc.dart';
import 'package:base_flutter_bloc/bloc/announcements/unread/unread_announcements_bloc_event.dart';

import '../../../base/component/base_state.dart';
import '../../../remote/repository/announcements/announcement_central/response/announcements_list_response.dart';
import '../../../remote/repository/announcements/announcement_main/request/utils/announcements_request_params.dart';
import '../../../utils/common_utils/app_widgets.dart';
import '../../../utils/remote/pagination_data.dart';
import '../../../utils/remote/pagination_utils.dart';
import '../announcements_provider.dart';

class UnreadAnnouncementsBloc extends BaseBloc {
  PaginationData pageData = getPaginationHeader(null);

  List<AnnouncementsListResponse> announcementsListBloc =
      List.empty(growable: true);

  UnreadAnnouncementsBloc() {
    on<UnreadAnnouncementsBlocEvent>((event, emit) async {
      switch (event) {
        case LoadAnnouncementsBlocEvent loadAnnouncementsBlocEvent:
          emit(const LoadingState());
          await loadAnnouncements(
            isPagination: loadAnnouncementsBlocEvent.isPagination,
            isPullToRefresh: loadAnnouncementsBlocEvent.isPullToRefresh,
            onSuccess: () {
              emit(DataState(announcementsListBloc));
            },
            onError: () {
              emit(ErrorRetryState('Something went wrong!', () {
                loadAnnouncements();
              }));
            },
            onEmpty: () {
              emit(const EmptyDataState('emptyDataMessage'));
            },
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
      isRead: false,
    );
    // toDate: SPDateUtils.stringFormat(DateTime.now(),SPDateUtils.FORMAT_DD_MM_YYYY).toIso8601String());
    Map<String, dynamic>? data = requestParameters.toMap();
    await AnnouncementsProvider.announcementMainRepository
        .apiGetAnnouncements(data, (announcementListResponse, paginationData) {
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
