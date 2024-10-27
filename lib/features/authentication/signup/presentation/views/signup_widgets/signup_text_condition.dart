import 'package:flutter/material.dart';
import '../../../../../../core/utils/constants/colors.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class SignupTextCondition extends StatelessWidget {
  const SignupTextCondition({super.key});

  @override
  Widget build(BuildContext context) {
    final localizations = AppLocalizations.of(context)!;
    return Padding(
      padding: const EdgeInsets.only(bottom: 16.0, top: 16.0),
      child: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              localizations.byLogin,
              style: const TextStyle(
                color: Colors.grey,
                fontSize: 13,
              ),
            ),
            const SizedBox(height: 4),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                GestureDetector(
                  onTap: () {},
                  child: Text(
                    localizations.loginPrivacyPolicy,
                    style: const TextStyle(
                      fontSize: 14,
                      color: QColors.secondary,
                      decoration: TextDecoration.underline,
                    ),
                  ),
                ),
                Text(
                  localizations.loginAndText,
                  style: const TextStyle(
                    color: Colors.grey,
                    fontSize: 13,
                  ),
                ),
                GestureDetector(
                  onTap: () {},
                  child: Text(
                    localizations.termsOfUs,
                    style: const TextStyle(
                      fontSize: 14,
                      color: QColors.secondary,
                      decoration: TextDecoration.underline,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
