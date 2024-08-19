import 'package:flutter/material.dart';
import 'package:qanoni/core/utils/styles.dart';

class SettingsViewBody extends StatelessWidget {
  const SettingsViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    return const Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Center(
          child: Text(
            'Settings View',
            style: Styles.textStyle20,
          ),
        )
      ],
    );
  }
}
