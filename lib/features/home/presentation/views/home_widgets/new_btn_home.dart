import 'package:flutter/material.dart';


import '../new widgets dialog/waiver_contract_dialog.dart';

class NewBtnHome extends StatelessWidget {
  const NewBtnHome({super.key});

  @override
  Widget build(BuildContext context) {
    return  Padding(
      padding: const EdgeInsets.all(8.0),
      child: ElevatedButton(onPressed: (){
         showWaiverContractDialog(context);

      },
       child: const Text("Start a New Contracts")),
    );
  }
}