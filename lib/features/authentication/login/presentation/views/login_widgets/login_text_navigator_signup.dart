import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../../../../core/utils/app_router.dart';
import '../../../../../../core/utils/constants/colors.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class LoginTextNavigatorSignup extends StatelessWidget {
  const LoginTextNavigatorSignup({super.key});

  @override
  Widget build(BuildContext context) {
    final localizations = AppLocalizations.of(context)!;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: Column(
        children: [
          SizedBox(
            width: 360,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                elevation: 0,
                backgroundColor: Colors.transparent,
                side: const BorderSide(color: Colors.grey),
                padding: const EdgeInsets.symmetric(vertical: 18),
                textStyle: const TextStyle(
                    fontSize: 16,
                    color: Colors.black,
                    fontWeight: FontWeight.w600),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              onPressed: () {
                GoRouter.of(context).push(AppRouter.kSignupView);
              },
              child:  Text(
                localizations.createAccount
,                style: TextStyle(
                  color: QColors.secondary,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
