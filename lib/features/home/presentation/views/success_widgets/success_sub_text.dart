import 'package:flutter/material.dart';

class SuccessSubText extends StatelessWidget {
  const SuccessSubText({super.key});

  @override
  Widget build(BuildContext context) {
    return const Column(
      children: [
        SizedBox(height: 10),
        Text(
          textAlign: TextAlign.center,
          'build contract done!\nThank you for trust us',
          style: TextStyle(
            fontSize: 18,
            color: Colors.grey,
          ),
        )
      ],
    );
  }
}
