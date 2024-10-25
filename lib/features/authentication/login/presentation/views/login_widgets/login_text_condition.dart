import 'package:flutter/material.dart';
import 'package:qanoni/core/utils/constants/colors.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class LoginTextCondition extends StatelessWidget {
  const LoginTextCondition({super.key});

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
              style: TextStyle(
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
                  child:  Text(
                   localizations.loginPrivacyPolicy,
                    style: TextStyle(
                      fontSize: 14,
                      color: QColors.secondary,
                      decoration: TextDecoration.underline,
                    ),
                  ),
                ),
                 Text(
                  localizations.loginAndText,
                  style: TextStyle(
                    color: Colors.grey,
                    fontSize: 13,
                  ),
                ),
                GestureDetector(
                  onTap: () {},
                  child:  Text(
           localizations.termsOfUs,         style: TextStyle(
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
