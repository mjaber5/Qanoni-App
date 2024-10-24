import 'package:flutter/material.dart';
import 'package:qanoni/features/profile/presentation/views/widgets/change_password_widgets/custom_app_bar.dart';

class ChangePasswordViewBody extends StatelessWidget {
  const ChangePasswordViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    return const Column(
      children: [
        CustomChangePasswordAppBar(),
        Center(child: Text('Change Password')),
      ],
    );
  }
}
