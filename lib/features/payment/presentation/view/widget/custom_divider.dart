import 'package:flutter/material.dart';

class CustomDivider extends StatelessWidget {
  const CustomDivider({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.sizeOf(context).width * 0.8,
      decoration: const ShapeDecoration(
        shape: RoundedRectangleBorder(
          side: BorderSide(
            width: 1.3,
            strokeAlign: BorderSide.strokeAlignCenter,
            color: Color(0xFFC6C6C6),
          ),
        ),
      ),
    );
  }
}
