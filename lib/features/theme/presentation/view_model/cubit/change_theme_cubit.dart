import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'change_theme_state.dart';

class ThemeCubit extends Cubit<ThemeState> {
  ThemeCubit() : super(ThemeState(ThemeMode.light)) {
    _loadThemeMode();
  }

  Future<void> _loadThemeMode() async {
    final prefs = await SharedPreferences.getInstance();
    final isDarkMode = prefs.getBool('isDarkMode') ?? false;
    emit(isDarkMode ? ThemeState(ThemeMode.dark) : ThemeState(ThemeMode.light));
  }

  Future<void> toggleTheme() async {
    if (state.themeMode == ThemeMode.light) {
      emit(ThemeState(ThemeMode.dark));
      await _saveThemeMode(true);
    } else {
      emit(ThemeState(ThemeMode.light));
      await _saveThemeMode(false);
    }
  }

  Future<void> _saveThemeMode(bool isDarkMode) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('isDarkMode', isDarkMode);
  }
}
