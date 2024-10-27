import 'package:flutter/material.dart';
import '../../../../../../core/utils/constants/colors.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class ChangePasswordTextCondition extends StatelessWidget {
  const ChangePasswordTextCondition({super.key});

  @override
  Widget build(BuildContext context) {
    final localizations = AppLocalizations.of(context)!;
    return Padding(
      padding: const EdgeInsets.only(bottom: 16.0, top: 16.0),
      child: Center(
        child: Column(
          crossAxisAlignment:
              CrossAxisAlignment.center, // Aligns text to the left
          children: [
            Text(
              localizations.byChanePassword,
              style: const TextStyle(
                color: Colors.grey,
                fontSize: 13,
              ),
            ),
            const SizedBox(height: 4), // Adds some space between the texts
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                GestureDetector(
                  onTap: () {
                    // Handle Privacy Policy tap
                  },
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
