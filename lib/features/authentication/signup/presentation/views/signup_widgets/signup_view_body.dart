import 'package:flutter/material.dart';

import 'package:qanoni/features/authentication/signup/presentation/views/signup_widgets/signup_button.dart';
import 'package:qanoni/features/authentication/signup/presentation/views/signup_widgets/signup_logo_text.dart';
import 'package:qanoni/features/authentication/signup/presentation/views/signup_widgets/signup_text_about_app.dart';
import 'package:qanoni/features/authentication/signup/presentation/views/signup_widgets/signup_text_condition.dart';
import 'package:qanoni/features/authentication/signup/presentation/views/signup_widgets/signup_text_feilds.dart';
import 'package:qanoni/features/authentication/signup/presentation/views/signup_widgets/signup_text_navigator.dart';

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
                height: 25,
              ),
              SignupTextFeilds(),
              SignupButton(),
              SignupTextNavigator(),
              SizedBox(
                height: 16,
              ),
              SignupTextCondition(),
            ],
          ),
        ),
      ),
    );
  }
}
