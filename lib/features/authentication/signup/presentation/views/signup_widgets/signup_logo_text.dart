import 'package:flutter/material.dart';
import 'package:qanoni/core/utils/constants/colors.dart';
import 'package:qanoni/core/utils/constants/text_strings.dart';
import 'package:qanoni/core/utils/styles.dart';

class SignupLogoText extends StatelessWidget {
  const SignupLogoText({super.key});

  @override
  Widget build(BuildContext context) {
    return Text(
      QTexts.signupTitleView,
      style: Styles.textStyle30.copyWith(
        color: QColors.secondary,
      ),
    );
  }
}
