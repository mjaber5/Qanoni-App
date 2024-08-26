import 'package:flutter/material.dart';
import 'package:qanoni/core/utils/constants/colors.dart';
import 'package:qanoni/core/utils/styles.dart';

class Lo extends StatelessWidget {
  final bool hasLowerCase;
  final bool hasUpperCase;
  final bool hasSpecialCharacters;
  final bool hasNumber;
  final bool hasMinLength;
  const Lo({
    super.key,
    required this.hasLowerCase,
    required this.hasUpperCase,
    required this.hasSpecialCharacters,
    required this.hasNumber,
    required this.hasMinLength,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 18),
      child: Column(
        children: [
          buildValidationRow('At least 1 lowercase letter', hasLowerCase),
          const SizedBox(height: 2),
          buildValidationRow('At least 1 uppercase letter', hasUpperCase),
          const SizedBox(height: 2),
          buildValidationRow(
              'At least 1 special character', hasSpecialCharacters),
          const SizedBox(height: 2),
          buildValidationRow('At least 1 number', hasNumber),
          const SizedBox(height: 2),
          buildValidationRow('At least 8 characters long', hasMinLength),
        ],
      ),
    );
  }

  Widget buildValidationRow(String text, bool hasValidated) {
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
            color: hasValidated ? QColors.darkGrey : QColors.primary,
          ),
        )
      ],
    );
  }
}
