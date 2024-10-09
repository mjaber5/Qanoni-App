import 'package:flutter/material.dart';
import 'package:qanoni/core/utils/constants/colors.dart';

class SignupTextCondition extends StatelessWidget {
  const SignupTextCondition({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16.0, top: 16.0),
      child: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Text(
              "By logging in, you agree to our:",
              style: TextStyle(
                color: Colors.grey,
                fontSize: 13,
              ),
            ),
            const SizedBox(height: 4),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                GestureDetector(
                  onTap: () {},
                  child: const Text(
                    "Privacy Policy",
                    style: TextStyle(
                      fontSize: 14,
                      color: QColors.secondary,
                      decoration: TextDecoration.underline,
                    ),
                  ),
                ),
                const Text(
                  " and ",
                  style: TextStyle(
                    color: Colors.grey,
                    fontSize: 13,
                  ),
                ),
                GestureDetector(
                  onTap: () {},
                  child: const Text(
                    "Terms of Use",
                    style: TextStyle(
                      fontSize: 14,
                      color: QColors.secondary,
                      decoration: TextDecoration.underline,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
