import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:qanoni/core/utils/constants/colors.dart';
import 'package:qanoni/core/utils/constants/text_strings.dart';
import 'package:qanoni/core/utils/styles.dart';
import 'package:qanoni/core/utils/theme/change_theme_notifire.dart';

class SignupPasswordValidations extends StatelessWidget {
  final bool hasLowerCase;
  final bool hasUpperCase;
  final bool hasSpecialCharacters;
  final bool hasNumber;
  final bool hasMinLength;
  const SignupPasswordValidations({
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
      padding: const EdgeInsets.only(top: 20.0, bottom: 20),
      child: Column(
        children: [
          buildValidationRow(
              QTexts.signupPasswordValidationAtLeastOneLowerCaseLetter,
              hasLowerCase,
              isLight),
          const SizedBox(height: 2),
          buildValidationRow(
              QTexts.signupPasswordValidationAtLeastOneUpperCaseLetter,
              hasUpperCase,
              isLight),
          const SizedBox(height: 2),
          buildValidationRow(
              QTexts.signupPasswordValidationAtLeastOneSpecialCharacter,
              hasSpecialCharacters,
              isLight),
          const SizedBox(height: 2),
          buildValidationRow(QTexts.signupPasswordValidationAtLeastOneNumber,
              hasNumber, isLight),
          const SizedBox(height: 2),
          buildValidationRow(
              QTexts.signupPasswordValidationAtLeastEightCharactersLong,
              hasMinLength,
              isLight),
        ],
      ),
    );
  }

  Widget buildValidationRow(String text, bool hasValidated, bool isLight) {
    return Row(
      children: [
        CircleAvatar(
          radius: 2.5,
          backgroundColor: isLight ? QColors.darkGrey : QColors.darkerGrey,
        ),
        const SizedBox(width: 6),
        Text(
          text,
          style: Styles.textStyle14.copyWith(
            decoration: hasValidated ? TextDecoration.lineThrough : null,
            decorationColor: Colors.green,
            decorationThickness: 2,
            color: isLight
                ? hasValidated
                    ? QColors.darkGrey
                    : QColors.grey
                : hasValidated
                    ? QColors.darkGrey
                    : QColors.darkerGrey,
          ),
        )
      ],
    );
  }
}
