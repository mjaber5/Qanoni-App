import 'package:flutter/material.dart';

import 'change_language_container_view.dart';
import 'custom_change_language_app_bar.dart';

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
