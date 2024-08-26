import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:qanoni/core/utils/app_router.dart';
import 'package:qanoni/core/utils/constants/colors.dart';
import 'package:qanoni/core/utils/constants/text_strings.dart';
import 'package:qanoni/core/utils/styles.dart';

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
          child: Text.rich(
            TextSpan(
              text: QTexts.signupTextQuestion,
              style: Styles.textStyle14.copyWith(
                color: QColors.darkerGrey,
              ),
              children: [
                TextSpan(
                  text: QTexts.signupLoginTextNavigator,
                  style: Styles.textStyle14.copyWith(
                    color: QColors.secondary,
                    fontWeight: FontWeight.w500,
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
