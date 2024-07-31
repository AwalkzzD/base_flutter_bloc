import 'package:base_flutter_bloc/base/network/src_network.dart';
import 'package:base_flutter_bloc/remote/repository/settings/request/check_mobile_license_request.dart';
import 'package:base_flutter_bloc/remote/repository/settings/request/get_active_period_request.dart';
import 'package:base_flutter_bloc/remote/repository/settings/request/get_company_id_request.dart';
import 'package:base_flutter_bloc/remote/repository/settings/request/get_mobile_license_menu_request.dart';
import 'package:base_flutter_bloc/remote/repository/settings/response/app_settings_response.dart';
import 'package:base_flutter_bloc/remote/repository/settings/response/check_mobile_license_response.dart';
import 'package:base_flutter_bloc/remote/repository/settings/response/company_id_response.dart';
import 'package:base_flutter_bloc/remote/repository/settings/response/mobile_license_menu.dart';
import 'package:base_flutter_bloc/remote/repository/terminology/request/get_terminologies_request.dart';
import 'package:base_flutter_bloc/remote/repository/terminology/response/terminology_list_response.dart';
import 'package:base_flutter_bloc/utils/auth/request_properties.dart';
import 'package:base_flutter_bloc/utils/common_utils/shared_pref.dart';
import 'package:base_flutter_bloc/utils/stream_helper/settings_utils.dart';

class SettingsRepository extends RemoteRepository {
  SettingsRepository(super.remoteDataSource);

  Future<void> apiGetCompanyId(
    String? tenant,
    String? period,
    Function(SuccessResponse<CompanyIdResponse>) onSuccess,
    Function(ErrorResponse) onError,
  ) async {
    late GetCompanyIdRequest getCompanyIdRequest;

    if (tenant != null &&
        tenant.isNotEmpty &&
        period != null &&
        period.isNotEmpty) {
      getCompanyIdRequest =
          GetCompanyIdRequest(tenant: tenant, periodId: period);
    } else {
      RequestProperties? requestProperties = getRequestProperties();
      if (requestProperties != null) {
        getCompanyIdRequest = GetCompanyIdRequest(
            tenant: requestProperties.tenant,
            periodId: requestProperties.periodCode);
      }
    }
    final response =
        await dataSource.makeRequest<CompanyIdResponse>(getCompanyIdRequest);
    response.fold((error) {
      onError(error);
    }, (success) {
      onSuccess(success);
    });
  }

  Future<void> apiGetApplicationSettings(
    List<SettingsValue> settingValues,
    String? tenant,
    String? period,
    Function(SuccessResponse<List<AppSettingsResponse>>) onSuccess,
    Function(ErrorResponse) onError,
  ) async {
    final response = await dataSource.makeRequest<List<AppSettingsResponse>>(
        GetActivePeriodRequest(
            settingValues: settingValues, tenant: tenant, periodId: period));

    response.fold((error) {
      onError(error);
    }, (success) {
      onSuccess(success);
    });
  }

  Future<void> apiGetMobileLicenseUserMenus(
      Function(SuccessResponse<MobileLicenseMenuResponse>) onSuccess,
      Function(ErrorResponse) onError) async {
    final response = await dataSource
        .makeRequest<MobileLicenseMenuResponse>(GetMobileLicenseMenuRequest());

    response.fold((error) {
      onError(error);
    }, (success) {
      onSuccess(success);
    });
  }

  Future<void> apiGetTerminologies(
      Function(SuccessResponse<List<TerminologyListResponse>>) onSuccess,
      Function(ErrorResponse) onError) async {
    final response = await dataSource
        .makeRequest<List<TerminologyListResponse>>(GetTerminologiesRequest());

    response.fold((error) {
      onError(error);
    }, (success) {
      saveTerminologiesList(success.data);
      onSuccess(success);
    });
  }

  Future<void> apiCheckLicense(
      Function(SuccessResponse<CheckMobileLicenseResponse>) onSuccess,
      Function(ErrorResponse) onError) async {
    final response = await dataSource
        .makeRequest<CheckMobileLicenseResponse>(CheckMobileLicenseRequest());

    response.fold((error) {
      onError(error);
    }, (success) {
      onSuccess(success);
    });
  }
}
