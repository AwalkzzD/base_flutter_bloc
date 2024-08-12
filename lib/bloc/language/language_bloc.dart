import 'package:base_flutter_bloc/base/component/base_bloc.dart';
import 'package:base_flutter_bloc/base/component/base_state.dart';
import 'package:base_flutter_bloc/bloc/language/language_bloc_event.dart';

import '../../utils/localization/language_model.dart';
import '../../utils/localization/localization_utils.dart';

class LanguageBloc extends BaseBloc<LanguageBlocEvent, BaseState> {
  LanguageModel? selectedLanguage;
  List<LanguageModel>? languageList;

  LanguageBloc() {
    on<LanguageBlocEvent>((event, emit) {
      switch (event) {
        case LoadAllLanguagesEvent _:
          languageList = getDefaultLanguageList();
          emit(DataState<List<LanguageModel>>(languageList ?? []));
        case ChangeLanguageEvent changeLanguageEvent:
          selectedLanguage = changeLanguageEvent.language;
          emit(DataState<LanguageModel>(changeLanguageEvent.language));
      }
    });
  }
}
