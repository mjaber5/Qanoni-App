import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:qanoni/core/utils/constants/text_strings.dart';
import 'package:qanoni/core/utils/styles.dart';

class SettingsViewAppBar extends StatefulWidget {
  const SettingsViewAppBar({super.key});

  @override
  State<SettingsViewAppBar> createState() => _SettingsViewAppBarState();
}

class _SettingsViewAppBarState extends State<SettingsViewAppBar> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 8, left: 8, top: 40, bottom: 10),
      child: Row(
        children: [
          IconButton(
            onPressed: () {
              GoRouter.of(context).pop();
            },
            icon: const Icon(Icons.arrow_back_ios),
          ),
          const Text(
            QTexts.settingsAppbarTitle,
            style: Styles.textStyle30,
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
