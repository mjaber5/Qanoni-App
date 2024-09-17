import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:qanoni/core/utils/constants/colors.dart';
import 'package:qanoni/core/utils/styles.dart';
import 'package:qanoni/core/widgets/app_text_form_field.dart';

class ContractInputFormCar extends StatefulWidget {
  const ContractInputFormCar({super.key});

  @override
  _ContractInputFormState createState() => _ContractInputFormState();
}

class _ContractInputFormState extends State<ContractInputFormCar> {
  final _formKey = GlobalKey<FormState>();

  // Controllers for text fields
  final TextEditingController landlordNameController =
      TextEditingController(); // Landlord Name
  final TextEditingController landlordIdController =
      TextEditingController(); // Landlord ID
  final TextEditingController tenantNameController =
      TextEditingController(); // Tenant Name
  final TextEditingController tenantIdController =
      TextEditingController(); // Tenant ID
  final TextEditingController carModelController =
      TextEditingController(); // Car Model
  final TextEditingController carTypeController =
      TextEditingController(); // Car Type
  final TextEditingController carColorController =
      TextEditingController(); // Car Color
  final TextEditingController engineCapacityController =
      TextEditingController(); // Engine Capacity
  final TextEditingController rentAmountController =
      TextEditingController(); // Rent Amount
  final TextEditingController startDateController =
      TextEditingController(); // Contract Start Date
  final TextEditingController contractDurationController =
      TextEditingController(); // Contract Duration

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Enter Car Rental Contract Information'),
        backgroundColor: QColors.secondary,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              // Landlord Name
              buildLabeledTextField(
                label: 'Landlord Name',
                controller: landlordNameController,
                validatorMessage: 'Please enter the landlord\'s name',
              ),
              const SizedBox(height: 16),

              // Landlord ID
              buildLabeledTextField(
                label: 'Landlord ID',
                controller: landlordIdController,
                validatorMessage: 'Please enter the landlord\'s ID number',
              ),
              const SizedBox(height: 16),

              // Tenant Name
              buildLabeledTextField(
                label: 'Tenant Name',
                controller: tenantNameController,
                validatorMessage: 'Please enter the tenant\'s name',
              ),
              const SizedBox(height: 16),

              // Tenant ID
              buildLabeledTextField(
                label: 'Tenant ID',
                controller: tenantIdController,
                validatorMessage: 'Please enter the tenant\'s ID number',
              ),
              const SizedBox(height: 16),

              // Car Type
              buildLabeledTextField(
                label: 'Car Type',
                controller: carTypeController,
                validatorMessage: 'Please enter the car type',
              ),
              const SizedBox(height: 16),

              // Car Model
              buildLabeledTextField(
                label: 'Car Model',
                controller: carModelController,
                validatorMessage: 'Please enter the car model',
              ),
              const SizedBox(height: 16),

              // Car Color
              buildLabeledTextField(
                label: 'Car Color',
                controller: carColorController,
                validatorMessage: 'Please enter the car color',
              ),
              const SizedBox(height: 16),

              // Engine Capacity
              buildLabeledTextField(
                label: 'Engine Capacity',
                controller: engineCapacityController,
                validatorMessage: 'Please enter the engine capacity',
              ),
              const SizedBox(height: 16),

              // Rent Amount
              buildLabeledTextField(
                label: 'Rent Amount',
                controller: rentAmountController,
                validatorMessage: 'Please enter the rent amount',
              ),
              const SizedBox(height: 16),

              // Contract Start Date
              buildLabeledTextField(
                label: 'Contract Start Date',
                controller: startDateController,
                validatorMessage: 'Please enter the contract start date',
              ),
              const SizedBox(height: 16),

              // Contract Duration
              buildLabeledTextField(
                label: 'Contract Duration',
                controller: contractDurationController,
                validatorMessage: 'Please enter the contract duration',
              ),
              const SizedBox(height: 32),

              // Submit Bu,tton
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
