import 'package:flutter/material.dart';

import '../../../../../../core/utils/constants/colors.dart';

class ContactIformation extends StatelessWidget {
  const ContactIformation({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12.0, horizontal: 12),
      child: Container(
        width: MediaQuery.of(context).size.width * 0.95,
        height: MediaQuery.of(context).size.height * 0.2,
        decoration: BoxDecoration(
          color: QColors.darkerGrey.withOpacity(0.4),
          borderRadius: BorderRadius.circular(30),
        ),
        child: const Padding(
          padding: EdgeInsets.symmetric(horizontal: 18, vertical: 20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Contact Information : mhammdjbr@gmail.com',
              ),
              Text(
                'Website : github/mjaber5',
              ),
              Text(
                'NCC : 0779294486 ',
              ),
            ],
          ),
        ),
      ),
    );
  }
}
