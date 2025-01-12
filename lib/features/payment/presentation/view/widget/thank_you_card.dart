import 'package:flutter/material.dart';
import 'package:qanoni/core/utils/styles.dart';
import 'package:qanoni/core/widgets/send_email.dart';
import 'package:qanoni/features/payment/presentation/view/widget/bar_code_section.dart';
import 'package:qanoni/features/payment/presentation/view/widget/card_info_widget.dart';
import 'package:qanoni/features/payment/presentation/view/widget/custom_divider.dart';
import 'package:qanoni/features/payment/presentation/view/widget/payment_item_info.dart';
import 'package:qanoni/features/payment/presentation/view/widget/total_price.dart';

class ThankYouCard extends StatelessWidget {
  const ThankYouCard({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;

    return Container(
      width: double.infinity,
      decoration: ShapeDecoration(
        color: const Color(0xFFEDEDED),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(screenWidth * 0.05),
        ),
      ),
      child: Column(
        children: [
          Expanded(
            child: Padding(
              padding: EdgeInsets.only(
                left: screenWidth * 0.06,
                right: screenWidth * 0.06,
                top: screenHeight * 0.1,
              ),
              child: Column(
                children: [
                  const Text(
                    'Thank you!',
                    style: Styles.style25,
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: screenHeight * 0.005),
                  Text(
                    'Your transaction was successful',
                    textAlign: TextAlign.center,
                    style: Styles.style20,
                  ),
                  SizedBox(height: screenHeight * 0.04),
                  const PaymentItemInfo(title: 'Date', value: '01/24/2023'),
                  SizedBox(height: screenHeight * 0.02),
                  const PaymentItemInfo(title: 'Time', value: '10:15 AM'),
                  SizedBox(height: screenHeight * 0.025),
                  const PaymentItemInfo(title: 'To', value: 'Sam Louis'),
                  SizedBox(height: screenHeight * 0.03),
                  const CustomDivider(),
                  SizedBox(height: screenHeight * 0.03),
                  const TotalPrice(total: 'Total', value: '50.97'),
                  SizedBox(height: screenHeight * 0.03),
                  const CardInfoWidget(),
                  const Spacer(),
                  const BarCodeSection(),
                ],
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(
              bottom: screenHeight * 0.015,
              left: screenWidth * 0.06,
              right: screenWidth * 0.06,
              top: screenHeight * 0.025,
            ),
            child: ElevatedButton(
              onPressed: () {
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => const SendEmailButton()));
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.green.shade600,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(screenWidth * 0.06),
                ),
                elevation: 10,
                padding: EdgeInsets.symmetric(
                  vertical: screenHeight * 0.02,
                  horizontal: screenWidth * 0.08,
                ),
                shadowColor: Colors.black54,
              ),
              child: const Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.check_circle_outline,
                    color: Colors.white,
                  ),
                  SizedBox(width: 8),
                  Text(
                    'Finish',
                    style: TextStyle(
                      fontSize: 18,
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
