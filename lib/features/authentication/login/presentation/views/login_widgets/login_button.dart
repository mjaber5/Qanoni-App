import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:provider/provider.dart';
import 'package:toasty_box/toast_enums.dart';
import 'package:toasty_box/toast_service.dart';

import '../../../../../../core/utils/constants/colors.dart';
import '../../../../../../core/utils/styles.dart';
import '../../view_model/sign_in_bloc/signin_bloc.dart';

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
        left: 8,
        right: 8,
      ),
      child: SizedBox(
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
              ToastService.showErrorToast(
                context,
                length: ToastLength.medium,
                expandedHeight: 100,
                message: "Please fill fields!",
              );
              log('Form is not valid. Show errors.');
            }
          },
          style: ElevatedButton.styleFrom(
            elevation: 0,
            foregroundColor: Colors.white,
            backgroundColor: QColors.secondary,
            disabledBackgroundColor: Colors.grey,
            disabledForegroundColor: Colors.grey,
            padding: const EdgeInsets.symmetric(vertical: 18),
            textStyle: const TextStyle(
              fontSize: 16,
              color: Colors.white,
              fontWeight: FontWeight.w600,
            ),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
          ),
          child: Text(
            localizations.login,
            style: Styles.textStyle18,
          ),
        ),
      ),
    );
  }
}
