import 'package:base_flutter_bloc/base/component/base_bloc.dart';
import 'package:base_flutter_bloc/base/component/base_state.dart';
import 'package:base_flutter_bloc/bloc/contact_info/contact_info_bloc_event.dart';
import 'package:base_flutter_bloc/bloc/profile/profile_provider.dart';

import '../../utils/common_utils/shared_pref.dart';

class ContactInfoBloc extends BaseBloc {
  ContactInfoBloc() {
    on<ContactInfoBlocEvent>((event, emit) async {
      switch (event) {
        case LoadUpdateUserProfileContactEvent
          loadUpdateUserProfileContactEvent:
          emit(const OverlayLoadingState());
          await ProfileProvider.profileRepository.apiUpdateUserContact(
            getRequestProperties()?.userId,
            loadUpdateUserProfileContactEvent.data,
            (response) {
              emit(DataState(response.data));
            },
            (error) {
              emit(ErrorState(error.errorMsg));
            },
          );
      }
    });
  }
}
