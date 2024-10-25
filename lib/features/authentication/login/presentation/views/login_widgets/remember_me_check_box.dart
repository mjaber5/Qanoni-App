import 'package:flutter/material.dart';
import 'package:qanoni/core/utils/constants/colors.dart';

import 'forget_password_widgets.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';


class LoginActionText extends StatelessWidget {
  const LoginActionText({super.key});

  @override
  Widget build(BuildContext context) {
    final localizations = AppLocalizations.of(context)!;
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
           Text(
           localizations.rememberMe,
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
            child:  Text(
             localizations.forgotPassword ,
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
