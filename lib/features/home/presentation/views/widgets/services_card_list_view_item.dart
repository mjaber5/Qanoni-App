import 'package:flutter/material.dart';
import 'package:qanoni/features/home/data/card_model.dart';
import 'package:qanoni/features/home/presentation/views/card/card_view.dart';
// import 'package:qanoni/features/home/presentation/views/widgets/services_card_view_item.dart';

class ServicesCardListViewItem extends StatelessWidget {
  const ServicesCardListViewItem({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height * 0.8,
      child: ListView.builder(
        padding: EdgeInsets.zero,
        itemCount: cardModels.length,
        itemBuilder: (context, index) {
          return  const CardView();
        },
      ),
    );
  }
}
