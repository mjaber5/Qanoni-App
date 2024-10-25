import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../../../../core/utils/styles.dart';import 'package:flutter_gen/gen_l10n/app_localizations.dart';


class CustomAboutUsAppBar extends StatelessWidget {
  const CustomAboutUsAppBar({super.key});
  @override
  Widget build(BuildContext context) {
    final localizations = AppLocalizations.of(context)!;

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
          Text(localizations.about
          ,
            style: Styles.textStyle26.copyWith(
              fontWeight: FontWeight.bold,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
