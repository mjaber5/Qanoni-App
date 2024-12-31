import 'package:flutter/material.dart';
import 'signup_text_about_app.dart';

import 'signup_logo_text.dart';
import 'signup_text_condition.dart';
import 'signup_text_feilds.dart';

class SignupViewBody extends StatelessWidget {
  const SignupViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    return const SafeArea(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 28, vertical: 30),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              SignupLogoText(),
              SignupTextAboutApp(),
              SizedBox(
                height: 22,
              ),
              SignupTextFeilds(),
              SizedBox(height: 32),
              SignupTextCondition(),
            ],
          ),
        ),
      ),
    );
  }
}
