import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:qanoni/core/utils/theme/custom_themes/text_theme.dart';
import 'package:qanoni/features/theme/presentation/view_model/cubit/change_theme_cubit.dart';
import '../../../../../../core/utils/app_router.dart';
import '../../../../../../core/utils/constants/sizes.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class ChangeLanguageSettings extends StatelessWidget {
  const ChangeLanguageSettings({super.key});

  @override
  Widget build(BuildContext context) {
    final localizations = AppLocalizations.of(context)!;
    final themeState = context.watch<ThemeCubit>().state;

    final textTheme = themeState.themeMode == ThemeMode.light
        ? QTextTheme.lightTextTheme
        : QTextTheme.darkTextTheme;

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: ListTile(
        onTap: () {
          GoRouter.of(context).push(AppRouter.kChangeLanguageView);
        },
        leading: const Icon(
          Icons.language_outlined,
        ),
        title: Text(
          localizations.settingsLanguage,
          style: textTheme.headlineSmall,
        ),
        trailing: const Icon(
          Icons.arrow_forward_ios,
          size: QSizes.iconMd,
        ),
      ),
    );
  }
}
