import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:qanoni/core/utils/constants/colors.dart';

class HeaderText extends StatelessWidget {
  const HeaderText({
    super.key,
    required this.localizations,
  });

  final AppLocalizations localizations;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          localizations.qanoni,
          style: const TextStyle(fontSize: 40, fontWeight: FontWeight.w800),
        ),
        const SizedBox(height: 12),
        Text(
          localizations.forgotPassword,
          style: const TextStyle(fontSize: 22, fontWeight: FontWeight.w600),
        ),
        const SizedBox(height: 4),
        Text(
          localizations.restEmail,
          style: const TextStyle(fontSize: 16, color: QColors.darkGrey),
        ),
      ],
    );
  }
}
