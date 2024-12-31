import 'package:flutter/material.dart';
import '../../../../../../core/utils/constants/colors.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class LoginLogoText extends StatelessWidget {
  const LoginLogoText({super.key});

  @override
  Widget build(BuildContext context) {
    final localizations = AppLocalizations.of(context)!;

    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Row(
            children: [
              Text('Q',
                  style: TextStyle(
                      color: QColors.secondary,
                      fontSize: 48,
                      fontWeight: FontWeight.bold)),
              Text('anoni',
                  style: TextStyle(fontSize: 36, fontWeight: FontWeight.bold)),
            ],
          ),
          const SizedBox(height: 8),
          Text(
            localizations.welcomeBack,
            style: const TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            localizations.makeYourServicesApp,
            style: const TextStyle(
              fontSize: 16,
              color: QColors.darkGrey,
            ),
          ),
        ],
      ),
    );
  }
}
