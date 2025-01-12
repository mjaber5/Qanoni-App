import 'package:flutter/material.dart';
import 'package:qanoni/core/utils/styles.dart';

class TotalPrice extends StatelessWidget {
  const TotalPrice({super.key, required this.total, required this.value});
  final String total, value;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(
          total,
          textAlign: TextAlign.center,
          style: Styles.style24,
        ),
        const Spacer(),
        Text(
          '\$$value',
          textAlign: TextAlign.center,
          style: Styles.style24,
        ),
      ],
    );
  }
}
