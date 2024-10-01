import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../../../../core/utils/constants/colors.dart';
import '../../../../../../core/utils/styles.dart';
import '../../../../../../core/utils/theme/change_theme_notifire.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class SignupTextAboutApp extends StatelessWidget {
  const SignupTextAboutApp({super.key});

  @override
  Widget build(BuildContext context) {
    final localizations = AppLocalizations.of(context)!;
    bool isLight = context.watch<ThemeNotifier>().isLightTheme;
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          localizations.signupAboutApp,
          style: Styles.textStyle16.copyWith(
            color: isLight ? QColors.darkGrey : QColors.darkerGrey,
          ),
        ),
      ],
    );
  }
}
