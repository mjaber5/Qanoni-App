import 'package:flutter/material.dart';
import 'package:qanoni/features/payment/presentation/view/widget/custom_check_item.dart';
import 'package:qanoni/features/payment/presentation/view/widget/custom_dashed_line.dart';
import 'package:qanoni/features/payment/presentation/view/widget/thank_you_card.dart';

class ThankYouViewBody extends StatelessWidget {
  const ThankYouViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          const ThankYouCard(),
          Positioned(
            left: 20 + 4,
            right: 20 + 4,
            bottom: MediaQuery.sizeOf(context).height * 0.2 + 20,
            child: const CustomDashedLine(),
          ),
          Positioned(
            left: -20,
            bottom: MediaQuery.sizeOf(context).height * 0.2,
            child: const CircleAvatar(
              backgroundColor: Colors.white,
            ),
          ),
          Positioned(
            right: -20,
            bottom: MediaQuery.sizeOf(context).height * 0.2,
            child: const CircleAvatar(
              backgroundColor: Colors.white,
            ),
          ),
          const Positioned(
            top: -50,
            left: 0,
            right: 0,
            child: CustomCheckItem(),
          )
        ],
      ),
    );
  }
}
