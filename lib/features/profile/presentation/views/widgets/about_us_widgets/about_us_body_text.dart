import 'package:flutter/material.dart';
import 'package:qanoni/core/utils/constants/text_strings.dart';

class AboutUsBodyText extends StatelessWidget {
  const AboutUsBodyText({super.key});

  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.symmetric(horizontal: 16, vertical: 24),
      child: Column(
        children: [
          Text(
            textAlign: TextAlign.center,
            QTexts.aboutUsBodyText,
          ),
          Text(
            textAlign: TextAlign.center,
            QTexts.aboutUsBodyText,
          ),
          Text(
            textAlign: TextAlign.center,
            QTexts.aboutUsBodyText,
          ),
          Text(
            textAlign: TextAlign.center,
            QTexts.aboutUsBodyText,
          ),
        ],
      ),
    );
  }
}
