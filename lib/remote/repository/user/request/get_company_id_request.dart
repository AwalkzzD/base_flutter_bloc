import 'package:base_flutter_bloc/base/network/request/base_request.dart';
import 'package:base_flutter_bloc/base/network/request/http_method.dart';

class GetCompanyIdRequest extends BaseRequest {
  String tenant;
  String periodId;

  GetCompanyIdRequest(this.tenant, this.periodId)
      : super(endPoint: '', httpMethod: HttpMethod.GET);
}
