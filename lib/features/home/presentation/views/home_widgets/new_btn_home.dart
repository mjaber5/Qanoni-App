import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart'; // Assuming you are using flutter_gen for localization
import '../new widgets dialog/waiver_contract_dialog.dart'; // Assuming the correct import path

class NewBtnHome extends StatelessWidget {
  const NewBtnHome({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: ElevatedButton(
        onPressed: () {
          // Show the bottom sheet when the button is pressed
          showModalBottomSheet(
            context: context,
            builder: (context) {
              return const WaiverContractBottomSheet(); // Your bottom sheet widget
            },
          );
        },
        child: Text(AppLocalizations.of(context)!.startNewContract),
      ),
    );
  }
}
