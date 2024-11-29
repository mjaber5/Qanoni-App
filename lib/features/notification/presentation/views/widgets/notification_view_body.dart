import 'package:flutter/material.dart';
import 'package:qanoni/features/notification/presentation/views/widgets/custom_notification_app_bar.dart';

import 'notification_content.dart';

class NotificationViewBody extends StatelessWidget {
  const NotificationViewBody({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return const Column(
      children: [
        AppbarNotification(),
        Expanded(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 4.0),
            child: NotificationContent(),
          ),
        ),
      ],
    );
  }
}
