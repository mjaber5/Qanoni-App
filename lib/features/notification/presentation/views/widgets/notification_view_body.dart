import 'package:flutter/material.dart';

import 'custom_notification_app_bar.dart';
import 'services_card_list_view_nofification.dart';

class NotificationViewBody extends StatelessWidget {
  const NotificationViewBody({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return const Column(
      children: [
        AppbarNotification(),
        ServicesCardListViewNotification(),
      ],
    );
  }
}
