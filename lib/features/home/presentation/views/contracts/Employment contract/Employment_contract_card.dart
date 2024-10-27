import 'package:flutter/material.dart';
import '../../../../../../core/utils/constants/colors.dart';
import 'daily work contract/acept_daily_work.dart';
import 'ministery work model/acept_ministery_work.dart';
import 'public services contract/acept_public_servic.dart';
import 'contract argeement/acept_argeement.dart';
import 'work import contract/acept_work_import.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class EmploymentContractCard extends StatelessWidget {
  const EmploymentContractCard({super.key});

  @override
  Widget build(BuildContext context) {
    final localizations = AppLocalizations.of(context)!;

    return Scaffold(
      appBar: AppBar(
        title: Text(localizations.contracts),
        backgroundColor: QColors.secondary,
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  localizations.chooseYourContract, // Title for guidance
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 20),

                // Contract Agreement
                buildEmploymentCard(
                  context,
                  localizations.contract_agreement, // Contract Agreement
                  Icons.business,
                  const AceptArgeement(),
                ),
                const SizedBox(height: 12),

                // Public Services Contract
                buildEmploymentCard(
                  context,
                  localizations.public_services_contract, // Public Services Contract
                  Icons.miscellaneous_services,
                  const AceptPublicServic(),
                ),
                const SizedBox(height: 12),

                // Work Import Contract
                buildEmploymentCard(
                  context,
                  localizations.work_import_contract, // Work Import Contract
                  Icons.group_add,
                  const AceptWorkImport(),
                ),
                const SizedBox(height: 12),

                // Ministry Work Model
                buildEmploymentCard(
                  context,
                  localizations.ministry_work_model, // Ministry Work Model
                  Icons.gavel,
                  const AceptMinisteryWork(),
                ),
                const SizedBox(height: 12),

                // Daily Work Contract
                buildEmploymentCard(
                  context,
                  localizations.daily_work_contract, // Daily Work Contract
                  Icons.work_outline,
                  const AceptDailyWork(),
                ),
                const SizedBox(height: 12),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget buildEmploymentCard(BuildContext context, String title, IconData icon, Widget page) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => page),
        );
      },
      child: Container(
        width: MediaQuery.of(context).size.width * 0.9,
        height: MediaQuery.of(context).size.height * 0.15,
        padding: const EdgeInsets.all(16), // Internal spacing
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              QColors.secondary.withOpacity(0.9),
              QColors.darkerGrey.withOpacity(0.9),
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.circular(15), // Rounded corners
          boxShadow: const [
            BoxShadow(
              color: Colors.black12,
              blurRadius: 10,
              offset: Offset(0, 4),
            ),
          ],
        ),
        child: Row(
          children: [
            CircleAvatar(
              radius: 25,
              backgroundColor: Colors.white,
              child: Icon(icon, size: 28, color: QColors.secondary),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Text(
                title,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            const Icon(Icons.arrow_forward_ios, color: Colors.white, size: 22),
          ],
        ),
      ),
    );
  }
}
