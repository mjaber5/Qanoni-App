import 'package:flutter/material.dart';
import 'package:qanoni/core/utils/constants/colors.dart';
import 'package:qanoni/core/utils/constants/text_strings.dart';
import 'package:qanoni/core/utils/styles.dart';

class SettingsContainerLogout extends StatelessWidget {
  const SettingsContainerLogout({super.key});

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
                onTap: () {},
                leading: const Icon(
                  Icons.logout_outlined,
                  color: QColors.error,
                ),
                title: Text(
                  QTexts.settingsLogout,
                  style: Styles.textStyle20.copyWith(
                    color: QColors.error,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
