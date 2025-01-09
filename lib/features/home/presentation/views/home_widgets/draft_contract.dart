import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart'; // Assuming you are using flutter_gen for localization
import 'package:qanoni/core/utils/constants/colors.dart';
import '../../../../../core/utils/app_router.dart';

class DraftContract extends StatelessWidget {
  const DraftContract({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
            backgroundColor: Colors.transparent,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
                side: const BorderSide(color: QColors.secondary, width: 1.0))),
        onPressed: () {
          GoRouter.of(context).push(AppRouter.kHistoryView);
        },
        child: Text(
          AppLocalizations.of(context)!.draftContracts,
          style: TextStyle(
            color: Theme.of(context).brightness == Brightness.dark
                ? Colors.white
                : Colors.black,
          ),
        ),
      ),
    );
  }
}
