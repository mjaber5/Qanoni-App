import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:qanoni/core/utils/app_router.dart';
import 'package:qanoni/core/utils/constants/colors.dart';

class SignupTextNavigator extends StatelessWidget {
  const SignupTextNavigator({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TextButton(
          onPressed: () {
            GoRouter.of(context).pushReplacement(AppRouter.kLoginView);
          },
          child: const Text.rich(
            TextSpan(
              text: 'Already have an account? ',
              style: TextStyle(
                fontSize: 14,
                color: QColors.textSecondary,
              ),
              children: [
                TextSpan(
                  text: 'Login',
                  style: TextStyle(
                    color: QColors.secondary,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
