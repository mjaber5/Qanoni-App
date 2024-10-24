import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LocaleState {
  final Locale locale;
  LocaleState(this.locale);
}

class LocaleCubit extends Cubit<LocaleState> {
  LocaleCubit() : super(LocaleState(const Locale('en'))) {
    _loadSavedLocale();
  }

  void setLocale(Locale locale) async {
    emit(LocaleState(locale));

    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('selected_locale', locale.languageCode);
  }

  Future<void> _loadSavedLocale() async {
    final prefs = await SharedPreferences.getInstance();
    final savedLocaleCode = prefs.getString('selected_locale');

    if (savedLocaleCode != null) {
      emit(
        LocaleState(
          Locale(savedLocaleCode),
        ),
      );
    }
  }
}
