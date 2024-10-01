import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:qanoni/features/languages/model/enums/languages_event_type.dart';

part 'app_language_state.dart';

class AppLanguageCubit extends Cubit<AppLanguageState> {
  AppLanguageCubit() : super(AppLanguageInitial());

  appLanguageFunction(LanguagesEventEnums eventType) {
    switch (eventType) {
      case LanguagesEventEnums.initialLanguage:
      case LanguagesEventEnums.arabicLanguage:
        break;
      case LanguagesEventEnums.englishLanguage:
    }
  }
}
