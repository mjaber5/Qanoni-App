import 'package:flutter/material.dart';
import 'package:qanoni/features/notification/presentation/views/widgets/services_card_notif_item.dart';

class ServicesCardListViewNotification extends StatelessWidget {
  const ServicesCardListViewNotification({super.key});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: SizedBox(
        child: ListView.builder(
          itemCount: 20,
          itemBuilder: (context, index) {
            return const ServicesCardNotifItem(
              notifications: [],
            );
          },
        ),
      ),
    );
  }
}
