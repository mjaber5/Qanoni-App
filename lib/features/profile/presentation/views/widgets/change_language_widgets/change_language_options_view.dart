import 'package:flutter/material.dart';
import '../../../../../../core/utils/constants/colors.dart';
import '../../../../../../core/utils/constants/text_strings.dart';

enum SingingCharacter { english, arabic }

class OptionsLanguage extends StatefulWidget {
  const OptionsLanguage({super.key});

  @override
  State<OptionsLanguage> createState() => _OptionsLanguageState();
}

class _OptionsLanguageState extends State<OptionsLanguage> {
  SingingCharacter? _character = SingingCharacter.english;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          ListTile(
            title: const Text(QTexts.changeLanguageArabicOption),
            leading: Radio<SingingCharacter>(
              fillColor: WidgetStateProperty.all(QColors.secondary),
              value: SingingCharacter.english,
              groupValue: _character,
              onChanged: (SingingCharacter? value) {
                setState(() {
                  _character = value;
                });
              },
            ),
          ),
          const Divider(
            color: QColors.darkGrey,
            indent: 32,
            endIndent: 32,
          ),
          ListTile(
            title: const Text(QTexts.changeLanguageEnglishOption),
            leading: Radio<SingingCharacter>(
              fillColor: WidgetStateProperty.all(QColors.secondary),
              value: SingingCharacter.arabic,
              groupValue: _character,
              onChanged: (SingingCharacter? value) {
                setState(() {
                  _character = value;
                });
              },
            ),
          ),
        ],
      ),
    );
  }
}
