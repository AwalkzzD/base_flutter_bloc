import 'package:base_flutter_bloc/base/component/base_bloc.dart';
import 'package:base_flutter_bloc/base/component/base_state.dart';
import 'package:base_flutter_bloc/bloc/profile/profile_bloc_event.dart';
import 'package:base_flutter_bloc/bloc/profile/profile_provider.dart';
import 'package:base_flutter_bloc/remote/repository/profile/response/user_profile_response.dart';
import 'package:collection/collection.dart';
import 'package:rxdart/rxdart.dart';

import '../../utils/common_utils/shared_pref.dart';
import '../../utils/dropdown/dropdown_option_model.dart';
import '../../utils/localization/localization_utils.dart';

class ProfileBloc extends BaseBloc {
  BehaviorSubject<bool> isHideMyBirthdayOn = BehaviorSubject.seeded(false);

  late BehaviorSubject<List<DropDownOptionModel>> securityMethods;

  get securityMethodsStream => securityMethods.stream;

  late BehaviorSubject<List<DropDownOptionModel>> languages;

  get languagesStream => languages.stream;

  DropDownOptionModel? selectedLanguage;
  DropDownOptionModel? selectedSecurityMethod;

  ProfileBloc() {
    languages =
        BehaviorSubject<List<DropDownOptionModel>>.seeded(getLanguagesList);
    securityMethods = BehaviorSubject<List<DropDownOptionModel>>.seeded([]);

    on<ProfileBlocEvent>((event, emit) async {
      switch (event) {
        case LoadUserProfilePrefEvent loadUserProfilePrefEvent:
          emit(const LoadingState());
          await ProfileProvider.profileRepository.apiGetUserProfilePreferences(
            (response) {
              List<DropDownOptionModel> methods = response.data.contactMethods
                      ?.map((e) =>
                          DropDownOptionModel(key: e.id, value: e.description))
                      .toList() ??
                  [];

              add(LoadUserProfileEvent());
              if (!securityMethods.isClosed) {
                securityMethods.add(methods);
              }
            },
            (error) {
              emit(ErrorState(error.errorMsg));
            },
          );

        case LoadUserProfileEvent loadUserProfileEvent:
          if (loadUserProfileEvent.isRefresh) {
            emit(const OverlayLoadingState());
          } else {
            emit(const LoadingState());
          }
          await ProfileProvider.profileRepository.apiGetUserProfile(
            getRequestProperties()?.userId ?? 0,
            (response) {
              emit(DataState<UserProfileResponse>(response.data));
            },
            (error) {
              emit(ErrorState(error.errorMsg));
            },
          );
      }
    });
  }

  DropDownOptionModel? findSelectedLanguage(String? language) {
    return languages.value.firstWhereOrNull((e) => e.key == language);
  }

  List<DropDownOptionModel> get getLanguagesList => getDefaultLanguageList()
      .map((e) =>
          DropDownOptionModel(key: e.languageCode, value: e.languageTitle))
      .toList();

  DropDownOptionModel? findSelectedSecurityMethod(String? method) =>
      securityMethods.value.firstWhereOrNull((e) => e.value == method);
}
