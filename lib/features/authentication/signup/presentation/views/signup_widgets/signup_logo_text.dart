import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../../../../../core/utils/styles.dart';

class SignupLogoText extends StatelessWidget {
  const SignupLogoText({super.key});

  @override
  Widget build(BuildContext context) {
    final localizations = AppLocalizations.of(context)!;
    return Text(
      localizations.createAccount,
      style: Styles.textStyle30,
    );
  }
}
