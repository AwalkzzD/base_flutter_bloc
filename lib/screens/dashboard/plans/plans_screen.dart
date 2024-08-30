import 'package:base_flutter_bloc/base/component/base_bloc.dart';
import 'package:base_flutter_bloc/base/component/base_event.dart';
import 'package:base_flutter_bloc/base/component/base_state.dart';
import 'package:base_flutter_bloc/bloc/plan/plan_bloc.dart';
import 'package:base_flutter_bloc/utils/screen_utils/flutter_screen_util.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';

import '../../../base/page/base_page.dart';
import '../../../remote/repository/calendar/response/calender_list_response.dart';
import '../../../utils/common_utils/common_utils.dart';
import '../../../utils/constants/app_styles.dart';
import '../../../utils/constants/app_theme.dart';
import '../../../utils/dropdown/custom_dropdown.dart';
import '../../../utils/dropdown/dropdown_option_model.dart';
import '../../../utils/stream_helper/common_dropdowns.dart';
import 'calender/calendar_widget.dart';

class PlanScreen extends BasePage {
  final int? studentId;

  const PlanScreen({this.studentId, super.key});

  @override
  BasePageState<BasePage, BaseBloc<BaseEvent, BaseState>> get getState =>
      _PlanScreenState();
}

class _PlanScreenState extends BasePageState<PlanScreen, PlanBloc> {
  final PlanBloc _bloc = PlanBloc();
  final ScrollController scrollController = ScrollController();

  @override
  bool get enableBackPressed => false;

  var viewType = CalendarView.day;

  CalendarView getCalenderStyle(DropDownOptionModel? data) {
    switch (data?.key) {
      case 0:
        return CalendarView.day;
      case 1:
        return CalendarView.week;
      case 2:
        return CalendarView.month;
      case 3:
        return CalendarView.timelineDay;
    }
    return CalendarView.day;
  }

  Widget calendarFilterWidget() {
    return SingleChildScrollView(
      controller: scrollController,
      physics: const AlwaysScrollableScrollPhysics(),
      child: Container(
          padding: EdgeInsets.symmetric(horizontal: 14.h, vertical: 4.h),
          margin: EdgeInsets.only(bottom: 12.h),
          decoration: BoxDecoration(
              color: Theme.of(context).cardTheme.color,
              border: Border.all(color: themeOf().cardBorderColor),
              borderRadius: const BorderRadius.all(Radius.circular(10))),
          child: Row(
            children: [
              Expanded(
                flex: isTablet() ? 5 : 4,
                child: Text(
                  string('common_labels.label_calendar'),
                  style:
                      styleSmall4.copyWith(color: themeOf().textPrimaryColor),
                ),
              ),
              Expanded(
                flex: isTablet() ? 3 : 4,
                child: StreamBuilder<DropDownOptionModel>(
                    stream: appBloc.calenderTypeStream,
                    builder: (context, calenderView) {
                      if (calenderView.hasData && calenderView.data != null) {
                        return CustomDropdown(
                          hint: string('attendance.label_select'),
                          initialValue: appBloc.calenderType.value,
                          isExpanded: false,
                          isDense: false,
                          items: optionsCalenderTypes(),
                          buttonStyleData: ButtonStyleData(
                            height: 32.h,
                            padding: EdgeInsetsDirectional.only(
                                start: 0, end: 12.h, top: 0, bottom: 0),
                            decoration: BoxDecoration(
                              border: Border(
                                bottom: BorderSide(
                                    color: themeOf().dropdownBorderColor),
                              ),
                            ),
                          ),
                          onClick: (DropDownOptionModel? data) {
                            if (!appBloc.calenderType.isClosed &&
                                data != null) {
                              appBloc.calenderType.add(data);
                            }
                          },
                        );
                      } else {
                        return const SizedBox();
                      }
                    }),
              ),
            ],
          )),
    );
  }

  @override
  void onReady() {}

  @override
  Widget buildWidget(BuildContext context) {
    return Container(
      padding: EdgeInsetsDirectional.fromSTEB(24.h, 20.h, 24.h, 0),
      child: Stack(
        children: [
          Column(
            children: [
              calendarFilterWidget(),
              StreamBuilder<DropDownOptionModel>(
                  stream: appBloc.calenderTypeStream,
                  builder: (context, calenderView) {
                    if (calenderView.hasData && calenderView.data != null) {
                      return StreamBuilder<List<CalenderListResponse>>(
                          stream: getBloc.calenderEventsStream,
                          builder: (context, snapshot) {
                            return CalendarWidget(
                              scrollController: scrollController,
                              viewType: getCalenderStyle(calenderView.data),
                              onViewChanged: (ViewChangedDetails details) {
                                if (details.visibleDates.isNotEmpty) {
                                  loadCalenderData(details.visibleDates.first,
                                      details.visibleDates.last);
                                }
                              },
                              calenderEvents: snapshot.data ?? [],
                              onEventClick: loadEventDetail,
                            );
                          });
                    } else {
                      return const SizedBox();
                    }
                  })
            ],
          ),
          /*StreamBuilder<bool>(
              stream: getBloc.isLoadingStream,
              builder: (context, snapshot) {
                if (snapshot.hasData && snapshot.data == true) {
                  return const Positioned.fill(
                      child: AbsorbPointer(child: CircularProgressIndicator()));
                } else {
                  return const SizedBox();
                }
              }),*/
        ],
      ),
    );
  }

  void loadCalenderData(DateTime? startDateTime, DateTime? endDateTime) {
    getBloc.startDateTime = startDateTime;
    getBloc.endDateTime = endDateTime;
    getBloc.fetchCalenderEvents(widget.studentId, true, (events) {});
  }

  void loadEventDetail(CalenderListResponse response) {
    /*Navigator.of(context, rootNavigator: true)
        .push(EventDetailScreen.route(response));*/
  }

  @override
  PlanBloc get getBloc => _bloc;
}
