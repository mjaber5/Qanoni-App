import 'package:flutter/material.dart';
import 'package:qanoni/features/home/presentation/views/create_contract_widgets/create_contract_view_body.dart';

class CreateContractView extends StatelessWidget {
  const CreateContractView({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: CreateContractViewBody(),
    );
  }
}
