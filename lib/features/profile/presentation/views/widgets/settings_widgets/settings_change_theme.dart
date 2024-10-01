import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../../../../core/utils/constants/colors.dart';
import '../../../../../../core/utils/constants/text_strings.dart';
import '../../../../../../core/utils/theme/change_theme_notifire.dart';
import '../../../../../../core/utils/theme/custom_themes/text_theme.dart';

class SettingsChangeTheme extends StatefulWidget {
  const SettingsChangeTheme({super.key});

  @override
  State<SettingsChangeTheme> createState() => _SettingsViewCChangeTheme();
}

class _SettingsViewCChangeTheme extends State<SettingsChangeTheme> {
  @override
  Widget build(BuildContext context) {
    bool isLight = context.watch<ThemeNotifier>().isLightTheme;
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12.0),
      child: Container(
        width: MediaQuery.of(context).size.width * 0.95,
        height: MediaQuery.of(context).size.height * 0.13,
        decoration: BoxDecoration(
          color: QColors.darkerGrey.withOpacity(0.4),
          borderRadius: BorderRadius.circular(30),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
          child: GestureDetector(
            child: Row(
              children: [
                Text(
                  QTexts.settingsChangeThemeSwitch,
                  style: isLight
                      ? QTextTheme.darkTextTheme.headlineSmall
                      : QTextTheme.lightTextTheme.headlineSmall,
                ),
                const Spacer(),
                Switch(
                  trackColor: WidgetStateProperty.all(QColors.grey),
                  activeColor: QColors.secondary,
                  value: isLight,
                  onChanged: (themeChange) {
                    context.read<ThemeNotifier>().toggleTheme(themeChange);
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
