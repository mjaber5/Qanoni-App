import 'package:flutter/material.dart';

class SuccessText extends StatelessWidget {
  const SuccessText({super.key});

  @override
  Widget build(BuildContext context) {
    return const Column(
      children: [
        SizedBox(height: 25),
        Text(
          'Success!',
          style: TextStyle(
            fontSize: 40,
            fontWeight: FontWeight.bold,
          ),
        )
      ],
    );
  }
}
