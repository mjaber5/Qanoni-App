import 'package:flutter/material.dart';
import 'package:qanoni/features/profile/presentation/views/widgets/change_language_widgets/change_language_container_view.dart';
import 'package:qanoni/features/profile/presentation/views/widgets/change_language_widgets/custom_change_language_app_bar.dart';

class ChangeLanguageViewBody extends StatelessWidget {
  const ChangeLanguageViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Column(
        children: [
          CustomChangeLanguageAppBar(),
          LanguageToogleContainerView(),
        ],
      ),
    );
  }
}
