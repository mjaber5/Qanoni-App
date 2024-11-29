import 'package:flutter/material.dart';
import 'package:qanoni/features/notification/presentation/views/widgets/widget/screnhome.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../../../core/utils/styles.dart';



class NotificationView extends StatelessWidget {
  const NotificationView({super.key});

  @override
  Widget build(BuildContext context) {
        final localizations = AppLocalizations.of(context)!;

    return  Scaffold(
      appBar: AppBar(title: 
      Padding(
      padding: const EdgeInsets.only(right: 24, left: 14, top: 15, bottom: 10),
      child: Row(
        children: [
          Text(
            localizations.notificationScreen,
            style: Styles.textStyle30,
            textAlign: TextAlign.center,
          ),
        ],
      ),
    ),),
       body: const Padding(
         padding: EdgeInsets.only(top: 20),
         child: Screnhome(),
       ),
    );
  }
}
