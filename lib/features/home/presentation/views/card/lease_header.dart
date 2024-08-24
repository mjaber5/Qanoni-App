import 'package:flutter/material.dart';
import 'package:qanoni/core/utils/constants/colors.dart';

class LeaseHeader extends StatelessWidget {
  const LeaseHeader({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
       Container(
         width: MediaQuery.of(context).size.width * 1,
         height: MediaQuery.of(context).size.height * 0.20,
         decoration: const BoxDecoration(
         
         
         color:  QColors.secondary,
         borderRadius: BorderRadius.only(bottomRight: Radius.circular(50),
         bottomLeft: Radius.circular(50)
         )
       ),
       
       
       ),
      
    
      ]
    );
  }
}
