import 'package:flutter/material.dart';
import 'package:qanoni/core/utils/styles.dart';

class LabelTextFieldProfileView extends StatelessWidget {
  const LabelTextFieldProfileView({
    super.key,
    required this.text,
  });

  final String text;

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: Styles.textStyle16.copyWith(
        fontWeight: FontWeight.w500,
      ),
    );
  }
}
