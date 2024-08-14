import 'package:flutter/material.dart';
import 'package:qanoni/core/utils/styles.dart';

class NotificationViewBody extends StatelessWidget {
  const NotificationViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Text(
          'Notification',
          style: Styles.textStyle20,
        ),
      ),
    );
  }
}
