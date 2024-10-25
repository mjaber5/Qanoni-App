import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';
import '../../../../../../core/utils/app_router.dart';
import '../../../../../../core/utils/styles.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class AppbarProfilState extends StatefulWidget {
  const AppbarProfilState({super.key});

  @override
  State<AppbarProfilState> createState() => __AppbarProfilStateState();
}

class __AppbarProfilStateState extends State<AppbarProfilState> {
  @override
  Widget build(BuildContext context) {
    final localizations = AppLocalizations.of(context)!;
    return Padding(
      padding: const EdgeInsets.only(right: 24, left: 24, top: 40, bottom: 10),
      child: Row(
        children: [
          Text(
            localizations.profileScreen,
            style: Styles.textStyle26.copyWith(
              fontWeight: FontWeight.bold,
            ),
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
