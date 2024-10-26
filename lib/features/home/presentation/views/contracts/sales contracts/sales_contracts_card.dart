import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import '../../../../../../core/utils/constants/colors.dart';
import '../../../../../../core/utils/constants/text_strings.dart';
import '../waiver contracts/business partnership waiver/acept_business_partnership_waiver.dart';
import '../waiver contracts/car_waiver_contract/acept_car_waiver.dart';
import '../waiver contracts/financial waiver/acept_financial.dart';
import '../waiver contracts/intellectual waiver contract/acept_intellectual.dart';
import '../waiver contracts/property waiver contract/acept_property.dart';

class SalesContractsCard extends StatelessWidget {
  const SalesContractsCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(QTexts.waiverContractsTitle),
        backgroundColor: QColors.secondary,
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                "Choose Your Contract",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 20),
              
              // Property Waiver Card
              buildWaiverCard(
                context,
                QTexts.propertyWaiverLabel,
                Iconsax.home5,
                const AceptProperty(),
              ),
              const SizedBox(height: 12),
              
              // Car Waiver Card
              buildWaiverCard(
                context,
                QTexts.vehicleWaiverLabel,
                Iconsax.car5,
                const AceptCarWaiver(),
              ),
              const SizedBox(height: 12),
              
              // Intellectual Rights Waiver Card
              buildWaiverCard(
                context,
                QTexts.intellectualRightsWaiverLabel,
                Iconsax.book,
                const AceptIntellectual(),
              ),
              const SizedBox(height: 12),
              
              // Business Partnership Waiver Card
              buildWaiverCard(
                context,
                QTexts.businessPartnershipWaiverLabel,
                Iconsax.briefcase5,
                const AceptBusinessPartnershipWaiver(),
              ),
              const SizedBox(height: 12),
              
              // Legal/Financial Rights Waiver Card
              buildWaiverCard(
                context,
                QTexts.legalFinancialRightsWaiverLabel,
                Iconsax.dollar_circle,
                const AceptFinancial(),
              ),
              const SizedBox(height: 12),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildWaiverCard(BuildContext context, String label, IconData icon, Widget page) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => page),
        );
      },
      child: Container(
        width: MediaQuery.of(context).size.width * 0.9,
        height: MediaQuery.of(context).size.height * 0.15, // تقليل الارتفاع
        padding: const EdgeInsets.all(16), // تقليل المسافة الداخلية
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              QColors.secondary.withOpacity(0.9),
              QColors.darkerGrey.withOpacity(0.9),
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.circular(15), // تعديل الزوايا لتكون ناعمة
          boxShadow: [
            const BoxShadow(
              color: Colors.black12,
              blurRadius: 10, // تقليل تأثير الظل
              offset: Offset(0, 4),
            ),
          ],
        ),
        child: Row(
          children: [
            CircleAvatar(
              radius: 25, // حجم أصغر للدائرة
              backgroundColor: Colors.white,
              child: Icon(icon, size: 28, color: QColors.secondary), // تصغير الأيقونة
            ),
            const SizedBox(width: 16), // تقليل المسافة بين الأيقونة والنص
            Expanded(
              child: Text(
                label,
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
