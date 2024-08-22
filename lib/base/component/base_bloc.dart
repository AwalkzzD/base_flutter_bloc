import 'package:base_flutter_bloc/base/component/base_event.dart';
import 'package:base_flutter_bloc/base/component/base_state.dart';
import 'package:base_flutter_bloc/utils/auth/request_properties.dart';
import 'package:base_flutter_bloc/utils/common_utils/shared_pref.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

abstract class BaseBloc<E extends BaseEvent, S extends BaseState>
    extends Bloc<E, S> {
  BaseBloc() : super(const InitialState() as S);

  RequestProperties? requestProperties;

  RequestProperties? getRequestPropertiesData() {
    if (requestProperties != null) {
      return requestProperties;
    } else {
      requestProperties = getRequestProperties();
      return requestProperties;
    }
  }

  int? getEntityId() {
    return getRequestPropertiesData()?.entityId;
  }

  bool? get isOtherUser =>
      isUserParent == false && isUserStudent == false && isUserTeacher == false;

  bool? get isUserParent => getRequestPropertiesData()?.isUserParent();

  bool? get isUserTeacher => getRequestPropertiesData()?.isUserTeacher();

  bool? get isUserStudent => getRequestPropertiesData()?.isUserStudent();
}
