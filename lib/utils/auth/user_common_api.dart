import 'package:base_flutter_bloc/bloc/user/user_provider.dart';
import 'package:base_flutter_bloc/utils/guid/flutter_guid.dart';

void getCompanyId(Function(String?) onSuccess, Function(String) onError) {
  Guid guid = Guid("72bdc44f-c588-44f3-b6df-9aace7daafdd");
  UserProvider.userRepository.apiGetCompanyId(guid.value, "0", (response) {
    onSuccess.call(response.data.id);
  }, (error) {
    onError.call(error.errorMsg);
  });
}
