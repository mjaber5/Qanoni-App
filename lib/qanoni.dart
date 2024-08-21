import 'package:flutter/material.dart';
import 'package:qanoni/core/utils/app_router.dart';
import 'package:qanoni/core/utils/theme/theme.dart';

class Qanoni extends StatelessWidget {
  const Qanoni({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      routerConfig: AppRouter.router,
      themeMode: ThemeMode.system,
      theme: QAppTheme.lightTheme,
      darkTheme: QAppTheme.darkTheme,
      debugShowCheckedModeBanner: false,
    );
  }
}
