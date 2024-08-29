import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:qanoni/core/utils/app_router.dart';
import 'package:qanoni/core/utils/theme/change_theme_notifire.dart';
import 'package:qanoni/core/utils/theme/theme.dart';
import 'package:user_repository/user_reposetory.dart';

class Qanoni extends StatelessWidget {
  final UserRepository userRepository;
  const Qanoni({
    super.key,
    required this.userRepository,
  });

  @override
  Widget build(BuildContext context) {
    return Consumer<ThemeNotifier>(
      builder: (context, themeNotifier, child) => MaterialApp.router(
        routerConfig: AppRouter.router,
        themeMode: themeNotifier.currentTheme,
        theme: QAppTheme.lightTheme,
        darkTheme: QAppTheme.darkTheme,
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}
