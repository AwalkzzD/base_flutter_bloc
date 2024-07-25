import 'package:base_flutter_bloc/base/network/src_network.dart';
import 'package:base_flutter_bloc/remote/repository/settings/company_id_response.dart';
import 'package:base_flutter_bloc/remote/repository/user/response/init_user_response.dart';

class UserRepository extends RemoteRepository {
  UserRepository(super.remoteDataSource);

  apiInitUser(
    Function(SuccessResponse<InitUserResponse>) onSuccess,
    Function(ErrorResponse) onError,
  ) async {
    /*SuccessResponse<InitUserResponse>(200, InitUserResponse(isSuccess: true));
    ErrorResponse(-1, 'Something went wrong!');*/
  }

  void apiGetCompanyId(
      String? tenant,
      String? period,
      Function(SuccessResponse<CompanyIdResponse>) onSuccess,
      Function(ErrorResponse) onError) {}
}
