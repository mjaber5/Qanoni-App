import 'package:flutter/material.dart';
import 'package:qanoni/core/utils/constants/colors.dart';
import 'package:qanoni/core/utils/constants/text_strings.dart';
import 'package:qanoni/core/utils/styles.dart';

class LoginTextForgotPassword extends StatelessWidget {
  const LoginTextForgotPassword({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 16),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          TextButton(
            onPressed: () {
              // ToDo Navigator Forgot password view
            },
            child: Text(
              QTexts.loginForgotPassword,
              style: Styles.textStyle14.copyWith(
                color: QColors.secondary,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
