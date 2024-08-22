import 'package:base_flutter_bloc/base/network/src_network.dart';
import 'package:base_flutter_bloc/remote/repository/user/request/get_academic_periods_request.dart';
import 'package:base_flutter_bloc/remote/repository/user/request/get_company_request.dart';
import 'package:base_flutter_bloc/remote/repository/user/request/get_student_educational_programs_request.dart';
import 'package:base_flutter_bloc/remote/repository/user/request/get_students_relative_request.dart';
import 'package:base_flutter_bloc/remote/repository/user/request/get_user_data_request.dart';
import 'package:base_flutter_bloc/remote/repository/user/request/get_user_profile_request.dart';
import 'package:base_flutter_bloc/remote/repository/user/response/academic_periods_response.dart';
import 'package:base_flutter_bloc/remote/repository/user/response/institute_response.dart';
import 'package:base_flutter_bloc/remote/repository/user/response/student_educational_program_response.dart';
import 'package:base_flutter_bloc/remote/repository/user/response/student_of_relative_response.dart';
import 'package:base_flutter_bloc/remote/repository/user/response/user_profile_response.dart';
import 'package:base_flutter_bloc/remote/repository/user/response/user_response.dart';
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

  Future<void> apiGetUserData(
    Function(SuccessResponse<UserResponse>) onSuccess,
    Function(ErrorResponse) onError,
  ) async {
    final response =
        await dataSource.makeRequest<UserResponse>(GetUserDataRequest());

    response.fold((error) {
      onError(error);
    }, (success) {
      onSuccess(success);
    });
  }

  Future<void> apiGetStudentRelative(
    int? relativeId,
    List<String>? statusIds,
    Function(SuccessResponse<List<StudentOfRelativeResponse>>, PaginationData)
        onSuccess,
    Function(ErrorResponse) onError,
  ) async {
    final response =
        await dataSource.makeRequest<List<StudentOfRelativeResponse>>(
            GetStudentsRelativeRequest(
                relativeId: relativeId, statusIds: statusIds));

    response.fold((error) {
      onError(error);
    }, (success) {
      onSuccess(success, getPaginationHeader(success.rawResponse));
    });
  }

  Future<void> apiGetStudentEducationalProgram(
    int? studentId,
    int? pageNumber,
    Function(SuccessResponse<List<StudentEducationalProgramResponse>>,
            PaginationData)
        onSuccess,
    Function(ErrorResponse) onError,
  ) async {
    final response =
        await dataSource.makeRequest<List<StudentEducationalProgramResponse>>(
            GetStudentEducationalProgramsRequest(
                studentId: studentId, pageNumber: pageNumber));

    response.fold((error) {
      onError(error);
    }, (success) {
      onSuccess(success, getPaginationHeader(success.rawResponse));
    });
  }

  Future<void> apiGetUserProfile(
    Function(SuccessResponse<UserProfileResponse>) onSuccess,
    Function(ErrorResponse) onError,
  ) async {
    final response = await dataSource
        .makeRequest<UserProfileResponse>(GetUserProfileRequest());

    response.fold((error) {
      onError(error);
    }, (success) {
      onSuccess(success);
    });
  }

  /*Future<void> apiApplicationSettings(
    List<SettingsValue> settingValues,
    Function(SuccessResponse<List<AppSettingsResponse>>) onSuccess,
    Function(ErrorResponse) onError,
  ) async {
    Map<String, dynamic>? data = {
      "names": settingValues
          .map((value) => value.toString().split('.').last)
          .toList()
          .join(','),
    };
    final response = await dataSource
        .makeRequest<List<AppSettingsResponse>>(GetUserProfileRequest());
  }*/
}
