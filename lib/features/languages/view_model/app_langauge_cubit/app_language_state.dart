part of 'app_language_cubit.dart';

sealed class AppLanguageState extends Equatable {
  const AppLanguageState();

  @override
  List<Object> get props => [];
}

final class AppLanguageInitial extends AppLanguageState {}

final class AppChangeLanguage extends AppLanguageState {
  final String? languageCode;

  const AppChangeLanguage({this.languageCode});
}
