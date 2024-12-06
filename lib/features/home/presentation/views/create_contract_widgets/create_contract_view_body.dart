import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:qanoni/core/utils/app_router.dart';
import 'package:qanoni/core/widgets/create_contract_app_bar.dart';

class CreateContractViewBody extends StatelessWidget {
  const CreateContractViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        buildAppBar(
          title: 'Create contract',
          onPressed: () {
            GoRouter.of(context).pushReplacement(AppRouter.kLayout);
          },
        ),
        const Center(
          child: Text('Hello World'),
        ),
      ],
    );
  }
}
