import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';
import 'package:qanoni/core/utils/app_router.dart';
import 'package:qanoni/core/utils/theme/change_theme_notifire.dart';
import 'package:qanoni/core/utils/theme/theme.dart';
import 'package:qanoni/features/authentication/blocs/authentication_bloc/authentication_bloc.dart';
import 'package:user_repository/user_reposetory.dart';

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
        ),
      ),
    );
  }
}
