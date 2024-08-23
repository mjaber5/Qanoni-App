import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';
import 'package:qanoni/core/utils/app_router.dart';
import 'package:qanoni/core/utils/constants/text_strings.dart';
import 'package:qanoni/core/utils/styles.dart';

class AppbarProfilState extends StatefulWidget {
  const AppbarProfilState({super.key});

  @override
  State<AppbarProfilState> createState() => __AppbarProfilStateState();
}

class __AppbarProfilStateState extends State<AppbarProfilState> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 24, left: 24, top: 40, bottom: 10),
      child: Row(
        children: [
          const Text(
            QTexts.profileAppbarTitle,
            style: Styles.textStyle30,
            textAlign: TextAlign.center,
          ),
          const Spacer(),
          IconButton(
            icon: const Icon(
              FontAwesomeIcons.bars,
              size: 22,
            ),
            onPressed: () {
              GoRouter.of(context).push(AppRouter.kSettingsView);
            },
          )
        ],
      ),
    );
  }
}
