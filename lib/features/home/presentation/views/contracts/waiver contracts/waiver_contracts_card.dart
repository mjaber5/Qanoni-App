import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:qanoni/core/utils/constants/colors.dart';
import 'package:qanoni/features/home/presentation/views/contracts/waiver%20contracts/car_waiver_contract/acept_car_waiver.dart';
import 'package:qanoni/features/home/presentation/views/contracts/waiver%20contracts/property%20waiver%20contract/acept_property.dart';

import 'business partnership waiver/acept_business_partnership_waiver.dart';
import 'intellectual waiver contract/acept_intellectual.dart';
import 'financial waiver/acept_financial.dart';

class WaiverContractsCard extends StatelessWidget {
  const WaiverContractsCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Waiver Contracts"),
        backgroundColor: QColors.secondary,
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            children: [
              // 1. عقد التنازل عن الممتلكات العقارية
              InkWell(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const AceptProperty()));
                },
                child: buildWaiverCard(
                  context,
                  icon: Iconsax.home5,
                  label: "Property Waiver contract",
                ),
              ),
              SizedBox(height: MediaQuery.of(context).size.height * 0.01),

              // 2. عقد التنازل عن المركبات
              InkWell(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const AceptCarWaiver()));
                },
                child: buildWaiverCard(
                  context,
                  icon: Iconsax.car5,
                  label: "Vehicle Waiver contract",
                ),
              ),
              SizedBox(height: MediaQuery.of(context).size.height * 0.01),

              // 3. عقد التنازل عن الحقوق الفكرية
              InkWell(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const AceptIntellectual()));
                },
                child: buildWaiverCard(
                  context,
                  icon: Iconsax.book,
                  label: "Intellectual Rights Waiver",
                ),
              ),
              SizedBox(height: MediaQuery.of(context).size.height * 0.01),

              // 4. عقد التنازل عن الشراكات التجارية أو حصص الشركة
              InkWell(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>
                              const AceptBusinessPartnershipWaiver()));
                },
                child: buildWaiverCard(
                  context,
                  icon: Iconsax.briefcase5,
                  label: "Business Partnership Waiver",
                ),
              ),
              SizedBox(height: MediaQuery.of(context).size.height * 0.01),

              // 5. عقد التنازل عن الحقوق القانونية أو المالية
              InkWell(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const AceptFinancial()));
                },
                child: buildWaiverCard(
                  context,
                  icon: Iconsax.dollar_circle,
                  label: "Legal or Financial Rights Waiver",
                ),
              ),
              SizedBox(height: MediaQuery.of(context).size.height * 0.01),

              SizedBox(height: MediaQuery.of(context).size.height * 0.01),
            ],
          ),
        ),
      ),
    );
  }

  // Widget Helper لبناء كرت التنازل

  Widget buildWaiverCard(BuildContext context,
      {required IconData icon, required String label}) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.9,
      height: MediaQuery.of(context).size.height * 0.15,
      padding: const EdgeInsets.symmetric(vertical: 12),
      decoration: BoxDecoration(
        color: QColors.darkerGrey.withOpacity(0.5),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, size: 30, color: Colors.white),
            const SizedBox(width: 40),
            Text(label, style: const TextStyle(color: Colors.white)),
          ],
        ),
      ),
    );
  }
}
