import 'package:base_flutter_bloc/base/src_bloc.dart';
import 'package:base_flutter_bloc/utils/localization/language_model.dart';

abstract class LanguageBlocEvent extends BaseEvent {}

class ChangeLanguageEvent extends LanguageBlocEvent {
  final LanguageModel language;

  ChangeLanguageEvent({required this.language});
}

class LoadAllLanguagesEvent extends LanguageBlocEvent {}
