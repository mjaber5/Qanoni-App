import 'package:flutter/material.dart';
import 'package:qanoni/features/profile/presentation/views/widgets/custom_settings_app_bar.dart';
import 'package:qanoni/features/profile/presentation/views/widgets/settings_change_theme.dart';
import 'package:qanoni/features/profile/presentation/views/widgets/settings_container.dart';
import 'package:qanoni/features/profile/presentation/views/widgets/settings_container_about_us.dart';
import 'package:qanoni/features/profile/presentation/views/widgets/settings_container_logout.dart';

class SettingsViewBody extends StatefulWidget {
  const SettingsViewBody({super.key});

  @override
  State<SettingsViewBody> createState() => _SettingsViewBodyState();
}

class _SettingsViewBodyState extends State<SettingsViewBody> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(80.0),
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 10.0),
          child: SettingsViewAppBar(),
        ),
      ),
      body: CustomScrollView(
        slivers: [
          SliverToBoxAdapter(
            child: Column(
              children: [
                SettingsChangeTheme(),
                SettingsContainer(),
                SettingsContainerAboutUs(),
                SettingsContainerLogout(),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
