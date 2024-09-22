import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:qanoni/core/utils/constants/colors.dart';
import 'package:qanoni/core/utils/styles.dart';
import 'package:qanoni/core/widgets/app_text_form_field.dart';

class ContractInputFormWaiverCar extends StatefulWidget {
  const ContractInputFormWaiverCar({super.key});

  @override
  _ContractInputFormWaiverState createState() =>
      _ContractInputFormWaiverState();
}

class _ContractInputFormWaiverState extends State<ContractInputFormWaiverCar> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController sellerNameController = TextEditingController();
  final TextEditingController sellerIdController = TextEditingController();
  final TextEditingController sellerAddressController = TextEditingController();
  final TextEditingController buyerNameController = TextEditingController();
  final TextEditingController buyerIdController = TextEditingController();
  final TextEditingController buyerAddressController = TextEditingController();
  final TextEditingController assetTypeController = TextEditingController();
  final TextEditingController assetDetailsController = TextEditingController();
  final TextEditingController waiverReasonController = TextEditingController();
  final TextEditingController ownershipController = TextEditingController();
  final TextEditingController waiverPriceController = TextEditingController();
  final TextEditingController paymentMethodController = TextEditingController();
  final TextEditingController waiverDateController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Enter Waiver Contract Information'),
        backgroundColor: QColors.secondary,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              const Text(
                'Seller Information',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              buildLabeledTextField(
                label: 'Seller Name',
                controller: sellerNameController,
                validatorMessage: 'Please enter the seller\'s name',
              ),
              const SizedBox(height: 16),
              buildLabeledTextField(
                label: 'Seller ID',
                controller: sellerIdController,
                validatorMessage: 'Please enter the seller\'s ID',
              ),
              const SizedBox(height: 16),
              buildLabeledTextField(
                label: 'Seller Address',
                controller: sellerAddressController,
                validatorMessage: 'Please enter the seller\'s address',
              ),
              const SizedBox(height: 32),

              const Text(
                'Buyer Information',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              buildLabeledTextField(
                label: 'Buyer Name',
                controller: buyerNameController,
                validatorMessage: 'Please enter the buyer\'s name',
              ),
              const SizedBox(height: 16),
              buildLabeledTextField(
                label: 'Buyer ID',
                controller: buyerIdController,
                validatorMessage: 'Please enter the buyer\'s ID',
              ),
              const SizedBox(height: 16),
              buildLabeledTextField(
                label: 'Buyer Address',
                controller: buyerAddressController,
                validatorMessage: 'Please enter the buyer\'s address',
              ),
              const SizedBox(height: 32),

              const Text(
                'Waiver Information',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              buildLabeledTextField(
                label: 'Asset Type',
                controller: assetTypeController,
                validatorMessage: 'Please enter the asset type',
              ),
              const SizedBox(height: 16),
              buildLabeledTextField(
                label: 'Asset Details',
                controller: assetDetailsController,
                validatorMessage: 'Please enter asset details',
              ),
              const SizedBox(height: 16),
              buildLabeledTextField(
                label: 'Reason for Waiver',
                controller: waiverReasonController,
                validatorMessage: 'Please enter the reason for waiver',
              ),
              const SizedBox(height: 16),
              buildLabeledTextField(
                label: 'Ownership Status',
                controller: ownershipController,
                validatorMessage: 'Please enter the ownership status',
              ),
              const SizedBox(height: 32),

              const Text(
                'Transaction Information',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              buildLabeledTextField(
                label: 'Waiver Price',
                controller: waiverPriceController,
                validatorMessage: 'Please enter the waiver price',
              ),
              const SizedBox(height: 16),
              buildLabeledTextField(
                label: 'Payment Method',
                controller: paymentMethodController,
                validatorMessage: 'Please enter the payment method',
              ),
              const SizedBox(height: 16),
              buildLabeledTextField(
                label: 'Waiver Date',
                controller: waiverDateController,
                validatorMessage: 'Please enter the waiver date',
              ),
              const SizedBox(height: 32),

              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 18),
                child: ElevatedButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      log('Form is valid. Proceed with saving the contract.');
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                            content: Text('Data entered successfully')),
                      );
                    } else {
                      log('Form is not valid. Show errors.');
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 15),
                    backgroundColor: QColors.secondary,
                  ),
                  child: const Text(
                    "Save",
                    style: Styles.textStyle18,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildLabeledTextField({
    required String label,
    required TextEditingController controller,
    required String validatorMessage,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: Styles.textStyle18.copyWith(color: QColors.secondary),
        ),
        const SizedBox(height: 8),
        AppTextFormField(
          controller: controller,
          hintText: label,
          validator: (value) {
            if (value == null || value.isEmpty) {
              return validatorMessage;
            }
            return null;
          },
        ),
      ],
    );
  }
}
