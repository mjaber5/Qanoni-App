import 'package:flutter/material.dart';
import '../../../../../core/utils/constants/text_strings.dart';

class CustomAppBar extends StatelessWidget {
  const CustomAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.only(right: 24, left: 24, top: 40, bottom: 10),
      child: Row(
        children: [
          Text(
            QTexts.chatbotAppbarTitle,
            style: TextStyle(
              fontSize: 28,
              fontWeight: FontWeight.bold,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
