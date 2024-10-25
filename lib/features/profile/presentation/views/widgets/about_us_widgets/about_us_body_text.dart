import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class AboutUsBodyText extends StatelessWidget {
  const AboutUsBodyText({super.key});

  @override
  Widget build(BuildContext context) {
    final localizations = AppLocalizations.of(context)!;
    return  Padding(
      padding: EdgeInsets.symmetric(horizontal: 16, vertical: 24),
      child: Column(
        children: [
          Text(
            localizations.aboutUsBodyText,
            style: TextStyle(fontSize: 16),
          ),
        ],
      ),
    );
  }
}
