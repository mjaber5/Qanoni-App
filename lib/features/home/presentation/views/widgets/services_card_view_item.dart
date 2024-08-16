import 'package:flutter/material.dart';
import 'package:qanoni/constant.dart';
import 'package:qanoni/core/utils/styles.dart';

class ServicesCardItem extends StatelessWidget {
  const ServicesCardItem({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: Column(
        children: [
          Container(
            width: MediaQuery.of(context).size.width * 0.9,
            height: MediaQuery.of(context).size.height * 0.15,
            padding: const EdgeInsets.symmetric(vertical: 12),
            decoration: BoxDecoration(
              color: kWhiteColor.withOpacity(0.1),
              borderRadius: BorderRadius.circular(12),
            ),
            child: const Column(
              children: [
                Text(
                  'Services name ',
                  style: Styles.textStyle20,
                ),
                SizedBox(height: 10),
                Text(
                  'Department name',
                  style: Styles.textStyle14,
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
