import 'package:flutter/material.dart';
import 'package:qanoni/constant.dart';

import '../../../data/modelnotification.dart';

class ServicesCardNotifItem extends StatelessWidget {
  final List<NotificationItem> notifications;
  const ServicesCardNotifItem({super.key, required this.notifications});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: Column(
        children: [
          Container(
            width: MediaQuery.of(context).size.width * 0.9,
            height: MediaQuery.of(context).size.height * 0.15,
            padding: const EdgeInsets.symmetric(vertical: 7),
            decoration: BoxDecoration(
              color: kWhiteColor.withOpacity(0.1),
              borderRadius: BorderRadius.circular(12),
            ),
            child: const Column(
              children: [
                Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Row(
                    children: [
                      CircleAvatar(
                        radius: 20,
                        backgroundImage:
                            NetworkImage("https://via.placeholder.com/150"),
                      ),
                      SizedBox(width: 20),
                      Text("@username"),
                    ],
                  ),
                ),
                Text("Notification Descreption")
              ],
            ),
          ),
        ],
      ),
    );
  }
}
