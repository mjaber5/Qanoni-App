import 'package:flutter/material.dart';
import '../../../../../../core/utils/constants/colors.dart';

import 'daily work contract/acept_daily_work.dart';
import 'ministery work model/acept_ministery_work.dart';
import 'public services contract/acept_public_servic.dart';
import 'contract argeement/acept_argeement.dart';
import 'work import contract/acept_work_import.dart';

class EmploymentContractCard extends StatelessWidget {
  const EmploymentContractCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Contracts"),
        backgroundColor: QColors.secondary,
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: SingleChildScrollView(
            child: Column(
              children: [
                // Contract Agreement
                InkWell(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const AceptArgeement()));
                  },
                  child: Container(
                    width: MediaQuery.of(context).size.width * 0.9,
                    height: MediaQuery.of(context).size.height * 0.15,
                    padding: const EdgeInsets.symmetric(vertical: 12),
                    decoration: BoxDecoration(
                      color: QColors.darkerGrey.withOpacity(0.5),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: const Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Row(
                        children: [
                          Icon(Icons.business, size: 40),
                          SizedBox(width: 12),
                          Text("اتفاقية مقاولة Contract Agreement"),
                          Spacer(),
                        ],
                      ),
                    ),
                  ),
                ),
                SizedBox(height: MediaQuery.of(context).size.height * 0.01),

                // Public Services Contract
                InkWell(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const AceptPublicServic()));
                  },
                  child: Container(
                    width: MediaQuery.of(context).size.width * 0.9,
                    height: MediaQuery.of(context).size.height * 0.15,
                    padding: const EdgeInsets.symmetric(vertical: 12),
                    decoration: BoxDecoration(
                      color: QColors.darkerGrey.withOpacity(0.5),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: const Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Row(
                        children: [
                          Icon(Icons.miscellaneous_services, size: 40),
                          SizedBox(width: 12),
                          Text("عقد خدمات عامة Public Services Contract"),
                          Spacer(),
                        ],
                      ),
                    ),
                  ),
                ),
                SizedBox(height: MediaQuery.of(context).size.height * 0.01),

                // Work Import Contract
                InkWell(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const AceptWorkImport()));
                  },
                  child: Container(
                    width: MediaQuery.of(context).size.width * 0.9,
                    height: MediaQuery.of(context).size.height * 0.15,
                    padding: const EdgeInsets.symmetric(vertical: 12),
                    decoration: BoxDecoration(
                      color: QColors.darkerGrey.withOpacity(0.5),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: const Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Row(
                        children: [
                          Icon(Icons.group_add, size: 40),
                          SizedBox(width: 12),
                          Text("استقدام عمل Work Import Contract"),
                          Spacer(),
                        ],
                      ),
                    ),
                  ),
                ),
                SizedBox(height: MediaQuery.of(context).size.height * 0.01),

                // Ministry Work Model
                InkWell(
                  onTap: () {
                    // Navigate to MinistryContractsAccept page
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const AceptMinisteryWork()));
                  },
                  child: Container(
                    width: MediaQuery.of(context).size.width * 0.9,
                    height: MediaQuery.of(context).size.height * 0.15,
                    padding: const EdgeInsets.symmetric(vertical: 12),
                    decoration: BoxDecoration(
                      color: QColors.darkerGrey.withOpacity(0.5),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: const Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Row(
                        children: [
                          Icon(Icons.gavel, size: 40),
                          SizedBox(width: 12),
                          Text("نموذج عمل وزاري Ministry Work Model"),
                          Spacer(),
                        ],
                      ),
                    ),
                  ),
                ),
                SizedBox(height: MediaQuery.of(context).size.height * 0.01),

                // Daily Work Contract
                InkWell(
                  onTap: () {
                    // Navigate to TemporaryWorkContractsAccept page
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const AceptDailyWork()));
                  },
                  child: Container(
                    width: MediaQuery.of(context).size.width * 0.9,
                    height: MediaQuery.of(context).size.height * 0.15,
                    padding: const EdgeInsets.symmetric(vertical: 12),
                    decoration: BoxDecoration(
                      color: QColors.darkerGrey.withOpacity(0.5),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: const Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Row(
                        children: [
                          Icon(Icons.work_outline, size: 40),
                          SizedBox(width: 12),
                          Text("عقد عمل مياومة Daily Work Contract"),
                          Spacer(),
                        ],
                      ),
                    ),
                  ),
                ),
                SizedBox(height: MediaQuery.of(context).size.height * 0.01),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
