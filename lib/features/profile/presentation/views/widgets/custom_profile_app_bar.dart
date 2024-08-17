import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:qanoni/core/utils/styles.dart';

class AppbarNotification extends StatefulWidget {
  const AppbarNotification({super.key});

  @override
  State<AppbarNotification> createState() => _AppbarNotificationState();
}

class _AppbarNotificationState extends State<AppbarNotification> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 24, left: 24, top: 40, bottom: 10),
      child: Row(
        children: [
          const Text(
            'Profile',
            style: Styles.textStyle30,
            textAlign: TextAlign.center,
          ),
          const Spacer(),
          IconButton(
            icon: const Icon(
              FontAwesomeIcons.bars,
              size: 22,
            ),
            onPressed: () {},
          )
        ],
      ),
    );
  }
}
