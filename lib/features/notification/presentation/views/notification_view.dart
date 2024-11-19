import 'package:flutter/material.dart';

import 'widgets/notification_tab_bar.dart';

class NotificationView extends StatelessWidget {
  const NotificationView({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: NotificationTabBar(),
    );
  }
}
