import 'package:flutter/material.dart';
import 'package:qanoni/features/profile/presentation/views/widgets/custom_profile_app_bar.dart';

class ProfileViewBody extends StatelessWidget {
  const ProfileViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    return const Column(
      children: [
        AppbarNotification(),
      ],
    );
  }
}
