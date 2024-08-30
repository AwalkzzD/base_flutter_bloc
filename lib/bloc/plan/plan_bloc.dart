import 'package:base_flutter_bloc/base/src_bloc.dart';
import 'package:base_flutter_bloc/bloc/plan/plan_bloc_event.dart';
import 'package:base_flutter_bloc/bloc/plan/plan_provider.dart';
import 'package:base_flutter_bloc/utils/common_utils/app_widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rxdart/rxdart.dart';

import '../../remote/repository/calendar/request/utils/calender_request_params.dart';
import '../../remote/repository/calendar/response/calender_list_response.dart';
import '../../utils/common_utils/common_utils.dart';
import '../../utils/common_utils/shared_pref.dart';
import '../../utils/dropdown/dropdown_option_model.dart';
import '../../utils/remote/pagination_data.dart';
import '../../utils/remote/pagination_utils.dart';
import '../../utils/stream_helper/common_dropdowns.dart';
import '../app_bloc/app_bloc.dart';

class PlanBloc extends BaseBloc<PlanBlocEvent, BaseState> {
  late BehaviorSubject<List<CalenderListResponse>> calenderEvents;

  get calenderEventsStream => calenderEvents.stream;

  DateTime? startDateTime;
  DateTime? endDateTime;

  PlanBloc() {
    calenderEvents = BehaviorSubject<List<CalenderListResponse>>.seeded([]);
    BlocProvider.of<AppBloc>(globalContext).calenderType =
        BehaviorSubject<DropDownOptionModel>.seeded(
            optionsCalenderTypes().first);
    setCalendarViewType();
  }

  List<CalenderListResponse> events = [];

  PaginationData eventsPageData = getPaginationHeader(null);

  void setCalendarViewType() {
    String selectedText = getCalendarViewType();
    if (selectedText == string('common_labels.label_day')) {
      BlocProvider.of<AppBloc>(globalContext)
          .calenderType
          .add(optionsCalenderTypes()[0]);
    } else if (selectedText == string('common_labels.label_week')) {
      BlocProvider.of<AppBloc>(globalContext)
          .calenderType
          .add(optionsCalenderTypes()[1]);
    } else if (selectedText == string('common_labels.label_month')) {
      BlocProvider.of<AppBloc>(globalContext)
          .calenderType
          .add(optionsCalenderTypes()[2]);
    } else {
      BlocProvider.of<AppBloc>(globalContext)
          .calenderType
          .add(optionsCalenderTypes()[0]);
    }
  }

  Future<void> fetchCalenderEvents(int? studentId, bool initialLoad,
      Function(List<CalenderListResponse>) onSuccess) async {
    if (initialLoad) {
      events = [];
      eventsPageData = getPaginationHeader(null);
    }
    CalenderResourceParameters resourceParameters = CalenderResourceParameters(
        pageNumber: eventsPageData.currentPage + 1,
        fromDate: startDateTime,
        toDate: endDateTime,
        studentId: studentId);

    PlanProvider.calendarRepository.apiGetCalenders(resourceParameters.toMap(),
        (response, paginationData) {
      eventsPageData = paginationData;
      events.addAll(response.data);
      if (!eventsPageData.isLastPage()) {
        fetchCalenderEvents(studentId, false, onSuccess);
      } else {
        if (!calenderEvents.isClosed) {
          calenderEvents.add(events);
        }
        onSuccess.call(events);
      }
    }, (error) {
      showToast(error.errorMsg);
    });
  }
}
