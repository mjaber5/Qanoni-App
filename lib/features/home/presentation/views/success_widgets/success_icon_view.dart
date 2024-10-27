import 'package:flutter/material.dart';

class SuccessIconView extends StatelessWidget {
  const SuccessIconView({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Center(
          child: Image.asset(
            'assets/images/success_outline.png',
            scale: 2.3,
          ),
        ),
        const SizedBox(height: 25),
      ],
    );
  }
}
