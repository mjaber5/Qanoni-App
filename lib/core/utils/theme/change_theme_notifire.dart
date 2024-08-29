import 'package:flutter/material.dart';

class ThemeNotifier with ChangeNotifier {
  bool _isDarkTheme = true;

  bool get isLightTheme => _isDarkTheme;

  ThemeMode get currentTheme => _isDarkTheme ? ThemeMode.dark : ThemeMode.light;

  void toggleTheme(bool isDark) {
    _isDarkTheme = isDark;
    notifyListeners();
  }
}
