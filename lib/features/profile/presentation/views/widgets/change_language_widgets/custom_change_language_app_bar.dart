import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:qanoni/core/utils/constants/text_strings.dart';
import 'package:qanoni/core/utils/styles.dart';

class CustomChangeLanguageAppBar extends StatelessWidget {
  const CustomChangeLanguageAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 8, left: 8, top: 40, bottom: 10),
      child: Row(
        children: [
          IconButton(
            onPressed: () {
              GoRouter.of(context).pop();
            },
            icon: const Icon(Icons.arrow_back_ios),
          ),
          const Text(
            QTexts.changeLanguageAppBarTitle,
            style: Styles.textStyle30,
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
