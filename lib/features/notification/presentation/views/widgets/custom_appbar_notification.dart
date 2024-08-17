import 'package:flutter/material.dart';
import 'package:qanoni/core/utils/styles.dart';

class AppbarNotification extends StatelessWidget {
  const AppbarNotification({super.key});

  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.only(right: 24, left: 24, top: 40, bottom: 10),
      child: Row(
        children: [
          Text(
            'Notification',
            style: Styles.textStyle30,
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
