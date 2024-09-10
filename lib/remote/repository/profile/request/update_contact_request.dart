import 'package:base_flutter_bloc/base/network/request/src_request.dart';
import 'package:dio/dio.dart';

import '../../../utils/api_endpoints.dart';

class UpdateContactRequest extends BaseRequest {
  final int userId;
  final Map<String, dynamic> data;

  UpdateContactRequest({required this.userId, required this.data})
      : super(
          endPoint:
              "${ApiEndpoints.user}/$userId/${ApiEndpoints.userProfileContact}",
          decoder: (response) => response.toString(),
          httpMethod: HttpMethod.PUT,
          responseType: ResponseType.plain,
          body: data,
        );

  @override
  String get contentType =>
      "application/vnd.cc.user.profile.contact.update.v1+json";
}
