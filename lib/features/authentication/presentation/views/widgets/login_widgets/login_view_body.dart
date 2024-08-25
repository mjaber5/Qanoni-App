import 'package:flutter/material.dart';
import 'package:qanoni/features/authentication/presentation/views/widgets/login_widgets/login_button.dart';
import 'package:qanoni/features/authentication/presentation/views/widgets/login_widgets/login_logo_text.dart';
import 'package:qanoni/features/authentication/presentation/views/widgets/login_widgets/login_text_feilds.dart';
import 'package:qanoni/features/authentication/presentation/views/widgets/login_widgets/login_text_navigator.dart';

class LoginViewBody extends StatelessWidget {
  const LoginViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    return const Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        LoginLogoText(),
        LoginTextFeilds(),
        LoginButton(),
        LoginTextNavigator(),
      ],
    );
  }
}
