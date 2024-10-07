import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import '../../../../../../core/utils/constants/colors.dart';
import '../../../../../../core/utils/constants/text_strings.dart';
import '../waiver contracts/car_waiver_contract/acept_car_waiver.dart';
import '../waiver contracts/property waiver contract/acept_property.dart';

import 'business partnership waiver/acept_business_partnership_waiver.dart';
import 'intellectual waiver contract/acept_intellectual.dart';
import 'financial waiver/acept_financial.dart';

class WaiverContractsCard extends StatelessWidget {
  const WaiverContractsCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(QTexts.waiverContractsTitle),
        backgroundColor: QColors.secondary,
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            children: [
            
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
                  label: QTexts.propertyWaiverLabel, 
                ),
              ),
              SizedBox(height: MediaQuery.of(context).size.height * 0.01),

              
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
                  label: QTexts.vehicleWaiverLabel,
                ),
              ),
              SizedBox(height: MediaQuery.of(context).size.height * 0.01),

             
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
                  label: QTexts.intellectualRightsWaiverLabel, 
                ),
              ),
              SizedBox(height: MediaQuery.of(context).size.height * 0.01),

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
                  label: QTexts.businessPartnershipWaiverLabel, 
                ),
              ),
              SizedBox(height: MediaQuery.of(context).size.height * 0.01),

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
                  label: QTexts.legalFinancialRightsWaiverLabel, 
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
