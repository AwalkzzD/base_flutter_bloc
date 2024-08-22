import 'package:base_flutter_bloc/base/src_bloc.dart';
import 'package:base_flutter_bloc/bloc/todo/todo_bloc.dart';
import 'package:base_flutter_bloc/screens/dashboard/todo/widget_items/todos_item_widget.dart';
import 'package:base_flutter_bloc/utils/screen_utils/flutter_screen_util.dart';
import 'package:flutter/material.dart';

import '../../../remote/repository/todo/response/session_task_list_response.dart';
import '../../../utils/common_utils/app_widgets.dart';
import '../../../utils/constants/app_images.dart';
import '../../../utils/constants/app_styles.dart';
import '../../../utils/constants/app_theme.dart';
import '../../../utils/date/date_util.dart';
import '../../../utils/paginable/paginable_listview.dart';
import '../../../utils/paginable/widgets/paginate_error_widget.dart';
import '../../../utils/paginable/widgets/paginate_loading_indicator.dart';
import '../../../utils/widgets/bullet_view.dart';
import '../../../utils/widgets/image_view.dart';

class TodoScreen extends BasePage {
  final int? studentId;

  const TodoScreen({this.studentId, super.key});

  @override
  BasePageState<BasePage, BaseBloc<BaseEvent, BaseState>> getState() =>
      _TodoScreenState();
}

class _TodoScreenState extends BasePageState<TodoScreen, TodoBloc> {
  final TodoBloc _bloc = TodoBloc();

  DateTime? dateTime = DateTime.now();

  @override
  bool get enableBackPressed => false;

  @override
  void onReady() {
    loadInitData();
    super.onReady();
  }

  @override
  Widget buildWidget(BuildContext context) {
    return Container(
      padding: EdgeInsetsDirectional.symmetric(horizontal: 24.h),
      child: Column(
        children: [
          buildDatePicker(),
          Expanded(
            child: StreamBuilder<List<SessionTaskListResponse>>(
                stream: getBloc.tasksListStream,
                builder: (context, snapshot) {
                  if (snapshot.hasData && snapshot.data?.isNotEmpty == true) {
                    return buildTasksList(snapshot.data ?? []);
                  } else {
                    return const SizedBox();
                  }
                }),
          ),
        ],
      ),
    );
  }

  @override
  TodoBloc get getBloc => _bloc;

  void loadInitData() {
    getBloc.loadSessionsTask(widget.studentId);
  }

  Widget buildDatePicker() {
    return StreamBuilder<DateTime>(
        stream: getBloc.dateTimeStream,
        builder: (context, snapshot) {
          return Container(
            margin: EdgeInsetsDirectional.symmetric(vertical: 8.h),
            child: InkWell(
              onTap: onDatePick,
              child: Row(
                children: [
                  BulletView(
                    height: 16.h,
                    width: 16.h,
                  ),
                  Text(
                    SPDateUtils.format(
                            snapshot.data, SPDateUtils.FORMAT_DD_MMMM_YY) ??
                        "",
                    style: styleSmallDarkBlueMedium.copyWith(
                        color: themeOf().textPrimaryColor),
                  ),
                  Container(
                    padding: EdgeInsetsDirectional.only(start: 6.h),
                    child: ImageView(
                        image: AppImages.icDropDown,
                        imageType: ImageType.svg,
                        width: 10.h,
                        height: 6.h,
                        color: themeOf().iconColor),
                  )
                ],
              ),
            ),
          );
        });
  }

  void onDatePick() async {
    final DateTime? pickedDateTime = await showDatePicker(
      context: globalContext,
      initialDate: getBloc.dateTime.value,
      firstDate: DateTime(1900),
      lastDate: DateTime(2101),
    );
    if (pickedDateTime != null) {
      getBloc.dateTime.add(pickedDateTime);
      loadInitData();
    }
  }

  Widget buildTasksList(List<SessionTaskListResponse> tasks) {
    return Column(
      children: [
        SizedBox(height: 4.h),
        Expanded(
          child: PaginableListView.separated(
              isLastPage: getBloc.categoryPageData.isLastPage(),
              loadMore: () {
                return getBloc.loadSessionsTask(widget.studentId,
                    isPagination: true);
              },
              shrinkWrap: true,
              errorIndicatorWidget: (exception, tryAgain) =>
                  PaginateErrorWidget(exception, tryAgain),
              progressIndicatorWidget: const PaginateLoadingIndicatorWidget(),
              itemCount: tasks.length,
              itemBuilder: (context, index) {
                return TodosItemWidget(data: tasks[index]);
              },
              separatorBuilder: (BuildContext context, int index) {
                return SizedBox(height: 12.h);
              }),
        ),
      ],
    );
  }
}
