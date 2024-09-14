import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:qanoni/core/utils/constants/colors.dart';
import 'package:qanoni/core/utils/constants/text_strings.dart';
import 'package:qanoni/core/utils/styles.dart';
import 'package:qanoni/features/authentication/blocs/sign_in_bloc/signin_bloc.dart';

class LoginButton extends StatelessWidget {
  const LoginButton({
    super.key,
    required GlobalKey<FormState> formKey,
    required this.emailController,
    required this.passwordController,
  }) : _formKey = formKey;

  final GlobalKey<FormState> _formKey;
  final TextEditingController emailController;
  final TextEditingController passwordController;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
        bottom: 12,
        top: 16,
        left: 18,
        right: 18,
      ),
      child: ElevatedButton(
        onPressed: () {
          if (_formKey.currentState!.validate()) {
            context.read<SigninBloc>().add(
                  SignInRequired(
                    emailController.text,
                    passwordController.text,
                  ),
                );
            log('Form is valid. Proceed with login.');
          } else {
            log('Form is not valid. Show errors.');
          }
        },
        style: ElevatedButton.styleFrom(
          padding: const EdgeInsets.symmetric(vertical: 15),
          backgroundColor: QColors.secondary,
        ),
        child: const Text(
          QTexts.loginButton,
          style: Styles.textStyle18,
        ),
      ),
    );
  }
}
