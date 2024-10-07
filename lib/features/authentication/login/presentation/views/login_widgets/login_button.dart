import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../../../../core/utils/constants/colors.dart';
import '../../../../../../core/utils/styles.dart';
import '../../view_model/sign_in_bloc/signin_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

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
    final localizations = AppLocalizations.of(context)!;
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
        child: Text(
          localizations.login,
          style: Styles.textStyle18,
        ),
      ),
    );
  }
}
