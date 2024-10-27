import 'dart:ui';

import 'package:flutter/material.dart';
import '../../../../../core/utils/constants/colors.dart';

class CustomView extends StatelessWidget {
  const CustomView({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Align(
          alignment: const AlignmentDirectional(20, -1.2),
          child: Container(
            height: MediaQuery.of(context).size.width,
            width: MediaQuery.of(context).size.width,
            decoration: const BoxDecoration(
              shape: BoxShape.circle,
              color: QColors.secondary,
            ),
          ),
        ),
        Align(
          alignment: const AlignmentDirectional(-2.7, -1.2),
          child: Container(
            height: MediaQuery.of(context).size.width / 1.3,
            width: MediaQuery.of(context).size.width / 1.3,
            decoration: const BoxDecoration(
              shape: BoxShape.circle,
              color: QColors.secondary,
            ),
          ),
        ),
        Align(
          alignment: const AlignmentDirectional(2.7, -1.2),
          child: Container(
            height: MediaQuery.of(context).size.width / 1.3,
            width: MediaQuery.of(context).size.width / 1.3,
            decoration: const BoxDecoration(
              shape: BoxShape.circle,
              color: QColors.secondary,
            ),
          ),
        ),
        BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 60.0, sigmaY: 60.0),
          child: Container(),
        ),
      ],
    );
  }
}
