import 'package:flutter/material.dart';
import 'package:qanoni/core/utils/constants/colors.dart';
import 'package:qanoni/core/utils/constants/text_strings.dart';
import 'package:qanoni/core/utils/styles.dart';

class LoginButton extends StatelessWidget {
  const LoginButton({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 20.0, right: 20.0, top: 14),
          child: ElevatedButton(
            onPressed: () {
              // Todo Navigator Screen
            },
            style: ElevatedButton.styleFrom(
              padding: const EdgeInsets.symmetric(vertical: 15),
              backgroundColor: QColors.secondary,
            ),
            child: const Text(
              QTexts.loginButton,
              style: Styles.textStyle18,
            ),
          ),
        ),
      ],
    );
  }
}
