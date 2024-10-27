import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../../core/utils/theme/custom_themes/text_theme.dart';
import '../../../../../../core/utils/constants/colors.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import '../../../../../../features/theme/presentation/view_model/cubit/change_theme_cubit.dart';

class SettingsChangeTheme extends StatefulWidget {
  const SettingsChangeTheme({super.key});

  @override
  State<SettingsChangeTheme> createState() => _SettingsChangeTheme();
}

class _SettingsChangeTheme extends State<SettingsChangeTheme> {
  @override
  Widget build(BuildContext context) {
    final localizations = AppLocalizations.of(context)!;
    final themeState = context.watch<ThemeCubit>().state;

    final textTheme = themeState.themeMode == ThemeMode.light
        ? QTextTheme.lightTextTheme
        : QTextTheme.darkTextTheme;

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12.0),
      child: Container(
        width: MediaQuery.of(context).size.width * 0.95,
        height: MediaQuery.of(context).size.height * 0.13,
        decoration: BoxDecoration(
          color: QColors.darkerGrey.withOpacity(0.4),
          borderRadius: BorderRadius.circular(30),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
          child: GestureDetector(
            child: Row(
              children: [
                Text(
                  localizations.dark,
                  style: textTheme.headlineSmall,
                ),
                const Spacer(),
                Switch(
                  trackColor: WidgetStateProperty.all(QColors.grey),
                  activeColor: QColors.secondary,
                  value: themeState.themeMode == ThemeMode.light,
                  onChanged: (themeChange) {
                    context.read<ThemeCubit>().toggleTheme();
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
