import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:qanoni/core/utils/app_router.dart';
import 'package:qanoni/core/utils/constants/colors.dart';
import 'package:iconsax/iconsax.dart';

class ContractsCardsView extends StatelessWidget {
  const ContractsCardsView({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: [
          contractsCardsContainer(
            context,
            AppRouter.kLeaseCard,
            'Lease contracts',
            Iconsax.document,
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.01,
          ),
          contractsCardsContainer(
            context,
            AppRouter.kPurchaseView,
            'Waiver Contracts',
            Iconsax.note,
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.01,
          ),
          contractsCardsContainer(
            context,
            AppRouter.kEmploymentCard,
            'Sales Contracts',
            Iconsax.money,
          ),
        ],
      ),
    );
  }

  InkWell contractsCardsContainer(
      BuildContext context, String route, String textTitle, IconData icon) {
    return InkWell(
      onTap: () {
        GoRouter.of(context).push(route);
      },
      child: Container(
        width: MediaQuery.of(context).size.width * 0.9,
        height: MediaQuery.of(context).size.height * 0.13,
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
              const SizedBox(width: 50), 
              Text(textTitle, style: const TextStyle(color: Colors.white)),
            ],
          ),
        ),
      ),
    );
  }
}
