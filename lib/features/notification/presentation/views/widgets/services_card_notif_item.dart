import 'package:flutter/material.dart';
import '../../../../../core/utils/constants/colors.dart';

import '../../../data/modelnotification.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';


class ServicesCardNotifItem extends StatelessWidget {
  final List<NotificationItem> notifications;
  const ServicesCardNotifItem({super.key, required this.notifications});

  @override
  Widget build(BuildContext context) {
    final localizations = AppLocalizations.of(context)!;
    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: Column(
        children: [
          Container(
            width: MediaQuery.of(context).size.width * 0.95,
            height: MediaQuery.of(context).size.height * 0.15,
            padding: const EdgeInsets.symmetric(vertical: 10),
            decoration: BoxDecoration(
              color: QColors.darkerGrey.withOpacity(0.4),
              borderRadius: BorderRadius.circular(12),
            ),
            child:  Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    children: [
                      const CircleAvatar(
                        radius: 20,
                        backgroundImage:
                            NetworkImage("https://via.placeholder.com/150"),
                      ),
                      const SizedBox(width: 20),
                      Text(localizations.userNameNotification),
                      const Spacer(),
                      const Text("12:00"),
                      const SizedBox(width: 20),
                    ],
                  ),
                ),
                Text(localizations.notificatiomDescreption)
              ],
            ),
          ),
        ],
      ),
    );
  }
}
