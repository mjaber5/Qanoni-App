import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../../../../core/utils/app_router.dart';
import '../../../../../../core/utils/constants/colors.dart';
import '../../../../../../core/utils/constants/sizes.dart';
import '../../../../../../core/utils/constants/text_strings.dart';

class SettingsContainerAboutUs extends StatelessWidget {
  const SettingsContainerAboutUs({super.key});

  @override
  Widget build(BuildContext context) {
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
                  GoRouter.of(context).push(AppRouter.kAboutUsView);
                },
                leading: const Icon(
                  Icons.info,
                ),
                title: const Text(
                  QTexts.settingsAboutUS,
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
