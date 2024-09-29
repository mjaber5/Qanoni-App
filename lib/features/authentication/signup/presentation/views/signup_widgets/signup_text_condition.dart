import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:qanoni/core/utils/constants/colors.dart';
import 'package:qanoni/core/utils/constants/text_strings.dart';
import 'package:qanoni/core/utils/styles.dart';
import 'package:qanoni/core/utils/theme/change_theme_notifire.dart';

import 'package:flutter_gen/gen_l10n/app_localizations.dart';
class SignupTextCondition extends StatelessWidget {

  const SignupTextCondition({super.key});

  @override
  Widget build(BuildContext context) {
    final localizations = AppLocalizations.of(context)!;
    bool isLight = context.watch<ThemeNotifier>().isLightTheme;

    return Padding(
      padding: const EdgeInsets.only(bottom: 16.0),
      child: Center(
        child: RichText(
          textAlign: TextAlign.center,
          text: TextSpan(
            style: Styles.textStyle14.copyWith(
              color: isLight ? QColors.darkGrey : QColors.darkGrey,
            ),
            children: [
               TextSpan(
                text: localizations.signupConditionText,
              ),
              TextSpan(
                text: localizations.loginTermsAndConditions,
                style: Styles.textStyle14.copyWith(
                  color: isLight ? QColors.grey : QColors.darkerGrey,
                  fontWeight: FontWeight.w500,
                ),
              ),
               TextSpan(
                text:localizations.loginAndText,
              ),
              TextSpan(
                text: localizations.loginPrivacyPolicy,
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
