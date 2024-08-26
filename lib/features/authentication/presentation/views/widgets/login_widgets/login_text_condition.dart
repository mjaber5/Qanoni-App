import 'package:flutter/material.dart';
import 'package:qanoni/core/utils/constants/colors.dart';
import 'package:qanoni/core/utils/constants/text_strings.dart';
import 'package:qanoni/core/utils/styles.dart';

class LoginTextCondition extends StatelessWidget {
  const LoginTextCondition({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Center(
        child: RichText(
          textAlign: TextAlign.center,
          text: TextSpan(
            style: Styles.textStyle14.copyWith(
              color: QColors.darkGrey,
            ),
            children: [
              const TextSpan(
                text: QTexts.loginConditionText,
              ),
              TextSpan(
                text: QTexts.loginTermsAndConditions,
                style: Styles.textStyle14.copyWith(
                  color: QColors.darkerGrey,
                  fontWeight: FontWeight.w500,
                ),
              ),
              const TextSpan(
                text: QTexts.loginAndText,
              ),
              TextSpan(
                text: QTexts.loginPrivacyPolicy,
                style: Styles.textStyle14.copyWith(
                  color: QColors.darkerGrey,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
