import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:qanoni/core/utils/app_router.dart';
import 'package:qanoni/core/utils/constants/colors.dart';
import 'package:qanoni/core/utils/styles.dart';
import 'package:qanoni/features/home/data/card_model.dart';


class ServicesCardItem extends StatefulWidget {

  final CardModel cardModels;
  const ServicesCardItem({super.key,  required this.cardModels});

  @override
  State<ServicesCardItem> createState() => _ServicesCardItemState();
}

class _ServicesCardItemState extends State<ServicesCardItem> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: Column(
        children: [
          InkWell(
            onTap: (){
              
               GoRouter.of(context).push(AppRouter.kLeaseCard);
            },
            child: Container(
              width: MediaQuery.of(context).size.width * 0.9,
              height: MediaQuery.of(context).size.height * 0.15,
              padding: const EdgeInsets.symmetric(vertical: 12),
              decoration: BoxDecoration(
                color: QColors.darkerGrey.withOpacity(0.5),
                borderRadius: BorderRadius.circular(12),
              ),
              child:  Column(
                children: [
                  Text(
                   widget.cardModels.servicname,
                    style: Styles.textStyle20,
                  ),
                  const SizedBox(height: 10),
                 
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
