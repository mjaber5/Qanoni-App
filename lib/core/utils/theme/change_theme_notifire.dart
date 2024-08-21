import 'package:flutter/material.dart';

class ThemeNotifier with ChangeNotifier {
  bool _isLightTheme = false;

  bool get isLightTheme => _isLightTheme;

  ThemeMode get currentTheme =>
      _isLightTheme ? ThemeMode.light : ThemeMode.dark;

  void toggleTheme(bool isLight) {
    _isLightTheme = isLight;
    notifyListeners();
  }
}
