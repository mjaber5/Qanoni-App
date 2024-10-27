import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import '../../../../../../core/utils/constants/colors.dart';
import '../lease contracts/car_rental_contact/acept_car.dart';
import '../lease contracts/daily_rental_contract/aceapt_daily.dart';
import '../lease contracts/equipment_rental_contract/aceapt_equipment.dart';
import '../lease contracts/house_rental_contact/aceapt_house.dart';
import '../lease contracts/rental_contract_cancellation/aceapt_cancellation.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class LeaseContractsCards extends StatelessWidget {
  const LeaseContractsCards({super.key});

  @override
  Widget build(BuildContext context) {
    final localizations = AppLocalizations.of(context)!;

    return Scaffold(
      appBar: AppBar(
        title: Text(localizations.leaseContracts), // Use localized title
        backgroundColor: QColors.secondary,
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                localizations.chooseYourContract, // Localized guidance text
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 20),
              // Car Rental Contract
              buildLeaseCard(
                context,
                localizations.carRentalContract, // Localized title
                Iconsax.car,
                const AceptCar(),
              ),
              const SizedBox(height: 12),
              // House Rental Contract
              buildLeaseCard(
                context,
                localizations.houseRentalContract, // Localized title
                Iconsax.home,
                const AceaptHouse(),
              ),
              const SizedBox(height: 12),
              // Equipment Rental Contract
              buildLeaseCard(
                context,
                localizations.equipmentRentalContract, // Localized title
                Iconsax.box,
                const AceaptEquipment(),
              ),
              const SizedBox(height: 12),
              // Daily Rental Contract
              buildLeaseCard(
                context,
                localizations.dailyRentalContract, // Localized title
                Iconsax.calendar,
                const AceaptDaily(),
              ),
              const SizedBox(height: 12),
              // Rental Contract Cancellation Form
              buildLeaseCard(
                context,
                localizations.cancellationForm, // Localized title
                Iconsax.profile_delete,
                const AceaptCancellation(),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildLeaseCard(
      BuildContext context, String title, IconData icon, Widget page) {
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
