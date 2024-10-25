import 'dart:developer';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:provider/provider.dart';
import 'package:qanoni/core/utils/constants/colors.dart';
import 'package:qanoni/core/utils/theme/theme.dart';
import 'package:qanoni/features/languages/view_model/app_langauge_cubit/app_language_cubit.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'core/utils/app_router.dart';
import 'features/authentication/auth_blocs/authentication_bloc/authentication_bloc.dart';
import 'package:user_repository/user_reposetory.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'features/theme/presentation/view_model/cubit/change_theme_cubit.dart';
import 'features/theme/presentation/view_model/cubit/change_theme_state.dart';

class Qanoni extends StatelessWidget {
  final UserRepository userRepository;
  final SharedPreferences? prefs;

  const Qanoni(this.userRepository, {super.key, this.prefs});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<List<ConnectivityResult>>(
      stream: Connectivity().onConnectivityChanged,
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          log("Connectivity error: ${snapshot.error}");
          return _noInternetWidget();
        }

        if (snapshot.hasData) {
          bool isConnected = snapshot.data
                  ?.any((result) => result != ConnectivityResult.none) ??
              false;
          return isConnected ? buildMainApp(context) : _noInternetWidget();
        }

        return _loadingWidget();
      },
    );
  }

  Widget buildMainApp(BuildContext context) {
    return MultiProvider(
      providers: [
        RepositoryProvider<AuthenticationBloc>(
          create: (context) =>
              AuthenticationBloc(userRepository: userRepository),
        ),
        BlocProvider(create: (context) => LocaleCubit()),
        BlocProvider(create: (context) => ThemeCubit(prefs!)),
      ],
      child: BlocBuilder<ThemeCubit, ThemeState>(
        builder: (context, themeState) {
          return BlocBuilder<LocaleCubit, LocaleState>(
            builder: (context, localeState) {
              return MaterialApp.router(
                routerConfig: AppRouter.router,
                themeMode: themeState.themeMode,
                theme: QAppTheme.lightTheme,
                darkTheme: QAppTheme.darkTheme,
                debugShowCheckedModeBanner: false,
                locale: localeState.locale,
                supportedLocales: const [Locale('ar'), Locale('ar')],
                localizationsDelegates: const [
                  AppLocalizations.delegate,
                  GlobalMaterialLocalizations.delegate,
                  GlobalWidgetsLocalizations.delegate,
                  GlobalCupertinoLocalizations.delegate,
                ],
                localeResolutionCallback: (deviceLocale, supportedLocales) {
                  for (var locale in supportedLocales) {
                    if (deviceLocale != null &&
                        deviceLocale.languageCode == locale.languageCode) {
                      return deviceLocale;
                    }
                  }
                  return supportedLocales.first;
                },
              );
            },
          );
        },
      ),
    );
  }

  Widget _loadingWidget() {
    return const MaterialApp(
      home: Scaffold(
        body: Center(
          child: CircularProgressIndicator(
            valueColor: AlwaysStoppedAnimation(QColors.secondary),
          ),
        ),
      ),
    );
  }

  Widget _noInternetWidget() {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          backgroundColor: QColors.secondary,
          centerTitle: true,
          title: const Text(
            'No connection',
            style: TextStyle(
              fontSize: 24,
              color: QColors.white,
            ),
          ),
        ),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              'assets/images/no_internet.png',
              color: QColors.error,
              height: 100,
            ),
            Container(
              margin: const EdgeInsets.only(top: 20, bottom: 10),
              child: const Text(
                'No Internet connection',
                style: TextStyle(fontSize: 22),
              ),
            ),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.0),
              child: Text('Check your connection, then refresh the page.'),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              style: ButtonStyle(
                backgroundColor: WidgetStateProperty.all(QColors.white),
                foregroundColor: WidgetStateProperty.all(QColors.black),
              ),
              onPressed: () async {
                var result = await Connectivity().checkConnectivity();
                log("Connectivity check: $result");
              },
              child: const Text('Refresh'),
            ),
          ],
        ),
      ),
    );
  }
}
