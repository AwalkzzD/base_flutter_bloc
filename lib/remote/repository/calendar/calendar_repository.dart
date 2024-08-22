import 'package:base_flutter_bloc/base/network/repository/remote_repository.dart';
import 'package:base_flutter_bloc/base/network/response/error/error_response.dart';
import 'package:base_flutter_bloc/base/network/response/success/success_response.dart';
import 'package:base_flutter_bloc/remote/repository/calendar/request/get_calendar_events_request.dart';
import 'package:base_flutter_bloc/remote/repository/calendar/response/calender_list_response.dart';

import '../../../utils/remote/pagination_data.dart';
import '../../../utils/remote/pagination_utils.dart';

class CalendarRepository extends RemoteRepository {
  CalendarRepository(super.remoteDataSource);

  Future<void> apiGetCalenders(
    Map<String, dynamic>? data,
    Function(SuccessResponse<List<CalenderListResponse>>,
            PaginationData paginationData)
        onSuccess,
    Function(ErrorResponse) onError,
  ) async {
    final response = await dataSource.makeRequest<List<CalenderListResponse>>(
        GetCalendarEventsRequest(data: data));
    response.fold((error) {
      onError(error);
    }, (success) {
      onSuccess(success, getPaginationHeader(success.rawResponse));
    });
  }
}
