import 'package:flutter/material.dart';

import '../constants/colors.dart';
import 'custom_themes/checkbox_theme.dart';
import 'custom_themes/chip_theme.dart';
import 'custom_themes/elevated_button_theme.dart';
import 'custom_themes/outlined_button_theme.dart';
import 'custom_themes/text_theme.dart';

class QAppTheme {
  QAppTheme._();

  static ThemeData lightTheme = ThemeData(
    useMaterial3: true,
    fontFamily: 'Poppins',
    brightness: Brightness.light,
    primaryColor: QColors.primary,
    scaffoldBackgroundColor: QColors.white,
    textTheme: QTextTheme.lightTextTheme,
    elevatedButtonTheme: QElevatedButtonTheme.lightElevatedButtonTheme,
    chipTheme: QChipTheme.lightChipTheme,
    outlinedButtonTheme: QOutLinedButtonTheme.lightOutlinedButtonTheme,
    checkboxTheme: QCheckboxTheme.lightCheckboxTheme,
  );
  static ThemeData darkTheme = ThemeData(
    useMaterial3: true,
    fontFamily: 'Poppins',
    brightness: Brightness.dark,
    primaryColor: QColors.primary,
    scaffoldBackgroundColor: QColors.primary,
    textTheme: QTextTheme.darkTextTheme,
    elevatedButtonTheme: QElevatedButtonTheme.darkElevatedButtonTheme,
    chipTheme: QChipTheme.darkChipTheme,
    outlinedButtonTheme: QOutLinedButtonTheme.darkOutlinedButtonTheme,
    checkboxTheme: QCheckboxTheme.darkCheckboxTheme,
  );
}
