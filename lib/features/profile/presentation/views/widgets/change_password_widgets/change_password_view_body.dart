import 'package:flutter/material.dart';
import 'change_password.dart';
import 'custom_app_bar.dart';

import 'change_password_logo_text.dart';
import 'change_password_text_condition.dart';

class ChangePasswordViewBody extends StatelessWidget {
  const ChangePasswordViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    return const SingleChildScrollView(
      child: Column(
        children: [
          CustomChangePasswordAppBar(),
          ChangePasswordText(),
          ChangePassword(),
          ChangePasswordTextCondition()
        ],
      ),
    );
  }
}
