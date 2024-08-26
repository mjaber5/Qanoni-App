import 'package:flutter/material.dart';

import 'package:qanoni/features/authentication/login/presentation/views/login_widgets/login_button.dart';
import 'package:qanoni/features/authentication/login/presentation/views/login_widgets/login_logo_text.dart';
import 'package:qanoni/features/authentication/login/presentation/views/login_widgets/login_text_about_app.dart';
import 'package:qanoni/features/authentication/login/presentation/views/login_widgets/login_text_condition.dart';
import 'package:qanoni/features/authentication/login/presentation/views/login_widgets/login_text_feilds.dart';
import 'package:qanoni/features/authentication/login/presentation/views/login_widgets/login_forgot_password.dart';
import 'package:qanoni/features/authentication/login/presentation/views/login_widgets/login_text_navigator_signup.dart';

class LoginViewBody extends StatelessWidget {
  const LoginViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    return const SafeArea(
      child: Padding(
        padding: EdgeInsets.all(8.0),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              LoginLogoText(),
              LoginTextAboutApp(),
              SizedBox(
                height: 50,
              ),
              LoginTextFeilds(),
              LoginButton(),
              LoginTextForgotPassword(),
              SizedBox(
                height: 120,
              ),
              LoginTextNavigatorSignup(),
              LoginTextCondition(),
            ],
          ),
        ),
      ),
    );
  }
}
