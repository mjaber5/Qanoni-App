import 'package:flutter/material.dart';

import 'package:qanoni/features/profile/presentation/views/widgets/custom_settings_app_bar.dart';
import 'package:qanoni/features/profile/presentation/views/widgets/settings_change_theme.dart';

class SettingsViewBody extends StatefulWidget {
  const SettingsViewBody({super.key});

  @override
  State<SettingsViewBody> createState() => _SettingsViewBodyState();
}

class _SettingsViewBodyState extends State<SettingsViewBody> {
  @override
  Widget build(BuildContext context) {
    return const Column(
      children: [
        SettingsViewAppBar(),
        SettingsChangeTheme(),
      ],
    );
  }
}
