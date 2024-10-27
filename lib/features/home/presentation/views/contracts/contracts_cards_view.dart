import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../../../core/utils/app_router.dart';
import '../../../../../core/utils/constants/colors.dart';
import 'package:iconsax/iconsax.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class ContractsCardsView extends StatelessWidget {
  const ContractsCardsView({super.key});

  @override
  Widget build(BuildContext context) {
    final localizations = AppLocalizations.of(context)!;
    return Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
             Text(
            localizations.chooseYourContract  ,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 20,  // تصغير حجم الخط
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 20),
            contractsCardsContainer(
              context,
              AppRouter.kLeaseCard,
              localizations.leaseContracts,
              Iconsax.document,
            ),
            const SizedBox(height: 12),  // تصغير الفجوة بين العناصر
            contractsCardsContainer(
              context,
              AppRouter.kWaiverContractsCard,
              localizations.waiverContractsTitle,
              Iconsax.note,
            ),
            const SizedBox(height: 12),
            contractsCardsContainer(
              context,
              AppRouter.kSalesContractsCard,
             localizations.sellCardAppBar,
              Iconsax.money,
            ),
            const SizedBox(height: 12),
            contractsCardsContainer(
              context,
              AppRouter.kEmploymentCard,
              localizations.employmentContract,
              Iconsax.user_add,
            ),
          ],
        ),
      ),
    );
  }

  Widget contractsCardsContainer(
      BuildContext context, String route, String textTitle, IconData icon) {
    return GestureDetector(
      onTap: () {
        GoRouter.of(context).push(route);
      },
      child: Container(
        width: MediaQuery.of(context).size.width * 0.9,
        height: MediaQuery.of(context).size.height * 0.15, // تصغير ارتفاع الحاوية
        padding: const EdgeInsets.all(16), // تصغير المساحة الداخلية
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              QColors.secondary.withOpacity(0.9),
              QColors.darkerGrey.withOpacity(0.9),
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.circular(15), // تعديل الزوايا
          boxShadow: const [
            BoxShadow(
              color: Colors.black12,
              blurRadius: 10, // تصغير الظل
              offset: Offset(0, 4),
            ),
          ],
        ),
        child: Row(
          children: [
            CircleAvatar(
              radius: 25, // تصغير الدائرة
              backgroundColor: Colors.white,
              child: Icon(icon, size: 28, color: QColors.secondary), // تصغير الأيقونة
            ),
            const SizedBox(width: 16), // تصغير الفجوة بين الأيقونة والنص
            Expanded(
              child: Text(
                textTitle,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 18, // تصغير حجم الخط
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            const Icon(Icons.arrow_forward_ios, color: Colors.white, size: 22), // تصغير الأيقونة
          ],
        ),
      ),
    );
  }
}
