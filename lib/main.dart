import 'package:flutter/material.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:qanoni/constant.dart';
import 'package:qanoni/features/splash/presintation/views/splash_view.dart';

void main() {
  runApp(const Qanoni());
}

class Qanoni extends StatelessWidget {
  const Qanoni({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      darkTheme: ThemeData.dark().copyWith(
        scaffoldBackgroundColor: kPrimaryColor,
      ),
      debugShowCheckedModeBanner: false,
      home: const SplashView(),
    );
  }
}
