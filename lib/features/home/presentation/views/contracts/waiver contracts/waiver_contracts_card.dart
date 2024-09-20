import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:qanoni/core/utils/constants/colors.dart';
import 'car_waiver_contract/acept_car_waiver.dart';

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
        child: Column(
          children: [
            // عقد تنازل عن سيارة
            buildWaiverInkWell(
              context,
              AceptCarWaiver(),
              Iconsax.car5,
              "Car Waiver contract",
              "عقد تنازل عن سيارة",
            ),
            SizedBox(height: MediaQuery.of(context).size.height * 0.01),
            
            // عقد تنازل عن بيت
            buildWaiverInkWell(
              context,
              null,  // تعديل هنا إذا كان لديك صفحة لعقد البيت
              Iconsax.house5,
              "House Waiver contract",
              "عقد تنازل عن بيت",
            ),
            SizedBox(height: MediaQuery.of(context).size.height * 0.01),
            
            // عقد تنازل عن معدات
            buildWaiverInkWell(
              context,
              null,  // تعديل هنا إذا كان لديك صفحة لعقد المعدات
              Iconsax.setting5,
              "Equipment Waiver contract",
              "عقد تنازل عن معدات",
            ),
            SizedBox(height: MediaQuery.of(context).size.height * 0.01),
            
            // عقد تنازل مياومة
            buildWaiverInkWell(
              context,
              null,  // تعديل هنا إذا كان لديك صفحة لعقد المياومة
              Iconsax.calendar_1,
              "Daily Waiver contract",
              "عقد تنازل مياومة",
            ),
            SizedBox(height: MediaQuery.of(context).size.height * 0.01),
            
            // عقد تنازل عن عقد إيجار
            buildWaiverInkWell(
              context,
              null,  // تعديل هنا إذا كان لديك صفحة لعقد الإيجار
              Iconsax.close_circle,
              "Rental Waiver contract",
              "عقد تنازل عن عقد إيجار",
            ),
          ],
        ),
      ),
    );
  }

  // Widget Helper لبناء InkWell وكرت التنازل
  Widget buildWaiverInkWell(BuildContext context, Widget? targetPage, IconData icon, String label, String arabicLabel) {
    return InkWell(
      onTap: targetPage != null
          ? () {
              Navigator.push(context, MaterialPageRoute(builder: (context) => targetPage));
            }
          : null, // إضافة null إذا لم يكن هناك targetPage
      child: buildWaiverCard(context, icon: icon, label: label, arabicLabel: arabicLabel),
    );
  }

  // Widget Helper لبناء كرت التنازل
  Widget buildWaiverCard(BuildContext context,
      {required IconData icon, required String label, required String arabicLabel}) {
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
            Text("$label - $arabicLabel", style: const TextStyle(color: Colors.white)),
          ],
        ),
      ),
    );
  }
}
