import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:qanoni/features/home/presentation/views/contracts/sales%20contracts/sell%20a%20equipment/equipment_acepet.dart';
import 'package:qanoni/features/home/presentation/views/contracts/sales%20contracts/sell%20a%20property/aceprt_property.dart';
import 'package:qanoni/features/home/presentation/views/contracts/sales%20contracts/sell_car_contract/sales_car_acept.dart';
import '../../../../../../core/utils/constants/colors.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'cancellation of sales contract/cancellation_aceept.dart';
import 'sell a land/sell_land_acept.dart';


class SalesContractsCard extends StatelessWidget {
  const SalesContractsCard({super.key});

  @override
  Widget build(BuildContext context) {
    final localizations = AppLocalizations.of(context)!;

    return Scaffold(
      appBar: AppBar(
        title: Text(localizations.sellCardAppBar),
        backgroundColor: QColors.secondary,
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                localizations.chooseYourContract,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 20),

              // Car Sale Contract Card
              buildSaleCard(
                context,
                localizations.sellCardCar,
                Iconsax.car5,
                const SalesCarAccept(),
              ),
              const SizedBox(height: 12),

              // Property Sale Contract Card
              buildSaleCard(
                context,
                localizations.sellPropertyCard,
                Iconsax.home5,
                const AceprtProperty(),
              ),
              const SizedBox(height: 12),

              // Land Sale Contract Card
              buildSaleCard(
                context,
                localizations.sellLandCard,
                Iconsax.map5,
                const SellLandAcept(),
              ),
              const SizedBox(height: 12),

              // Equipment Sale Contract Card
              buildSaleCard(
                context,
                localizations.sellEquipmentCard,
                Iconsax.briefcase5,
                const EquipmentAcepet(),
              ),
              const SizedBox(height: 12),

              // Sale Termination Contract Card
              buildSaleCard(
                context,
                localizations.sellTerminationCard,
                Iconsax.close_circle,
                const CancellationAceept(),
              ),
              const SizedBox(height: 12),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildSaleCard(BuildContext context, String label, IconData icon, Widget page) {
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
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              QColors.secondary.withOpacity(0.9),
              QColors.darkerGrey.withOpacity(0.9),
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.circular(15),
          boxShadow: [
            const BoxShadow(
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
                label,
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
