import 'package:flutter/material.dart';
import 'package:qanoni/core/utils/constants/colors.dart';

import 'package:qanoni/core/utils/styles.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
class SignupLogoText extends StatelessWidget {

  const SignupLogoText({super.key});

  @override
  Widget build(BuildContext context) {
    final localizations = AppLocalizations.of(context)!;
    return Text(
      localizations.createAccount,
      style: Styles.textStyle30.copyWith(
        color: QColors.secondary,
      ),
    );
  }
}
