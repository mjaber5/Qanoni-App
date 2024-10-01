import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../../../../core/utils/constants/sizes.dart';
import '../../../../../../core/utils/constants/text_strings.dart';
import '../../../../../../core/utils/theme/change_theme_notifire.dart';
import '../../../../../../core/utils/theme/custom_themes/text_theme.dart';

class ChangePasswordSettings extends StatelessWidget {
  const ChangePasswordSettings({super.key});

  @override
  Widget build(BuildContext context) {
    bool isLight = context.watch<ThemeNotifier>().isLightTheme;
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: ListTile(
        onTap: () {
          // Todo language Change
        },
        leading: const Icon(
          Icons.lock_outlined,
        ),
        title: Text(
          QTexts.settingsChangePassword,
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
