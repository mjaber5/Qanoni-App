import 'package:flutter/material.dart';
import 'package:qanoni/core/utils/constants/aceapt_page.dart';
import 'package:qanoni/core/utils/constants/colors.dart';
import 'package:qanoni/features/home/presentation/views/card/lease_card/lease_card_view_file/car_rental_contact/acept_care.dart';
import 'package:qanoni/features/home/presentation/views/card/lease_card/lease_card_view_file/house_rental_contact/aceapt_house.dart';

class LeaseCard extends StatelessWidget {
  const LeaseCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: Column(
         
          
          children: [
        
          InkWell(
                onTap: (){
                  Navigator.push(context, MaterialPageRoute(builder: (context) => const AceptCare()));
                   
                },
                child: Container(
                  width: MediaQuery.of(context).size.width * 0.9,
                  height: MediaQuery.of(context).size.height * 0.15,
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
                           "Car rental contract عقد ايجار سيارة"
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
                  Navigator.push(context, MaterialPageRoute(builder: (context) => const AceaptHouse()));
                   
                },
                child: Container(
                  width: MediaQuery.of(context).size.width * 0.9,
                  height: MediaQuery.of(context).size.height * 0.15,
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
                           "House rent contract عقد ايجار بيت"
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
                  Navigator.push(context, MaterialPageRoute(builder: (context) => const AceaptPage()));
                   
                },
                child: Container(
                  width: MediaQuery.of(context).size.width * 0.9,
                  height: MediaQuery.of(context).size.height * 0.15,
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
                           "Equipment rental contract عقد ايجار معدات"
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
                  Navigator.push(context, MaterialPageRoute(builder: (context) => const AceaptPage()));
                   
                },
                child: Container(
                  width: MediaQuery.of(context).size.width * 0.9,
                  height: MediaQuery.of(context).size.height * 0.15,
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
                           "Daily rent contract عقد ايجار مياومة"
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
                  Navigator.push(context, MaterialPageRoute(builder: (context) => const AceaptPage()));
                   
                },
                child: Container(
                  width: MediaQuery.of(context).size.width * 0.9,
                  height: MediaQuery.of(context).size.height * 0.15,
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
                           "Rental contract cancellation form نموذج الغاء عقد ايجار "
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
      ),
    ) ;
  }
}