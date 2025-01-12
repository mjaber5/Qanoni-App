import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:qanoni/core/utils/styles.dart';

class BarCodeSection extends StatelessWidget {
  const BarCodeSection({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        SvgPicture.asset('assets/images/barcode.svg'),
        Container(
          width: 113,
          height: 58,
          decoration: ShapeDecoration(
            shape: RoundedRectangleBorder(
              side: const BorderSide(
                width: 1.5,
                color: Color(0xFF34A853),
              ),
              borderRadius: BorderRadius.circular(15),
            ),
          ),
          child: Center(
            child: Text(
              'Paid',
              style: Styles.style25.copyWith(
                color: const Color(0xFF34A853),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
