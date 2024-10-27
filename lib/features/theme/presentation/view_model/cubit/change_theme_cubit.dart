import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'change_theme_state.dart';

class ThemeCubit extends Cubit<ThemeState> {
  final SharedPreferences _prefs;

  ThemeCubit(this._prefs) : super(ThemeState(ThemeMode.light)) {
    _loadThemeMode();
  }

  void _loadThemeMode() {
    final isDarkMode = _prefs.getBool('isDarkMode') ?? false;
    emit(ThemeState(isDarkMode ? ThemeMode.dark : ThemeMode.light));
  }

  void toggleTheme() async {
    final isCurrentlyDark = state.themeMode == ThemeMode.dark;
    final newMode = isCurrentlyDark ? ThemeMode.light : ThemeMode.dark;

    if (state.themeMode != newMode) {
      emit(ThemeState(newMode));
      await _prefs.setBool('isDarkMode', !isCurrentlyDark);
    }
  }
}
