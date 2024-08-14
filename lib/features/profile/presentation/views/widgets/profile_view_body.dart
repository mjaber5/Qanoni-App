import 'package:flutter/material.dart';
import 'package:qanoni/core/utils/styles.dart';

class ProfileViewBody extends StatelessWidget {
  const ProfileViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Text(
          'Profile',
          style: Styles.textStyle20,
        ),
      ),
    );
  }
}
