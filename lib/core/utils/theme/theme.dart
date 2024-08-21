import 'package:flutter/material.dart';
import 'package:qanoni/core/utils/constants/colors.dart';
import 'package:qanoni/core/utils/theme/custom_themes/appbar_theme.dart';
import 'package:qanoni/core/utils/theme/custom_themes/bottom_sheet_teme.dart';
import 'package:qanoni/core/utils/theme/custom_themes/checkbox_theme.dart';
import 'package:qanoni/core/utils/theme/custom_themes/chip_theme.dart';
import 'package:qanoni/core/utils/theme/custom_themes/elevated_button_theme.dart';
import 'package:qanoni/core/utils/theme/custom_themes/outlined_button_theme.dart';
import 'package:qanoni/core/utils/theme/custom_themes/text_field_theme.dart';
import 'package:qanoni/core/utils/theme/custom_themes/text_theme.dart';

class TAppTheme {
  TAppTheme._();

  static ThemeData lightTheme = ThemeData(
    useMaterial3: true,
    fontFamily: 'Poppins',
    brightness: Brightness.light,
    primaryColor: QColors.primary,
    scaffoldBackgroundColor: QColors.primary,
    textTheme: QTextTheme.lightTextTheme,
    elevatedButtonTheme: QElevatedButtonTheme.lightElevatedButtonTheme,
    chipTheme: QChipTheme.lightChipTheme,
    appBarTheme: QAppBarTheme.lightAppBarTheme,
    bottomSheetTheme: QBottomSheetTheme.lightBottomSheetTheme,
    outlinedButtonTheme: QOutLinedButtonTheme.lightOutlinedButtonTheme,
    inputDecorationTheme: QTextFormFieldTheme.lightInputDecorationTheme,
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
    appBarTheme: QAppBarTheme.darkAppBarTheme,
    bottomSheetTheme: QBottomSheetTheme.darkBottomSheetTheme,
    outlinedButtonTheme: QOutLinedButtonTheme.darkOutlinedButtonTheme,
    inputDecorationTheme: QTextFormFieldTheme.darkInputDecorationTheme,
    checkboxTheme: QCheckboxTheme.darkCheckboxTheme,
  );
}
