import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:provider/provider.dart';
import 'core/utils/app_router.dart';
import 'core/utils/theme/change_theme_notifire.dart';
import 'core/utils/theme/theme.dart';
import 'features/authentication/blocs/authentication_bloc/authentication_bloc.dart';
import 'package:user_repository/user_reposetory.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class Qanoni extends StatelessWidget {
  final UserRepository userRepository;

  const Qanoni(this.userRepository, {super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<ThemeNotifier>(
          create: (_) => ThemeNotifier(),
        ),
        RepositoryProvider<AuthenticationBloc>(
          create: (context) => AuthenticationBloc(
            userRepository: userRepository,
          ),
        ),
      ],
      child: Consumer<ThemeNotifier>(
        builder: (context, themeNotifier, child) => MaterialApp.router(
          routerConfig: AppRouter.router,
          themeMode: themeNotifier.currentTheme,
          theme: QAppTheme.lightTheme,
          darkTheme: QAppTheme.darkTheme,
          debugShowCheckedModeBanner: false,
          locale: const Locale(
            'en',
          ), // Set the default locale here
          supportedLocales:
              AppLocalizations.supportedLocales, // Use your supported locales
          localizationsDelegates: const [
            AppLocalizations.delegate,
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
          ],
          localeResolutionCallback: (locale, supportedLocales) {
            if (locale == null) {
              return supportedLocales.first;
            }
            for (var supportedLocale in supportedLocales) {
              if (supportedLocale.languageCode == locale.languageCode &&
                  supportedLocale.countryCode == locale.countryCode) {
                return supportedLocale;
              }
            }
            return supportedLocales.first;
          },
        ),
      ),
    );
  }
}
