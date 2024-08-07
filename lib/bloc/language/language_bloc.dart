import 'package:base_flutter_bloc/base/component/base_bloc.dart';

import '../../utils/localization/language_model.dart';

class LanguageBloc extends BaseBloc {
  LanguageModel selectedLanguage = LanguageModel(
    id: 1,
    languageTitle: "English (en-GB)",
    languageCode: "en-GB",
    isSelected: false,
    isRTL: false,
  );
}
