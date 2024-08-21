import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:qanoni/core/utils/constants/colors.dart';
import 'package:qanoni/core/utils/styles.dart';
import 'package:qanoni/core/utils/theme/change_theme_notifire.dart';

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
      padding: const EdgeInsets.symmetric(vertical: 18.0),
      child: Container(
        width: MediaQuery.of(context).size.width * 0.95,
        height: MediaQuery.of(context).size.height * 0.2,
        decoration: BoxDecoration(
          color: QColors.darkerGrey.withOpacity(0.4),
          borderRadius: BorderRadius.circular(30),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12),
          child: ListView.builder(
            itemCount: 1,
            itemBuilder: (context, index) {
              return GestureDetector(
                child: Row(
                  children: [
                    const Text('Light mode', style: Styles.textStyle20),
                    const Spacer(),
                    Switch(
                      value: isLight,
                      onChanged: (themeChange) {
                        context.read<ThemeNotifier>().toggleTheme(themeChange);
                      },
                    ),
                  ],
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
