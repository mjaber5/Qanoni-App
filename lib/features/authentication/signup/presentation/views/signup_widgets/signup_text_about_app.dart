import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:qanoni/core/utils/constants/text_strings.dart';
import '../../../../../../core/utils/constants/colors.dart';
import '../../../../../../core/utils/styles.dart';
import '../../../../../../core/utils/theme/change_theme_notifire.dart';

class SignupTextAboutApp extends StatelessWidget {
  const SignupTextAboutApp({super.key});

  @override
  Widget build(BuildContext context) {
    bool isLight = context.watch<ThemeNotifier>().isLightTheme;
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          QTexts.signupAboutApp,
          style: Styles.textStyle16.copyWith(
            color: isLight ? QColors.darkGrey : QColors.darkerGrey,
          ),
        ),
      ],
    );
  }
}
