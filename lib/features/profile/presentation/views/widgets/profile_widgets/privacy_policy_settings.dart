import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:qanoni/core/utils/constants/sizes.dart';
import 'package:qanoni/core/utils/theme/change_theme_notifire.dart';
import 'package:qanoni/core/utils/theme/custom_themes/text_theme.dart';

class PrivacyPolicySettings extends StatelessWidget {
  const PrivacyPolicySettings({super.key});

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
          Icons.lock_clock_outlined,
        ),
        title: Text(
          'Privacy policy',
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
