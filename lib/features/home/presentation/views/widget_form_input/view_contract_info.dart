import 'package:flutter/material.dart';

class ViewContractInfo extends StatelessWidget {
  const ViewContractInfo({super.key});

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: AppBar(title: const Text('View Contract Info'),),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
          const Text('Contract Info'),
           ElevatedButton(
                  onPressed: () {
                   
                  },
                  child: const Text('حفظ البيانات'),
                ),
        
        ],),
      ),
    );
  }
}