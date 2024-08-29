import 'package:base_flutter_bloc/base/src_bloc.dart';
import 'package:base_flutter_bloc/bloc/dashboard/dashboard_bloc_event.dart';
import 'package:base_flutter_bloc/bloc/dashboard/dashboard_provider.dart';
import 'package:base_flutter_bloc/utils/common_utils/app_widgets.dart';
import 'package:rxdart/rxdart.dart';

import '../../base/network/response/error/error_response.dart';
import '../../remote/repository/announcements/announcement_central/request/utils/announcements_central_list_request_params.dart';
import '../../remote/repository/announcements/announcement_central/response/detail/announcement_detail_response.dart';
import '../../utils/remote/pagination_data.dart';
import '../../utils/remote/pagination_utils.dart';

class DashboardBloc extends BaseBloc<DashboardBlocEvent, BaseState> {
  PaginationData pageData = getPaginationHeader(null);

  late BehaviorSubject<List<AnnouncementDetailResponse>>
      announcementCentralList;

  get announcementCentralListStream => announcementCentralList.stream;

  DashboardBloc() {
    announcementCentralList =
        BehaviorSubject<List<AnnouncementDetailResponse>>.seeded([]);

    on<DashboardBlocEvent>((event, emit) async {
      switch (event) {
        /// LoadAnnouncementsCentralEvent
        case LoadAnnouncementsCentralEvent loadAnnouncementsCentralEvent:
          emit(const LoadingState());
          await loadAnnouncementsCentral(onSuccess: (response) {
            emit(DataState(response));
          }, onError: (error) {
            emit(ErrorState(error.errorMsg));
          });
      }
    });
  }

  Future<void> loadAnnouncementsCentral({
    bool isPagination = false,
    bool isPullToRefresh = false,
    required Function(List<AnnouncementDetailResponse>) onSuccess,
    required Function(ErrorResponse) onError,
  }) async {
    if (!isPagination && !isPullToRefresh) {
      pageData = getPaginationHeader(null);
    }

    AnnouncementCentralListParameters requestParameters =
        AnnouncementCentralListParameters(
      pageNumber: isPullToRefresh ? 1 : pageData.currentPage + 1,
    );

    Map<String, dynamic>? data = requestParameters.toMap();
    await DashboardProvider.announcementCentralRepository
        .apiGetAnnouncementsCentral(data, (response, paginationData) {
      if (!isPagination && !isPullToRefresh) {}
      pageData = paginationData;
      if (!announcementCentralList.isClosed) {
        if (pageData.currentPage == 1) {
          announcementCentralList.add(response.data);
          onSuccess(response.data);
        } else {
          List<AnnouncementDetailResponse> oldMessageList =
              announcementCentralList.value;
          oldMessageList.addAll(response.data);
          announcementCentralList.add(oldMessageList);
          onSuccess(oldMessageList);
        }
      }
    }, (error) {
      if (isPullToRefresh) {
        showToast(error.errorMsg);
      }
      if (isPagination) {
        throw Exception(error.errorMsg);
      }
      if (!isPagination && !isPullToRefresh) {}
      onError(error);
    });
  }
}
