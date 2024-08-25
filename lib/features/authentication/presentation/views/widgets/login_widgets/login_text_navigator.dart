import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:qanoni/core/utils/app_router.dart';
import 'package:qanoni/core/utils/constants/colors.dart';

class LoginTextNavigator extends StatelessWidget {
  const LoginTextNavigator({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TextButton(
          onPressed: () {
            // ToDo Navigator Forgot password view
          },
          child: const Text(
            'Forgot Password?',
            style: TextStyle(
              fontSize: 14,
              color: QColors.secondary,
            ),
          ),
        ),
        const SizedBox(height: 10),
        TextButton(
          onPressed: () {
            GoRouter.of(context).pushReplacement(AppRouter.kSignupView);
          },
          child: const Text.rich(
            TextSpan(
              text: "Don't have an account? ",
              style: TextStyle(
                color: QColors.textSecondary,
                fontSize: 14,
              ),
              children: [
                TextSpan(
                  text: 'Sign Up',
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
