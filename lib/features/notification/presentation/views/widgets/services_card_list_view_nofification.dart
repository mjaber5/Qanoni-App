import 'package:flutter/material.dart';

import 'services_card_notif_item.dart';

class ServicesCardListViewNofification extends StatelessWidget {
  const ServicesCardListViewNofification({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height * 0.785,
      child: ListView.builder(
        padding: EdgeInsets.zero,
        itemCount: 10,
        itemBuilder: (context, index) {
          return const ServicesCardNotifItem(
            notifications: [],
          );
        },
      ),
    );
  }
}
