import 'package:flutter/material.dart';

import 'custom_notification_app_bar.dart';
import 'widget/screnhome.dart';

class NotificationViewBody extends StatelessWidget {
  const NotificationViewBody({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return const Column(
      children: [
        AppbarNotification(),
         Screnhome()     
         ],
    );
  }
}
