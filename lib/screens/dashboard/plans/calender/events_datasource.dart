import 'dart:ui';

import 'package:hexcolor/hexcolor.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';

import '../../../../remote/repository/calendar/response/calender_list_response.dart';

class EventsDataSource extends CalendarDataSource<CalenderListResponse> {
  EventsDataSource(List<CalenderListResponse> source) {
    appointments = source;
  }

  @override
  DateTime getStartTime(int index) {
    return _getCalenderData(index).startDate ?? DateTime.now();
  }

  @override
  DateTime getEndTime(int index) {
    return _getCalenderData(index).endDate ?? DateTime.now();
  }

  @override
  String getSubject(int index) {
    return _getCalenderData(index).subject ?? "";
  }

  @override
  Color getColor(int index) {
    return HexColor(_getCalenderData(index).eventCategory?.color ?? "#FFFFFF")
        as Color;
  }

  @override
  String getNotes(int index) {
    return _getCalenderData(index).eventCategory?.description ?? "";
  }

  @override
  bool isAllDay(int index) {
    return false;
  }

  CalenderListResponse _getCalenderData(int index) {
    final dynamic meeting = appointments![index];
    late final CalenderListResponse meetingData;
    if (meeting is CalenderListResponse) {
      meetingData = meeting;
    }
    return meetingData;
  }
}
