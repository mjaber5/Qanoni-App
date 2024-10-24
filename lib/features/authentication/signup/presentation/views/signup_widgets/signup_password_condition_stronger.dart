import 'package:flutter/material.dart';
import '../../../../../../core/utils/constants/colors.dart';
import '../../../../../../core/utils/styles.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

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
    final localizations = AppLocalizations.of(context)!;

    return Padding(
      padding: const EdgeInsets.only(top: 20.0, bottom: 20),
      child: Column(
        children: [
          buildValidationRow(
              localizations.signupPasswordValidationAtLeastOneLowerCaseLetter,
              hasLowerCase),
          const SizedBox(height: 2),
          buildValidationRow(
              localizations.signupPasswordValidationAtLeastOneUpperCaseLetter,
              hasUpperCase),
          const SizedBox(height: 2),
          buildValidationRow(
              localizations.signupPasswordValidationAtLeastOneSpecialCharacter,
              hasSpecialCharacters),
          const SizedBox(height: 2),
          buildValidationRow(
              localizations.signupPasswordValidationAtLeastOneNumber,
              hasNumber),
          const SizedBox(height: 2),
          buildValidationRow(
              localizations.signupPasswordValidationAtLeastEightCharactersLong,
              hasMinLength),
        ],
      ),
    );
  }

  Widget buildValidationRow(String text, bool hasValidated) {
    return Row(
      children: [
        const CircleAvatar(
          radius: 2.5,
          backgroundColor: QColors.darkGrey,
        ),
        const SizedBox(width: 6),
        Text(
          text,
          style: Styles.textStyle14.copyWith(
              decoration: hasValidated ? TextDecoration.lineThrough : null,
              decorationColor: Colors.green,
              decorationThickness: 2,
              color: QColors.darkGrey),
        )
      ],
    );
  }
}
