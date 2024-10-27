import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../../../../../core/utils/constants/colors.dart';
import '../../../../../../core/utils/styles.dart';

class SignupTextAboutApp extends StatelessWidget {
  const SignupTextAboutApp({super.key});

  @override
  Widget build(BuildContext context) {
    final localizations = AppLocalizations.of(context)!;
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          localizations.signupAboutAppp,
          style: Styles.textStyle16.copyWith(
            color: QColors.darkGrey,
          ),
        ),
      ],
    );
  }
}
