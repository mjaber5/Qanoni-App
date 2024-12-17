import 'package:flutter/material.dart';

import 'view_contract_info.dart';

class ViewCarInfo extends StatelessWidget {
  const ViewCarInfo({super.key});

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
            appBar: AppBar(title: const Text('View Car Info'),),

      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            const Text('Car Info'),
        
            ElevatedButton(onPressed: (){
                  Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const ViewContractInfo()), 
            );
                }, child: const Text('Next Step'))
          ],
        ),
      ),
    );
  }
}