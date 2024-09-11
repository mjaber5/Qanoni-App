import 'package:flutter/material.dart';
import 'package:qanoni/core/utils/constants/colors.dart';

class WaiverContractsView extends StatelessWidget {
  const WaiverContractsView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: const Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(
            child: Text(
              'Hello World',
              style: TextStyle(
                color: QColors.darkerGrey,
              ),
            ),
          )
        ],
      ),
    );
  }
}
