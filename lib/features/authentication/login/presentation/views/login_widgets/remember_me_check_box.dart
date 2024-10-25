import 'package:flutter/material.dart';
import 'package:qanoni/core/utils/constants/colors.dart';

import 'forget_password_widgets.dart';

class LoginActionText extends StatelessWidget {
  const LoginActionText({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 12),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Checkbox(
            value: true,
            onChanged: (value) {},
            checkColor: QColors.white,
            fillColor: WidgetStateProperty.all(QColors.secondary),
          ),
          const Text(
            'Remember Me',
            style: TextStyle(
              fontWeight: FontWeight.w500,
            ),
          ),
          const SizedBox(width: 35),
          TextButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const ForgetPasswordWidgets(),
                ),
              );
            },
            child: const Text(
              'Forget Password?',
              style: TextStyle(
                fontSize: 14,
                color: QColors.secondary,
              ),
            ),
          )
        ],
      ),
    );
  }
}
