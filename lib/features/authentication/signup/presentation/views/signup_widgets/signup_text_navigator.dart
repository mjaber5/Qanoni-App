import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import '../../../../../../core/utils/app_router.dart';
import '../../../../../../core/utils/constants/colors.dart';
import '../../../../../../core/utils/styles.dart';
import '../../../../../../core/utils/theme/change_theme_notifire.dart';

import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class SignupTextNavigator extends StatelessWidget {
  const SignupTextNavigator({super.key});

  @override
  Widget build(BuildContext context) {
    final localizations = AppLocalizations.of(context)!;
    bool isLight = context.watch<ThemeNotifier>().isLightTheme;

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
                color: isLight ? QColors.grey : QColors.darkerGrey,
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
