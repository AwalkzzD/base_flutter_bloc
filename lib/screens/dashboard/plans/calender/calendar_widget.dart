import 'package:base_flutter_bloc/utils/screen_utils/flutter_screen_util.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:rxdart/rxdart.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';

import '../../../../remote/repository/calendar/response/calender_list_response.dart';
import '../../../../utils/constants/app_colors.dart';
import '../../../../utils/constants/app_styles.dart';
import '../../../../utils/constants/app_theme.dart';
import 'events_datasource.dart';

class CalendarWidget extends StatefulWidget {
  final ScrollController? scrollController;
  final CalendarView viewType;
  final List<CalenderListResponse> calenderEvents;
  final Function(ViewChangedDetails) onViewChanged;
  final Function(CalenderListResponse) onEventClick;

  const CalendarWidget(
      {super.key,
      required this.scrollController,
      required this.calenderEvents,
      required this.viewType,
      required this.onViewChanged,
      required this.onEventClick});

  @override
  State<CalendarWidget> createState() => _CalendarWidgetState();
}

class _CalendarWidgetState extends State<CalendarWidget> {
  final CalendarController _controller = CalendarController();

  late BehaviorSubject<List<CalenderListResponse>> calenderEvents;

  get calenderEventsStream => calenderEvents.stream;

  @override
  void initState() {
    super.initState();
    calenderEvents = BehaviorSubject<List<CalenderListResponse>>.seeded([]);
  }

  @override
  void dispose() {
    calenderEvents.close();
    super.dispose();
  }

  @override
  void didUpdateWidget(covariant CalendarWidget oldWidget) {
    super.didUpdateWidget(oldWidget);
    _controller.view = widget.viewType;
    if (!calenderEvents.isClosed) {
      calenderEvents.add([]);
    }
    if (oldWidget.viewType != widget.viewType) {
      _controller.displayDate = DateTime.now();
    } else {
      if (widget.viewType == CalendarView.day) {
        DateTime selectedDate = _controller.displayDate ?? DateTime.now();
        DateTime currentDate = DateTime.now();
        DateTime date1 =
            DateTime(selectedDate.year, selectedDate.month, selectedDate.day);
        DateTime date2 =
            DateTime(currentDate.year, currentDate.month, currentDate.day);
        if (date1.compareTo(date2) == 0) {
          _controller.displayDate = DateTime.now();
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    if (widget.viewType == CalendarView.month) {
      return Expanded(
        child: SingleChildScrollView(
          controller: widget.scrollController,
          physics: const AlwaysScrollableScrollPhysics(),
          child: Column(
            mainAxisSize: MainAxisSize.max,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [buildCalenderView(), buildMonthEventsView()],
          ),
        ),
      );
    } else {
      return Expanded(child: buildCalenderView());
    }
  }

  Widget buildCalenderView() {
    return Container(
      constraints: const BoxConstraints(minHeight: 1),
      child: SfCalendar(
        onTap: calendarTapped,
        firstDayOfWeek: 1,
        view: widget.viewType,
        timeSlotViewSettings: getTimeSlotSettings(),
        controller: _controller,
        dataSource: EventsDataSource(widget.calenderEvents),
        viewNavigationMode: ViewNavigationMode.snap,
        showDatePickerButton: true,
        showTodayButton: true,
        showNavigationArrow: true,
        showCurrentTimeIndicator: true,
        allowAppointmentResize: true,
        headerStyle: CalendarHeaderStyle(
            textStyle: styleSmall4.copyWith(color: themeOf().textPrimaryColor),
            textAlign: TextAlign.start,
            backgroundColor: themeOf().dropdownBgColor),
        viewHeaderStyle: ViewHeaderStyle(
            dayTextStyle:
                styleSmall3.copyWith(color: themeOf().textPrimaryColor),
            dateTextStyle:
                styleSmall3.copyWith(color: themeOf().textPrimaryColor)),
        cellBorderColor: themeOf().borderColor,
        todayTextStyle: styleSmall3SemiBold.copyWith(color: Colors.white),
        todayHighlightColor: themeOf().accentColor,
        onViewChanged: (ViewChangedDetails viewChangedDetails) {
          SchedulerBinding.instance.addPostFrameCallback((timeStamp) {
            _controller.selectedDate = null;
            widget.onViewChanged.call(viewChangedDetails);
          });
        },
        selectionDecoration: BoxDecoration(
          color: Colors.transparent,
          border: Border.all(color: primaryColor, width: 2),
          borderRadius: const BorderRadius.all(Radius.circular(4)),
          shape: BoxShape.rectangle,
        ),
        appointmentBuilder: (context, details) {
          return scheduleTypeWiseWidget(details);
        },
        monthViewSettings: MonthViewSettings(
            showAgenda: false,
            appointmentDisplayMode: MonthAppointmentDisplayMode.indicator,
            showTrailingAndLeadingDates: false,
            navigationDirection: MonthNavigationDirection.horizontal,
            monthCellStyle: MonthCellStyle(
              textStyle:
                  styleSmall3.copyWith(color: themeOf().textPrimaryColor),
              leadingDatesTextStyle:
                  styleSmall3.copyWith(color: themeOf().textPrimaryColor),
              trailingDatesTextStyle:
                  styleSmall3.copyWith(color: themeOf().textPrimaryColor),
              todayTextStyle:
                  styleSmall3.copyWith(color: themeOf().textPrimaryColor),
            ),
            dayFormat: 'EEE'),
      ),
    );
  }

  Widget scheduleTypeWiseWidget(CalendarAppointmentDetails details) {
    switch (widget.viewType) {
      case CalendarView.day:
        return scheduleDayWidget(details);
      case CalendarView.week:
        return eventWeekWidget(details);
      case CalendarView.month:
        return Container();
      case CalendarView.timelineDay:
        return eventWeekWidget(details);
      case CalendarView.workWeek:
        return Container();
      case CalendarView.timelineWeek:
        return Container();
      case CalendarView.timelineWorkWeek:
        return Container();
      case CalendarView.timelineMonth:
        return Container();
      case CalendarView.schedule:
        return Container();
    }
  }

  Widget scheduleDayWidget(CalendarAppointmentDetails details) {
    final CalenderListResponse event = details.appointments.first;
    return GestureDetector(
      onTap: () {
        widget.onEventClick.call(event);
      },
      child: Container(
        padding: EdgeInsetsDirectional.only(start: 8.h, end: 8.h),
        decoration: BoxDecoration(
          color: HexColor(event.eventCategory?.color ?? ""),
          borderRadius: BorderRadius.circular(4),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Flexible(
              child: Text(
                event.subject ?? "",
                maxLines: 3,
                overflow: TextOverflow.ellipsis,
                softWrap: false,
                style: styleSmall2MediumWhite.copyWith(
                    fontWeight: FontWeight.w700),
              ),
            ),
            Flexible(
              child: Text(
                event.eventCategory?.description ?? "",
                maxLines: 2,
                softWrap: false,
                overflow: TextOverflow.ellipsis,
                style: styleSmall2MediumWhite,
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget eventWeekWidget(CalendarAppointmentDetails details) {
    final CalenderListResponse event = details.appointments.first;
    return GestureDetector(
      onTap: () {
        widget.onEventClick.call(event);
      },
      child: Container(
        padding: EdgeInsetsDirectional.only(start: 2.h, end: 2.h),
        decoration: BoxDecoration(
          color: HexColor(event.eventCategory?.color ?? ""),
          borderRadius: BorderRadius.circular(4),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Flexible(
              child: Text(
                event.subject ?? "",
                maxLines: 3,
                overflow: TextOverflow.ellipsis,
                softWrap: false,
                style: styleSmall2.copyWith(
                    fontWeight: FontWeight.w700, color: Colors.white),
              ),
            ),
            Flexible(
              child: Text(
                event.eventCategory?.description ?? "",
                maxLines: 2,
                softWrap: false,
                overflow: TextOverflow.ellipsis,
                style: styleSmall2.copyWith(color: Colors.white),
              ),
            )
          ],
        ),
      ),
    );
  }

  TimeSlotViewSettings getTimeSlotSettings() {
    switch (widget.viewType) {
      case CalendarView.day:
        return TimeSlotViewSettings(
            timeTextStyle:
                styleSmall2.copyWith(color: themeOf().textPrimaryColor),
            timeInterval: const Duration(minutes: 30),
            timeFormat: "hh:mm a",
            minimumAppointmentDuration: const Duration(minutes: 10),
            timeIntervalHeight: 140.h);
      case CalendarView.week:
        return TimeSlotViewSettings(
            timeTextStyle:
                styleSmall2.copyWith(color: themeOf().textPrimaryColor),
            timeInterval: const Duration(minutes: 60),
            minimumAppointmentDuration: const Duration(minutes: 30),
            timeFormat: "h a",
            timeIntervalHeight: 100.h);
      case CalendarView.month:
        return const TimeSlotViewSettings();
      case CalendarView.timelineDay:
        return const TimeSlotViewSettings();
      case CalendarView.workWeek:
        return const TimeSlotViewSettings();
      case CalendarView.timelineWeek:
        return const TimeSlotViewSettings();
      case CalendarView.timelineWorkWeek:
        return const TimeSlotViewSettings();
      case CalendarView.timelineMonth:
        return const TimeSlotViewSettings();
      case CalendarView.schedule:
        return const TimeSlotViewSettings();
    }
  }

  void calendarTapped(CalendarTapDetails calendarTapDetails) {
    if (!calenderEvents.isClosed) {
      calenderEvents.add([]);
    }
    if (calendarTapDetails.targetElement == CalendarElement.calendarCell) {
      if (!calenderEvents.isClosed) {
        if (calendarTapDetails.appointments != null) {
          List<CalenderListResponse> events =
              calendarTapDetails.appointments!.cast<CalenderListResponse>();
          calenderEvents.add(events);
        }
      }
    }
  }

  Widget buildMonthEventsView() {
    return StreamBuilder<List<CalenderListResponse>>(
        stream: calenderEventsStream,
        builder: (context, snapshot) {
          if (snapshot.hasData && snapshot.data?.isNotEmpty == true) {
            return Container(
              margin: EdgeInsetsDirectional.only(top: 4.h),
              child: ListView.separated(
                primary: false,
                padding: const EdgeInsets.all(2),
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: snapshot.data?.length ?? 0,
                itemBuilder: (BuildContext context, int index) {
                  if (snapshot.data?[index] != null) {
                    return InkWell(
                        onTap: () {
                          widget.onEventClick.call(snapshot.data![index]);
                        },
                        child: buildMonthEventItem(snapshot.data?[index]));
                  } else {
                    return const SizedBox();
                  }
                },
                separatorBuilder: (BuildContext context, int index) => Divider(
                  height: 4.h,
                  color: themeOf().dividerColor,
                ),
              ),
            );
          } else {
            return const SizedBox();
          }
        });
  }

  Widget buildMonthEventItem(CalenderListResponse? data) {
    return Container(
        padding: EdgeInsetsDirectional.symmetric(vertical: 2.h),
        color: HexColor(data?.eventCategory?.color ?? "#FFFFFF") as Color,
        child: ListTile(
          leading: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                DateFormat('hh:mm a').format(data?.startDate ?? DateTime.now()),
                textAlign: TextAlign.center,
                style: styleSmall2.copyWith(color: white),
              ),
              Text(
                DateFormat('hh:mm a').format(data?.endDate ?? DateTime.now()),
                textAlign: TextAlign.center,
                style: styleSmall2.copyWith(color: white),
              ),
            ],
          ),
          title: Text(
            data?.subject ?? "",
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            softWrap: false,
            textAlign: TextAlign.start,
            style: styleSmall3.copyWith(color: white),
          ),
          subtitle: Text(
            data?.eventCategory?.description ?? "",
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            softWrap: false,
            textAlign: TextAlign.start,
            style: styleSmall3.copyWith(color: white),
          ),
        ));
  }
}
