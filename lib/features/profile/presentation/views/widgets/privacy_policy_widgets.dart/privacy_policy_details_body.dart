import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class PrivacyPolicyDetailsBody extends StatelessWidget {
  const PrivacyPolicyDetailsBody({super.key});

  @override
  Widget build(BuildContext context) {
    final localizations = AppLocalizations.of(context)!;
    return  Padding(
      padding: EdgeInsets.symmetric(horizontal: 14, vertical: 24),
      child: Column(
        children: [
          Text(
            textAlign: TextAlign.center,
            localizations.aboutUsBodyText,
          ),
          Text(
            textAlign: TextAlign.center,
            localizations.aboutUsBodyText,
          ),
        ],
      ),
    );
  }
}
