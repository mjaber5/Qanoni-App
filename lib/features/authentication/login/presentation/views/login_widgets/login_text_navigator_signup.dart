import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:qanoni/core/utils/app_router.dart';
import 'package:qanoni/core/utils/constants/colors.dart';
import 'package:qanoni/core/utils/constants/text_strings.dart';
import 'package:qanoni/core/utils/styles.dart';
import 'package:qanoni/core/utils/theme/change_theme_notifire.dart';

class LoginTextNavigatorSignup extends StatelessWidget {
  const LoginTextNavigatorSignup({super.key});

  @override
  Widget build(BuildContext context) {
    bool isLight = context.watch<ThemeNotifier>().isLightTheme;

    return Padding(
      padding: const EdgeInsets.all(18.0),
      child: Column(
        children: [
          TextButton(
            onPressed: () {
              GoRouter.of(context).pushReplacement(AppRouter.kSignupView);
            },
            child: Text.rich(
              TextSpan(
                text: QTexts.loginTextQuestion,
                style: Styles.textStyle14.copyWith(
                  color: isLight ? QColors.grey : QColors.darkerGrey,
                ),
                children: [
                  TextSpan(
                    text: QTexts.loginSignupTextNavigator,
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
      ),
    );
  }
}
