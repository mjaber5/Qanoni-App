import 'package:flutter/material.dart';

import 'package:qanoni/core/utils/constants/colors.dart';

import 'package:qanoni/features/profile/presentation/views/widgets/settings_widgets/account_information_settings.dart';

import 'package:qanoni/features/profile/presentation/views/widgets/settings_widgets/change_language_settings.dart';
import 'package:qanoni/features/profile/presentation/views/widgets/settings_widgets/change_password_settings.dart';
import 'package:qanoni/features/profile/presentation/views/widgets/settings_widgets/history_settings.dart';
import 'package:qanoni/features/profile/presentation/views/widgets/profile_widgets/privacy_policy_settings.dart';

class SettingsContainer extends StatelessWidget {
  const SettingsContainer({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12.0),
      child: Container(
        width: MediaQuery.of(context).size.width * 0.95,
        height: MediaQuery.of(context).size.height * 0.5,
        decoration: BoxDecoration(
          color: QColors.darkerGrey.withOpacity(0.4),
          borderRadius: BorderRadius.circular(30),
        ),
        child: const Padding(
          padding: EdgeInsets.symmetric(horizontal: 12, vertical: 20),
          child: Column(
            children: [
              ChangeLanguageSettings(),
              HistorySettings(),
              AccountInformationSettings(),
              ChangePasswordSettings(),
              PrivacyPolicySettings(),
            ],
          ),
        ),
      ),
    );
  }
}
