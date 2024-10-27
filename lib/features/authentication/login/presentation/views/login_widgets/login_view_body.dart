import 'package:flutter/material.dart';

import 'login_input_section.dart';
import 'login_logo_text.dart';
import 'login_text_condition.dart';
import 'login_text_navigator_signup.dart';

class LoginViewBody extends StatelessWidget {
  const LoginViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    return const SafeArea(
      child: Padding(
        padding: EdgeInsets.all(16),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              LoginLogoText(),
              SizedBox(height: 16),
              LoginInputsSection(),
              LoginTextNavigatorSignup(),
              SizedBox(height: 80),
              LoginTextCondition(),
            ],
          ),
        ),
      ),
    );
  }
}
