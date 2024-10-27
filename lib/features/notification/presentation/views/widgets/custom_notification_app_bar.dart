import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../../../../core/utils/styles.dart';

class AppbarNotification extends StatelessWidget {
  const AppbarNotification({super.key});

  @override
  Widget build(BuildContext context) {
    final localizations = AppLocalizations.of(context)!;
    return Padding(
      padding: const EdgeInsets.only(right: 24, left: 24, top: 40, bottom: 10),
      child: Row(
        children: [
          Text(
            localizations.notificationScreen,
            style: Styles.textStyle30,
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
