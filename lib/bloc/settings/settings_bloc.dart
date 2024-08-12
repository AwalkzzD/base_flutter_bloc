import 'package:base_flutter_bloc/base/component/base_bloc.dart';
import 'package:base_flutter_bloc/base/component/base_state.dart';
import 'package:base_flutter_bloc/bloc/settings/settings_bloc_event.dart';
import 'package:base_flutter_bloc/bloc/user/user_provider.dart';
import 'package:rxdart/rxdart.dart';

class SettingsBloc extends BaseBloc {
  BehaviorSubject<bool> isHideMyBirthdayOn = BehaviorSubject.seeded(false);

  SettingsBloc() {
    on<SettingsBlocEvent>((event, emit) async {
      emit(const LoadingState());
      switch (event) {
        case GetUserProfileEvent getUserProfileEvent:
          await UserProvider.userRepository.apiGetUserProfile((response) {
            if (response.data.hideBirthday != null) {
              if (!isHideMyBirthdayOn.isClosed) {
                isHideMyBirthdayOn.add(response.data.hideBirthday ?? false);
              }
            }
            emit(DataState(response.data));
          }, (error) {
            emit(ErrorState(error.errorMsg));
          });
      }
    });
  }
}
