import 'dart:developer';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:provider/provider.dart';
import 'package:qanoni/core/utils/constants/colors.dart';
import 'package:qanoni/core/utils/theme/theme.dart';
import 'package:qanoni/features/languages/view_model/app_langauge_cubit/app_language_cubit.dart';
import 'core/utils/app_router.dart';
import 'features/authentication/auth_blocs/authentication_bloc/authentication_bloc.dart';
import 'package:user_repository/user_reposetory.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'features/theme/presentation/view_model/cubit/change_theme_cubit.dart';
import 'features/theme/presentation/view_model/cubit/change_theme_state.dart';

class Qanoni extends StatelessWidget {
  final UserRepository userRepository;

  const Qanoni(this.userRepository, {super.key});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: Connectivity().onConnectivityChanged,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return loading();
        }

        if (snapshot.hasError) {
          return noInternet();
        }

        if (snapshot.hasData) {
          List<ConnectivityResult>? result = snapshot.data;
          bool isConnected =
              result?.any((r) => r != ConnectivityResult.none) ?? false;
          if (!isConnected) {
            return noInternet();
          } else {
            return buildMainApp(context);
          }
        } else {
          return loading();
        }
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
        BlocProvider(create: (context) => ThemeCubit()),
      ],
      child:
          BlocBuilder<ThemeCubit, ThemeState>(builder: (context, themeState) {
        return BlocBuilder<LocaleCubit, LocaleState>(
          // Listen to LocaleCubit
          builder: (context, localeState) {
            return MaterialApp.router(
              routerConfig: AppRouter.router,
              themeMode: themeState.themeMode,
              theme: QAppTheme.lightTheme,
              darkTheme: QAppTheme.darkTheme,
              debugShowCheckedModeBanner: false,
              locale: localeState.locale, // Use the current locale state
              supportedLocales: const [Locale('en'), Locale('ar')],
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
      }),
    );
  }

  Widget loading() {
    return const Directionality(
      textDirection: TextDirection.ltr,
      child: Center(
        child: CircularProgressIndicator(
          valueColor: AlwaysStoppedAnimation(QColors.secondary),
        ),
      ),
    );
  }

  Widget noInternet() {
    return Directionality(
      textDirection: TextDirection.ltr,
      child: Column(
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
              style: TextStyle(
                fontSize: 22,
              ),
            ),
          ),
          Container(
            margin: const EdgeInsets.only(bottom: 20),
            child: const Text('Check your connection, then refresh the page.'),
          ),
          ElevatedButton(
            style: ButtonStyle(
              backgroundColor: WidgetStateProperty.all(QColors.white),
              foregroundColor: WidgetStateProperty.all(QColors.black),
            ),
            onPressed: () async {
              List<ConnectivityResult> result =
                  await Connectivity().checkConnectivity();
              log(result.toString());
            },
            child: const Text('Refresh'),
          ),
        ],
      ),
    );
  }
}
