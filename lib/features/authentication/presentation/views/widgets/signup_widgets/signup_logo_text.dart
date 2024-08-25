import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:qanoni/core/utils/theme/change_theme_notifire.dart';
import 'package:qanoni/core/utils/theme/custom_themes/text_theme.dart';

class SignupLogoText extends StatelessWidget {
  const SignupLogoText({super.key});

  @override
  Widget build(BuildContext context) {
    bool isLight = context.watch<ThemeNotifier>().isLightTheme;
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 20.0),
      child: Center(
        child: Text(
          "Sign Up",
          style: isLight
              ? QTextTheme.darkTextTheme.headlineLarge
              : QTextTheme.lightTextTheme.headlineLarge,
        ),
      ),
    );
  }
}
