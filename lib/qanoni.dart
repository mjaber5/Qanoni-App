import 'package:flutter/material.dart';
import 'package:qanoni/constant.dart';
import 'package:qanoni/core/utils/app_router.dart';

class Qanoni extends StatelessWidget {
  const Qanoni({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      routerConfig: AppRouter.router,
      darkTheme: ThemeData.dark().copyWith(
        scaffoldBackgroundColor: kPrimaryColor,
      ),
      debugShowCheckedModeBanner: false,
    );
  }
}
