import 'package:flutter/material.dart';
import 'package:qanoni/core/widgets/create_contract_app_bar.dart';
import 'package:qanoni/features/payment/presentation/view/widget/payment_details_view_body.dart';

class PaymentDetailsView extends StatelessWidget {
  const PaymentDetailsView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(
        title: 'Payment Details',
        onPressed: () {
          Navigator.pop(context);
        },
      ),
      body: const PaymentDetailsViewBody(),
    );
  }
}
