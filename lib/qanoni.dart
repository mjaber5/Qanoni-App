import 'dart:developer';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:provider/provider.dart';
import 'package:qanoni/core/utils/constants/colors.dart';
import 'core/utils/app_router.dart';
import 'core/utils/theme/change_theme_notifire.dart';
import 'core/utils/theme/theme.dart';
import 'features/authentication/auth_blocs/authentication_bloc/authentication_bloc.dart';
import 'package:user_repository/user_reposetory.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class Qanoni extends StatelessWidget {
  final UserRepository userRepository;

  const Qanoni(this.userRepository, {super.key});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: Connectivity().onConnectivityChanged,
      builder: (context, AsyncSnapshot<List<ConnectivityResult>> snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return loading();
        }

        if (snapshot.hasError) {
          return noInternet(); // Error handling
        }

        if (snapshot.hasData) {
          List<ConnectivityResult>? results = snapshot.data;
          // Check if there's any connectivity result that's not 'none'
          bool isConnected =
              results?.any((result) => result != ConnectivityResult.none) ??
                  false;
          if (!isConnected) {
            return noInternet(); // Show no internet widget if all results are 'none'
          } else {
            return buildMainApp(context); // Build the main app if connected
          }
        } else {
          return loading(); // Show loading if no data
        }
      },
    );
  }

  /// This method builds the main app and is called when there's internet access.
  Widget buildMainApp(BuildContext context) {
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
          locale: const Locale('en'),
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
        ),
      ),
    );
  }

  /// Show loading widget while waiting for connectivity data.
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

  /// Show no internet widget when there is no connectivity.
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
              foregroundColor: const WidgetStatePropertyAll(QColors.black),
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
