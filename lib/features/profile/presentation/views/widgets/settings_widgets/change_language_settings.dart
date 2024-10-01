import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import '../../../../../../core/utils/app_router.dart';
import '../../../../../../core/utils/constants/sizes.dart';
import '../../../../../../core/utils/constants/text_strings.dart';
import '../../../../../../core/utils/theme/change_theme_notifire.dart';
import '../../../../../../core/utils/theme/custom_themes/text_theme.dart';

class ChangeLanguageSettings extends StatelessWidget {
  const ChangeLanguageSettings({super.key});

  @override
  Widget build(BuildContext context) {
    bool isLight = context.watch<ThemeNotifier>().isLightTheme;
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: ListTile(
        onTap: () {
          GoRouter.of(context).push(AppRouter.kChangeLanguageView);
        },
        leading: const Icon(
          Icons.language_outlined,
        ),
        title: Text(
          QTexts.settingsLanguage,
          style: isLight
              ? QTextTheme.darkTextTheme.headlineSmall
              : QTextTheme.lightTextTheme.headlineSmall,
        ),
        trailing: const Icon(
          Icons.arrow_forward_ios,
          size: QSizes.iconMd,
        ),
      ),
    );
  }
}
