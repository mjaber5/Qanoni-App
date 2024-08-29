import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:qanoni/core/utils/constants/colors.dart';
import 'package:qanoni/core/utils/constants/text_strings.dart';
import 'package:qanoni/core/utils/styles.dart';
import 'package:qanoni/core/utils/theme/change_theme_notifire.dart';

class LoginTextCondition extends StatelessWidget {
  const LoginTextCondition({super.key});

  @override
  Widget build(BuildContext context) {
    bool isLight = context.watch<ThemeNotifier>().isLightTheme;

    return Padding(
      padding: const EdgeInsets.only(bottom: 16.0, top: 16.0),
      child: Center(
        child: RichText(
          textAlign: TextAlign.center,
          text: TextSpan(
            style: Styles.textStyle14.copyWith(
              color: isLight ? QColors.darkGrey : QColors.darkGrey,
            ),
            children: [
              const TextSpan(
                text: QTexts.loginConditionText,
              ),
              TextSpan(
                text: QTexts.loginTermsAndConditions,
                style: Styles.textStyle14.copyWith(
                  color: isLight ? QColors.grey : QColors.darkerGrey,
                  fontWeight: FontWeight.w500,
                ),
              ),
              const TextSpan(
                text: QTexts.loginAndText,
              ),
              TextSpan(
                text: QTexts.loginPrivacyPolicy,
                style: Styles.textStyle14.copyWith(
                  color: isLight ? QColors.grey : QColors.darkerGrey,
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
