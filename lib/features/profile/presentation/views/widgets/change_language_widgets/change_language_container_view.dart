import 'package:flutter/material.dart';
import '../../../../../../core/utils/constants/colors.dart';
import 'change_language_options_view.dart';

class LanguageToogleContainerView extends StatelessWidget {
  const LanguageToogleContainerView({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12.0, horizontal: 12),
      child: Container(
        width: MediaQuery.of(context).size.width * 0.95,
        height: MediaQuery.of(context).size.height * 0.23,
        decoration: BoxDecoration(
          color: QColors.darkerGrey.withOpacity(0.4),
          borderRadius: BorderRadius.circular(30),
        ),
        child: const Padding(
          padding: EdgeInsets.symmetric(horizontal: 12, vertical: 20),
          child: Column(
            children: [
              OptionsLanguage(),
            ],
          ),
        ),
      ),
    );
  }
}
