import 'package:base_flutter_bloc/base/src_bloc.dart';
import 'package:base_flutter_bloc/bloc/announcements/announcements_bloc.dart';
import 'package:base_flutter_bloc/screens/announcements/tabs/read_tab_widget.dart';
import 'package:base_flutter_bloc/screens/announcements/tabs/unread_tab_widget.dart';
import 'package:base_flutter_bloc/utils/screen_utils/flutter_screen_util.dart';
import 'package:flutter/material.dart';

import '../../utils/appbar/appbar_back_button_no_shadow.dart';
import '../../utils/common_utils/common_utils.dart';
import '../../utils/screen_utils/keep_alive_widget.dart';
import '../../utils/widgets/custom_decoration.dart';
import '../../utils/widgets/custom_tabs/custom_tab_button.dart';

class AnnouncementsScreen extends BasePage {
  const AnnouncementsScreen({super.key});

  @override
  BasePageState<BasePage, BaseBloc<BaseEvent, BaseState>> get getState =>
      _AnnouncementsScreenState();
}

class _AnnouncementsScreenState
    extends BasePageState<AnnouncementsScreen, AnnouncementsBloc> {
  final AnnouncementsBloc _bloc = AnnouncementsBloc();

  List<Widget> screens = const [
    UnreadTabWidget(),
    ReadTabWidget(),
  ];

  List<String> tabs = [
    string('announcements.label_unread'),
    string('announcements.label_read'),
  ];

  @override
  Widget? get customAppBar => AppbarBackButtonNoShadow.build(
      title: string('announcements.label_announcements'),
      onBackPressed: () => router.pop());

  @override
  Widget buildWidget(BuildContext context) {
    return DefaultTabController(
      length: screens.length,
      child: Column(
        children: [
          Container(
            margin: EdgeInsets.only(bottom: 6.h),
            width: double.infinity,
            padding: EdgeInsetsDirectional.fromSTEB(12.h, 0, 12.h, 12.h),
            decoration: getAppBarShadowDecoration(),
            child: CustomTabButton(tabs),
          ),
          Expanded(
            child: TabBarView(
              children: List.generate(screens.length,
                  (index) => KeepAlivePage(child: screens[index])),
            ),
          ),
        ],
      ),
    );
  }

  @override
  AnnouncementsBloc get getBloc => _bloc;
}
