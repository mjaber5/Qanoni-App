import 'package:flutter/material.dart';
import 'package:qanoni/core/utils/constants/colors.dart';

AppBar buildCustomAppBar({final String? title}) {
  return AppBar(
    centerTitle: true,
    title: const Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text('Q',
            style: TextStyle(
                color: QColors.secondary,
                fontSize: 36,
                fontWeight: FontWeight.bold)),
        Text('anoni',
            style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold)),
      ],
    ),
    elevation: 0,
    backgroundColor: Colors.transparent,
  );
}
