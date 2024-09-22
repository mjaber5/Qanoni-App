import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:qanoni/core/utils/constants/colors.dart';
import 'package:qanoni/core/utils/styles.dart';
import 'package:qanoni/core/widgets/app_text_form_field.dart';

class ContractInputFormCarSales extends StatefulWidget {
  const ContractInputFormCarSales({super.key});

  @override
  State<ContractInputFormCarSales> createState() =>
      _ContractInputFormCarSalesState();
}

class _ContractInputFormCarSalesState extends State<ContractInputFormCarSales> {
  final _formKey = GlobalKey<FormState>();

  // Controllers for form fields
  final TextEditingController sellerNameController = TextEditingController();
  final TextEditingController sellerIdController = TextEditingController();
  final TextEditingController sellerAddressController = TextEditingController();
  final TextEditingController buyerNameController = TextEditingController();
  final TextEditingController buyerIdController = TextEditingController();
  final TextEditingController buyerAddressController = TextEditingController();
  final TextEditingController carBrandController = TextEditingController();
  final TextEditingController carModelController = TextEditingController();
  final TextEditingController carYearController = TextEditingController();
  final TextEditingController vinController =
      TextEditingController(); // Vehicle Identification Number (VIN)
  final TextEditingController mechanicalConditionController =
      TextEditingController();
  final TextEditingController ownershipController = TextEditingController();
  final TextEditingController sellingPriceController = TextEditingController();
  final TextEditingController paymentMethodController = TextEditingController();
  final TextEditingController saleDateController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Enter Car Sale Contract Information'),
        backgroundColor: QColors.secondary,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              // Seller Information Section
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

              // Buyer Information Section
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

              // Car Information Section
              const Text(
                'Car Information',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              buildLabeledTextField(
                label: 'Car Brand',
                controller: carBrandController,
                validatorMessage: 'Please enter the car brand',
              ),
              const SizedBox(height: 16),
              buildLabeledTextField(
                label: 'Car Model',
                controller: carModelController,
                validatorMessage: 'Please enter the car model',
              ),
              const SizedBox(height: 16),
              buildLabeledTextField(
                label: 'Year of Manufacture',
                controller: carYearController,
                validatorMessage: 'Please enter the year of manufacture',
              ),
              const SizedBox(height: 16),
              buildLabeledTextField(
                label: 'VIN (Vehicle Identification Number)',
                controller: vinController,
                validatorMessage: 'Please enter the VIN',
              ),
              const SizedBox(height: 16),
              buildLabeledTextField(
                label: 'Mechanical Condition',
                controller: mechanicalConditionController,
                validatorMessage: 'Please enter the mechanical condition',
              ),
              const SizedBox(height: 16),
              buildLabeledTextField(
                label: 'Ownership Status',
                controller: ownershipController,
                validatorMessage: 'Please enter the ownership status',
              ),
              const SizedBox(height: 32),

              // Transaction Information Section
              const Text(
                'Transaction Information',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              buildLabeledTextField(
                label: 'Selling Price',
                controller: sellingPriceController,
                validatorMessage: 'Please enter the selling price',
              ),
              const SizedBox(height: 16),
              buildLabeledTextField(
                label: 'Payment Method',
                controller: paymentMethodController,
                validatorMessage: 'Please enter the payment method',
              ),
              const SizedBox(height: 16),
              buildLabeledTextField(
                label: 'Sale Date',
                controller: saleDateController,
                validatorMessage: 'Please enter the sale date',
              ),
              const SizedBox(height: 32),

              // Submit Button
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

  // Helper function to build a labeled text field
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
