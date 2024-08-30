import 'package:base_flutter_bloc/base/src_bloc.dart';
import 'package:base_flutter_bloc/bloc/announcements/unread/unread_announcements_bloc.dart';
import 'package:base_flutter_bloc/utils/screen_utils/flutter_screen_util.dart';
import 'package:flutter/material.dart';

import '../../../bloc/announcements/unread/unread_announcements_bloc_event.dart';
import '../../../remote/repository/announcements/announcement_central/response/announcements_list_response.dart';
import '../../../utils/constants/app_styles.dart';
import '../../../utils/constants/app_theme.dart';
import '../../../utils/paginable/paginable_listview.dart';
import '../../../utils/paginable/widgets/paginate_error_widget.dart';
import '../../../utils/paginable/widgets/paginate_loading_indicator.dart';
import '../widget/announcement_detail_item_widget.dart';

class UnreadTabWidget extends BasePage {
  const UnreadTabWidget({super.key});

  @override
  BasePageState<BasePage, BaseBloc<BaseEvent, BaseState>> get getState =>
      _UnreadTabWidgetState();
}

class _UnreadTabWidgetState
    extends BasePageState<UnreadTabWidget, UnreadAnnouncementsBloc> {
  final UnreadAnnouncementsBloc _bloc = UnreadAnnouncementsBloc();

  @override
  bool get enableBackPressed => false;

  @override
  bool get isRefreshEnable => true;

  @override
  Future<void> onRefresh() {
    getBloc.add(
        LoadAnnouncementsBlocEvent(isPagination: false, isPullToRefresh: true));
    return Future.value();
  }

  @override
  void onReady() {
    getBloc.add(LoadAnnouncementsBlocEvent());
    super.onReady();
  }

  @override
  Widget buildWidget(BuildContext context) {
    return customBlocConsumer(
      onDataReturn: (state) {
        switch (state.data) {
          case List<AnnouncementsListResponse> announcementsList:
            return PaginableListView.separated(
                padding: EdgeInsetsDirectional.only(top: 22.h, bottom: 24.h),
                isLastPage: getBloc.pageData.isLastPage(),
                loadMore: () async {
                  return getBloc
                      .add(LoadAnnouncementsBlocEvent(isPagination: true));
                },
                errorIndicatorWidget: (exception, tryAgain) =>
                    PaginateErrorWidget(exception, tryAgain),
                progressIndicatorWidget: const PaginateLoadingIndicatorWidget(),
                itemCount: announcementsList.length,
                itemBuilder: (context, index) {
                  return AnnouncementDetailItemWidget(
                    data: announcementsList[index],
                    titleStyle: styleSmall3SemiBold.copyWith(
                        color: themeOf().textPrimaryColor),
                    showButton: true,
                    readData: true,
                  );
                },
                separatorBuilder: (BuildContext context, int index) {
                  return SizedBox(height: 12.h);
                });
        }
      },
      onDataPerform: (state) {},
    );
  }

  @override
  UnreadAnnouncementsBloc get getBloc => _bloc;
}
