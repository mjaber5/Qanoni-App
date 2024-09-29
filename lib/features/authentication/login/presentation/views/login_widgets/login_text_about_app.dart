import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';
import 'package:qanoni/core/utils/constants/colors.dart';
import 'package:qanoni/core/utils/constants/text_strings.dart';
import 'package:qanoni/core/utils/styles.dart';
import 'package:qanoni/core/utils/theme/change_theme_notifire.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class LoginTextAboutApp extends StatelessWidget {
  const LoginTextAboutApp({super.key});

  @override
  Widget build(BuildContext context) {
    final localizations = AppLocalizations.of(context)!;
    bool isLight = context.watch<ThemeNotifier>().isLightTheme;

    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          localizations.makeYourServicesApp,
          style: Styles.textStyle16.copyWith(
            color: isLight ? QColors.darkGrey : QColors.darkerGrey,
          ),
        ),
      ],
    );
  }
}
