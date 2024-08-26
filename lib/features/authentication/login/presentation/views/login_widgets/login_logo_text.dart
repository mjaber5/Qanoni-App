import 'package:flutter/material.dart';
import 'package:qanoni/core/utils/constants/colors.dart';
import 'package:qanoni/core/utils/constants/text_strings.dart';
import 'package:qanoni/core/utils/styles.dart';

class LoginLogoText extends StatelessWidget {
  const LoginLogoText({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding:
              const EdgeInsets.only(top: 20.0, left: 16, right: 16, bottom: 12),
          child: Text(
            QTexts.loginWelcomeBackText,
            style: Styles.textStyle30.copyWith(
              color: QColors.secondary,
            ),
          ),
        ),
      ],
    );
  }
}
