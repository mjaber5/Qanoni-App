import 'package:flutter/material.dart';
import 'package:qanoni/core/utils/constants/colors.dart';

class ButtonHomeView extends StatelessWidget {
  const ButtonHomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: List.generate(3, (index) {
          return Container(
            padding: const EdgeInsets.all(20.0),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(50),
              color: QColors.secondary,
            ),
            child: const Icon(Icons.description_outlined),
          );
        }),
      ),
    );
  }
}
