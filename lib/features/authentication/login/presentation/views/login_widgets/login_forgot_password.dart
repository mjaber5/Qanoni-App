import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../../../../../core/utils/constants/colors.dart';
import '../../../../../../core/utils/styles.dart';

class LoginTextForgotPassword extends StatelessWidget {
  const LoginTextForgotPassword({super.key});

  @override
  Widget build(BuildContext context) {
    final localizations = AppLocalizations.of(context)!;
    return Padding(
      padding: const EdgeInsets.only(top: 16, right: 8),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          TextButton(
            onPressed: () {},
            child: Text(
              localizations.loginForgotPassword,
              style: Styles.textStyle14.copyWith(
                color: QColors.secondary,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
