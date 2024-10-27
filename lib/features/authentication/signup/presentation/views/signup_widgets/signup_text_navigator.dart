import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:go_router/go_router.dart';

import '../../../../../../core/utils/app_router.dart';
import '../../../../../../core/utils/constants/colors.dart';
import '../../../../../../core/utils/styles.dart';

class SignupTextNavigator extends StatelessWidget {
  const SignupTextNavigator({super.key});

  @override
  Widget build(BuildContext context) {
    final localizations = AppLocalizations.of(context)!;

    return Column(
      children: [
        TextButton(
          onPressed: () {
            GoRouter.of(context).pushReplacement(AppRouter.kLoginView);
          },
          child: Text.rich(
            TextSpan(
              text: localizations.signupTextQuestion,
              style: Styles.textStyle14.copyWith(
                color: QColors.darkerGrey,
              ),
              children: [
                TextSpan(
                  text: localizations.login,
                  style: Styles.textStyle14.copyWith(
                    color: QColors.secondary,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
