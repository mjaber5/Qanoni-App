import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:qanoni/core/utils/constants/colors.dart';
import 'package:qanoni/core/utils/constants/text_strings.dart';
import 'package:qanoni/core/utils/styles.dart';

class LoginTextAboutApp extends StatelessWidget {
  const LoginTextAboutApp({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 16, left: 16),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            QTexts.loginAboutApp,
            style: Styles.textStyle16.copyWith(
              color: QColors.darkGrey,
            ),
          ),
        ],
      ),
    );
  }
}
