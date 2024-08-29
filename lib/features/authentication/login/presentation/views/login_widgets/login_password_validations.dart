import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:qanoni/core/utils/constants/colors.dart';
import 'package:qanoni/core/utils/styles.dart';
import 'package:qanoni/core/utils/theme/change_theme_notifire.dart';

class LoginPasswordValidations extends StatelessWidget {
  final bool hasLowerCase;
  final bool hasUpperCase;
  final bool hasSpecialCharacters;
  final bool hasNumber;
  final bool hasMinLength;
  const LoginPasswordValidations({
    super.key,
    required this.hasLowerCase,
    required this.hasUpperCase,
    required this.hasSpecialCharacters,
    required this.hasNumber,
    required this.hasMinLength,
  });

  @override
  Widget build(BuildContext context) {
    bool isLight = context.watch<ThemeNotifier>().isLightTheme;

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 18),
      child: Column(
        children: [
          buildValidationRow(
              'At least 1 lowercase letter', hasLowerCase, isLight),
          const SizedBox(height: 2),
          buildValidationRow(
              'At least 1 uppercase letter', hasUpperCase, isLight),
          const SizedBox(height: 2),
          buildValidationRow(
              'At least 1 special character', hasSpecialCharacters, isLight),
          const SizedBox(height: 2),
          buildValidationRow('At least 1 number', hasNumber, isLight),
          const SizedBox(height: 2),
          buildValidationRow(
              'At least 8 characters long', hasMinLength, isLight),
        ],
      ),
    );
  }

  Widget buildValidationRow(String text, bool hasValidated, bool isLight) {
    return Row(
      children: [
        const CircleAvatar(
          radius: 2.5,
          backgroundColor: QColors.grey,
        ),
        const SizedBox(width: 6),
        Text(
          text,
          style: Styles.textStyle14.copyWith(
            decoration: hasValidated ? TextDecoration.lineThrough : null,
            decorationColor: Colors.green,
            decorationThickness: 2,
            color: isLight ? QColors.darkerGrey : QColors.grey,
          ),
        )
      ],
    );
  }
}
