import 'package:flutter/material.dart';
import 'package:qanoni/features/authentication/login/presentation/views/forgot_password_widgets/forgot_password_view_body.dart';

class ForgotPasswordView extends StatelessWidget {
  const ForgotPasswordView({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: ForgotPasswordViewBody(),
    );
  }
}
