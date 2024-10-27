import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../../../../../core/utils/styles.dart';

class LoginTextAboutApp extends StatelessWidget {
  const LoginTextAboutApp({super.key});

  @override
  Widget build(BuildContext context) {
    final localizations = AppLocalizations.of(context)!;

    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          localizations.makeYourServicesApp,
          style: Styles.textStyle16.copyWith(),
        ),
      ],
    );
  }
}
