import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../../../../../core/utils/constants/colors.dart';
import 'forget_password_widgets.dart';

class LoginActionText extends StatelessWidget {
  const LoginActionText({super.key});

  @override
  Widget build(BuildContext context) {
    final localizations = AppLocalizations.of(context)!;

    final isArabic = Directionality.of(context) == TextDirection.rtl;

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
            style: const TextStyle(
              fontWeight: FontWeight.w500,
            ),
          ),
          SizedBox(width: isArabic ? 115 : 30),
          TextButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const ForgetPasswordWidgets(),
                ),
              );
            },
            child: Text(
              localizations.forgotPassword,
              style: const TextStyle(
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
