import 'package:flutter/material.dart';
import 'package:qanoni/features/authentication/presentation/views/widgets/signup_widgets/signup_button.dart';
import 'package:qanoni/features/authentication/presentation/views/widgets/signup_widgets/signup_logo_text.dart';
import 'package:qanoni/features/authentication/presentation/views/widgets/signup_widgets/signup_text_feilds.dart';
import 'package:qanoni/features/authentication/presentation/views/widgets/signup_widgets/signup_text_navigator.dart';

class SignupViewBody extends StatelessWidget {
  const SignupViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    return const Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        SignupLogoText(),
        SizedBox(
          height: 50,
        ),
        SignupTextFeilds(),
        SignupButton(),
        SignupTextNavigator(),
      ],
    );
  }
}
