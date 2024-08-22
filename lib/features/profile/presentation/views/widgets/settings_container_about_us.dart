import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:qanoni/core/utils/constants/colors.dart';
import 'package:qanoni/core/utils/constants/sizes.dart';
import 'package:qanoni/core/utils/theme/change_theme_notifire.dart';
import 'package:qanoni/core/utils/theme/custom_themes/text_theme.dart';

class SettingsContainerAboutUs extends StatelessWidget {
  const SettingsContainerAboutUs({super.key});

  @override
  Widget build(BuildContext context) {
    bool isLight = context.watch<ThemeNotifier>().isLightTheme;
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12.0),
      child: Container(
        width: MediaQuery.of(context).size.width * 0.95,
        height: MediaQuery.of(context).size.height * 0.1,
        decoration: BoxDecoration(
          color: QColors.darkerGrey.withOpacity(0.4),
          borderRadius: BorderRadius.circular(30),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ListTile(
                onTap: () {
                  // Todo Navigator to about us view
                },
                leading: const Icon(
                  Icons.info,
                ),
                title: Text(
                  'About us',
                  style: isLight
                      ? QTextTheme.darkTextTheme.headlineSmall
                      : QTextTheme.lightTextTheme.headlineSmall,
                ),
                trailing: const Icon(
                  Icons.arrow_forward_ios,
                  size: QSizes.iconMd,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
