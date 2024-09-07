// import 'package:card/employment_card.dart';
// import 'package:card/lease_card.dart';
// import 'package:card/purchase_card.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:qanoni/core/utils/app_router.dart';
import 'package:qanoni/core/utils/constants/colors.dart';
import 'package:qanoni/features/home/presentation/views/card/employment%20card/employment_card.dart';

class CardView extends StatelessWidget {
  const CardView({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
       
        
        children: [
      
        InkWell(
              onTap: (){
                // Navigator.push(context, MaterialPageRoute(builder: (context) => const LeaseCard()));
                 GoRouter.of(context).push(AppRouter.kLeaseCard);
               
              },
              child: Container(
                width: MediaQuery.of(context).size.width * 0.9,
                height: MediaQuery.of(context).size.height * 0.13,
                padding: const EdgeInsets.symmetric(vertical: 12),
                decoration: BoxDecoration(
                  color: QColors.darkerGrey.withOpacity(0.5),
                  borderRadius: BorderRadius.circular(12),
                ),
                child:  const Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Center(
                        child: Text(
                         "Lease contracts"
                        ),
                      ),
                      Spacer(),
                      
                      
                    ],
                  ),
                ),
              ),
            ),
            SizedBox( height: MediaQuery.of(context).size.height * 0.01,),
         
        InkWell(
              onTap: (){
                // Navigator.push(context, MaterialPageRoute(builder: (context) => const PurchaseCard()));
                 GoRouter.of(context).push(AppRouter.kPurchaseCard);
                 
              },
              child: Container(
                width: MediaQuery.of(context).size.width * 0.9,
                height: MediaQuery.of(context).size.height * 0.13,
                padding: const EdgeInsets.symmetric(vertical: 12),
                decoration: BoxDecoration(
                  color: QColors.darkerGrey.withOpacity(0.5),
                  borderRadius: BorderRadius.circular(12),
                ),
                child:  const Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Center(
                        child: Text(
                         "Purchase contracts"
                        ),
                      ),
                      Spacer(),
                      
                      
                    ],
                  ),
                ),
              ),
            ),
            SizedBox( height: MediaQuery.of(context).size.height * 0.01,),
         
        InkWell(
              onTap: (){
                Navigator.push(context, MaterialPageRoute(builder: (context) => const EmploymentCard()));
                //  GoRouter.of(context).push(AppRouter.kEmploymentCard);
                 
              },
              child: Container(
                width: MediaQuery.of(context).size.width * 0.9,
                height: MediaQuery.of(context).size.height * 0.13,
                padding: const EdgeInsets.symmetric(vertical: 12),
                decoration: BoxDecoration(
                  color: QColors.darkerGrey.withOpacity(0.5),
                  borderRadius: BorderRadius.circular(12),
                ),
                child:  const Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Center(
                        child: Text(
                         "Employment contracts"
                        ),
                      ),
                      Spacer(),
                      
                      
                    ],
                  ),
                ),
              ),
            ),
      ],
      
      ),
    ) ;
  }
}