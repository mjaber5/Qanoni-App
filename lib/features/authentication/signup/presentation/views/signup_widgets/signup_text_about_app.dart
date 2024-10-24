import 'package:flutter/material.dart';
import 'package:qanoni/core/utils/constants/text_strings.dart';
import '../../../../../../core/utils/constants/colors.dart';
import '../../../../../../core/utils/styles.dart';

class SignupTextAboutApp extends StatelessWidget {
  const SignupTextAboutApp({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          QTexts.signupAboutApp,
          style: Styles.textStyle16.copyWith(
            color: QColors.darkGrey,
          ),
        ),
      ],
    );
  }
}
