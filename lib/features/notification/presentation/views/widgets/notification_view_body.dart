import 'package:flutter/material.dart';

import 'custom_notification_app_bar.dart';
import 'notification_tab_bar.dart';

class NotificationViewBody extends StatelessWidget {
  const NotificationViewBody({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return const Column(
      children: [
        AppbarNotification(),
        NotificationTabBar()      ],
    );
  }
}
