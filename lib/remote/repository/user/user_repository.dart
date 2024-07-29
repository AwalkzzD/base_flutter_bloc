import 'package:base_flutter_bloc/base/network/src_network.dart';
import 'package:base_flutter_bloc/remote/repository/user/request/get_academic_periods_request.dart';
import 'package:base_flutter_bloc/remote/repository/user/request/get_company_request.dart';
import 'package:base_flutter_bloc/remote/repository/user/response/academic_periods_response.dart';
import 'package:base_flutter_bloc/remote/repository/user/response/institute_response.dart';
import 'package:base_flutter_bloc/utils/remote/pagination_data.dart';
import 'package:base_flutter_bloc/utils/remote/pagination_utils.dart';

class UserRepository extends RemoteRepository {
  UserRepository(super.remoteDataSource);

  Future<void> apiGetAcademicPeriods(
    String? tenant,
    String? period,
    Function(SuccessResponse<List<AcademicPeriodResponse>>, PaginationData)
        onSuccess,
    Function(ErrorResponse) onError,
  ) async {
    final response = await dataSource.makeRequest<List<AcademicPeriodResponse>>(
        GetAcademicPeriodsRequest(tenant: tenant, periodId: period));
    response.fold((error) {
      onError(error);
    }, (success) {
      onSuccess(success, getPaginationHeader(success.rawResponse));
    });
  }

  Future<void> apiGetCompany(
    String? instituteCode,
    Function(SuccessResponse<InstituteResponse>) onSuccess,
    Function(ErrorResponse) onError,
  ) async {
    final response = await dataSource.makeRequest<InstituteResponse>(
        GetCompanyRequest(instituteCode: instituteCode));
    response.fold((error) {
      onError(error);
    }, (success) {
      onSuccess(success);
    });
  }
}
