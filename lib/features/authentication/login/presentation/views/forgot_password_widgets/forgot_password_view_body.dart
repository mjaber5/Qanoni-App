import 'package:flutter/material.dart';
import 'package:qanoni/features/authentication/login/presentation/views/forgot_password_widgets/forgot_password_app_bar.dart';

class ForgotPasswordViewBody extends StatelessWidget {
  const ForgotPasswordViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    return const Column(
      children: [
        ForgotPasswordAppBar(),
      ],
    );
  }
}
