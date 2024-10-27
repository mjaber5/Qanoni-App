import 'package:flutter/material.dart';

import 'widgets/change_language_widgets/change_language_view_body.dart';

class ChangeLanguageView extends StatelessWidget {
  const ChangeLanguageView({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: ChangeLanguageViewBody(),
    );
  }
}
