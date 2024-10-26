import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:qanoni/features/languages/view_model/app_langauge_cubit/app_language_cubit.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../../../../core/utils/constants/colors.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';


enum SingingCharacter { english, arabic }

class OptionsLanguage extends StatefulWidget {
  const OptionsLanguage({super.key});

  @override
  State<OptionsLanguage> createState() => _OptionsLanguageState();
}

class _OptionsLanguageState extends State<OptionsLanguage> {
  SingingCharacter? _character;

  @override
  void initState() {
    super.initState();
    _loadSelectedLanguage();
  }

  Future<void> _loadSelectedLanguage() async {
    final prefs = await SharedPreferences.getInstance();
    final savedLocaleCode = prefs.getString('selected_locale');

    if (savedLocaleCode != null) {
      setState(() {
        _character = savedLocaleCode == 'ar'
            ? SingingCharacter.arabic
            : SingingCharacter.english;
      });
    } else {
      _character = SingingCharacter.english;
    }
  }

  @override
  Widget build(BuildContext context) {
    final localizations = AppLocalizations.of(context)!;
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          ListTile(
            title:  Text(localizations.changeLanguageArabicOption),
            leading: Radio<SingingCharacter>(
              fillColor: WidgetStateProperty.all(QColors.secondary),
              value: SingingCharacter.arabic,
              groupValue: _character,
              onChanged: (SingingCharacter? value) {
                setState(() {
                  _character = value;

                  context.read<LocaleCubit>().setLocale(const Locale('ar'));
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
            title:  Text(localizations.changeLanguageEnglishOption),
            leading: Radio<SingingCharacter>(
              fillColor: WidgetStateProperty.all(QColors.secondary),
              value: SingingCharacter.english,
              groupValue: _character,
              onChanged: (SingingCharacter? value) {
                setState(() {
                  _character = value;

                  context.read<LocaleCubit>().setLocale(const Locale('en'));
                });
              },
            ),
          ),
        ],
      ),
    );
  }
}
