import 'package:flutter/material.dart';
import 'package:qanoni/core/utils/constants/aceapt_page.dart';
import 'package:qanoni/core/utils/constants/colors.dart';

class PurchaseCard extends StatelessWidget {
  const PurchaseCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: SingleChildScrollView(
          child: Column(
           
            
            children: [
          
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
                              "Ministry work model نموذج عمل وزارة"                            ),
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
                             "Recruitment of work استقدام عمل"                            ),
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
                              "Public services contract عقد خدمات عامة"                            ),
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
                            "Make an agreement عقد اتفاق"                            ),
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
                           "Termination of an employment contract by the employee انهاء عقد عمل من قبل الموظف"                            ),
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
                            "Contracting agreement اتفاقية مقاولة "
                            ),
                          ),
                          Spacer(),
                          
                          
                        ],
                      ),
                    ),
                  ),
                ),
                SizedBox( height: MediaQuery.of(context).size.height * 0.01,),
          ],
          
          ),
        ),
      ),
    ) ;
  }
}